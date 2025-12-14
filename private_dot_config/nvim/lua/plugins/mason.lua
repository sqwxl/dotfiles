-- conform formatter/nvim linter to mason package mapping
-- https://mason-registry.dev/registry/list
local alias_to_mason_name = {
	bashls = "bash-language-server",
	biomejs = "biome",
	["biome-check"] = "biome",
	["biome-organize-imports"] = "biome",
	bsfmt = "brighterscript-formatter",
	cmake_format = "cmakelang",
	dcm_fix = "dcm",
	dcm_format = "dcm",
	deno_fmt = "deno",
	dockerls = "dockerfile-language-server",
	docker_compose_language_service = "docker-compose-language-service",
	elm_format = "elm-format",
	erb_format = "erb-formatter",
	erb_lint = "erb-lint",
	fish_lsp = "fish-lsp",
	harper_ls = "harper-ls",
	html = "html-lsp",
	hcl = "hclfmt",
	just = "just-lsp",
	jsonls = "json-lsp",
	lua_ls = "lua-language-server",
	["lua-format"] = "luaformatter",
	nixpkgs_fmt = "nixpkgs-fmt",
	opa_fmt = "opa",
	php_cs_fixer = "php-cs-fixer",
	["purs-tidy"] = "purescript-tidy",
	ruby_lsp = "ruby-lsp",
	ruff_fix = "ruff",
	ruff_format = "ruff",
	ruff_organize_imports = "ruff",
	sql_formatter = "sql-formatter",
	terraformls = "terraform-ls",
	terraform_validate = "terraform",
	terraform_fmt = "terraform",
	ts_ls = "typescript-language-server",
	vue_ls = "vue-language-server",
	xmlformat = "xmlformatter",
	yamlls = "yaml-language-server",
}

local ignore_package = {
	pint = true,
}

local function to_mason_package_name(name)
	local mason_name = alias_to_mason_name[name]
	if mason_name == nil then
		return name
	elseif mason_name then
		return mason_name
	end
	return nil
end

local function get_conform_packages()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return {}
	end
	return vim.iter(conform.list_all_formatters())
		:map(function(v)
			return v["name"]
		end)
		:totable()
end

local function get_lint_packages()
	local ok, lint = pcall(require, "lint")
	if not ok then
		return {}
	end
	local t = vim.iter(lint.linters_by_ft)
		:map(function(_, linters)
			return linters
		end)
		:filter(function(l)
			return #l > 0
		end)
		:totable()
	return vim.iter(t):flatten():totable()
end

local function get_packages_to_install()
	local result = {}
	vim.list_extend(result, get_conform_packages())
	vim.list_extend(result, get_lint_packages())

	local seen = {}
	return vim.iter(result)
		:map(function(v)
			return to_mason_package_name(v)
		end)
		:filter(function(v)
			return v ~= nil and ignore_package[v] == nil
		end)
		:fold({}, function(acc, name)
			if seen[name] == nil then
				acc[#acc + 1] = name
				seen[name] = true
			end
			return acc
		end)
end

local function auto_install()
	local registry = require("mason-registry")
	local Optional = require("mason-core.optional")
	local Package = require("mason-core.package")

	local function resolve_package(mason_package_name)
		local ok, pkg = pcall(registry.get_package, mason_package_name)
		if ok then
			return Optional.of_nilable(pkg)
		end
	end

	local function install_package(pkg, version)
		local name = pkg.name
		Sqwxl.info(("installing %s"):format(name))
		return pkg:install({ version = version }):once(
			"closed",
			vim.schedule_wrap(function()
				if pkg:is_installed() then
					Sqwxl.info(("%s was successfully installed"):format(name))
				else
					Sqwxl.error(
						("failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(name)
					)
				end
			end)
		)
	end

	local function try_install(mason_package_name)
		local package_name, version = Package.Parse(mason_package_name)
		local resolved = resolve_package(package_name)
		if resolved == nil then
			return
		end

		resolved
			:if_present(function(pkg)
				if vim.fn.executable(vim.tbl_keys(pkg.spec.bin)[1]) == 1 then
					return
				end
				if not pkg:is_installed() then
					if require("mason.version").MAJOR_VERSION == 2 then
						if pkg:is_installing() then
							return
						end
					end
					install_package(pkg, version)
				end
			end)
			:if_not_present(function()
				Sqwxl.warn(("%q is not a valid mason package name"):format(package_name))
			end)
	end

	for _, name in ipairs(get_packages_to_install()) do
		if name ~= nil then
			local ok, err = pcall(try_install, name)
			if err ~= nil then
				Sqwxl.error(name .. ": " .. err)
			end
		end
	end
end

return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {},
		config = function(_, opts)
			require("mason").setup(opts)
			Sqwxl.on_very_lazy(auto_install)
		end,
		keys = { { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" } },
	},
}
