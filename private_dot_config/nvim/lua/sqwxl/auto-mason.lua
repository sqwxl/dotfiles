-- conform formatter to mason package mapping
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
	fish = false,
	fish_lsp = false,
	fish_indent = false,
	gofmt = false,
	harper_ls = false,
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
	ruff_fix = "ruff",
	ruff_format = "ruff",
	ruff_organize_imports = "ruff",
	sql_formatter = "sql-formatter",
	terraformls = false,
	terraform_validate = false,
	terraform_fmt = false,
	ts_ls = "typescript-language-server",
	vue_ls = "vue-language-server",
	xmlformat = "xmlformatter",
	yamlls = "yaml-language-server",
}

local ignore_package = {
	pint = true,
}

local function to_mason_package_name(name)
	mason_name = alias_to_mason_name[name]
	if mason_name == nil then
		return name
	elseif mason_name then
		return mason_name
	end

	return nil
end

local function get_conform_packages()
	local formatters = require("conform").list_all_formatters()

	return vim.iter(formatters)
		:map(function(v)
			return v["name"]
		end)
		:totable()
end

local function get_lint_packages()
	local linters_by_ft = require("lint").linters_by_ft

	local t = vim.iter(linters_by_ft)
		:map(function(_, linters)
			return linters
		end)
		:filter(function(l)
			return #l > 0
		end)
		:totable()

	return vim.iter(t):flatten():totable()
end

local function get_lsp_packages()
	local result = {}

	for k, _ in pairs(require("config.lsp").configs) do
		result[#result + 1] = k
	end

	return result
end

local function get_packages_to_install()
	local result = {}

	vim.list_extend(result, get_conform_packages())
	vim.list_extend(result, get_lint_packages())
	vim.list_extend(result, get_lsp_packages())

	local seen = {}

	return vim
		.iter(result)
		-- convert to mason registry names
		:map(function(v)
			return to_mason_package_name(v)
		end)
		-- remove nils and ignored packages
		:filter(function(v)
			return v ~= nil and ignore_package[v] == nil
		end)
		-- remove duplicates
		:fold({}, function(acc, name)
			if seen[name] == nil then
				acc[#acc + 1] = name
				seen[name] = true
			end

			return acc
		end)
end

local registry = require("mason-registry")

local function resolve_package(mason_package_name)
	local Optional = require("mason-core.optional")

	local ok, pkg = pcall(registry.get_package, mason_package_name)
	if ok then
		return Optional.of_nilable(pkg)
	end
end

local function install_package(pkg, version)
	local name = pkg.name

	vim.notify(("installing %s"):format(name))

	return pkg:install({ version = version }):once(
		"closed",
		vim.schedule_wrap(function()
			if pkg:is_installed() then
				vim.notify(("%s was successfully installed"):format(name))
			else
				vim.notify(
					("failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(name),
					vim.log.levels.ERROR
				)
			end
		end)
	)
end

local function try_install(mason_package_name)
	local Package = require("mason-core.package")

	local package_name, version = Package.Parse(mason_package_name)

	resolve_package(package_name)
		:if_present(function(pkg)
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
			vim.notify(
				("Formatter %q is not a valid entry in ensure_installed. Make sure to only provide valid formatter names."):format(
					package_name
				),
				vim.log.levels.WARN
			)
		end)
end

return function()
	for _, name in ipairs(get_packages_to_install()) do
		if name ~= nil then
			ok, err = pcall(try_install, name)
			if err ~= nil then
				vim.notify(name .. ": " .. err, vim.log.levels.ERROR)
			end
		end
	end
end
