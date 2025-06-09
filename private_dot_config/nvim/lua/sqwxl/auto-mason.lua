-- conform formatter to mason package mapping
-- https://mason-registry.dev/registry/list
local conform_to_mason = {
	bsfmt = "brighterscript-formatter",
	cmake_format = "cmakelang",
	dcm_fix = "dcm",
	dcm_format = "dcm",
	deno_fmt = "deno",
	elm_format = "elm-format",
	erb_format = "erb-formatter",
	hcl = "hclfmt",
	["lua-format"] = "luaformatter",
	nixpkgs_fmt = "nixpkgs-fmt",
	opa_fmt = "opa",
	php_cs_fixer = "php-cs-fixer",
	["purs-tidy"] = "purescript-tidy",
	ruff_fix = "ruff",
	ruff_format = "ruff",
	ruff_organize_imports = "ruff",
	sql_formatter = "sql-formatter",
}

local lint_to_mason = {
	biomejs = "biome",
}

local function to_mason_package(name)
	return conform_to_mason[name] or lint_to_mason[name] or name
end

local function get_conform_packages()
	local formatters_by_ft = require("conform").formatters_by_ft
	local result = {}
	for _, formatters in pairs(formatters_by_ft) do
		for _, formatter in pairs(formatters) do
			if type(formatter) == "table" then
				for _, f in pairs(formatter) do
					result[to_mason_package(f)] = 1
				end
			else
				result[to_mason_package(formatter)] = 1
			end
		end
	end

	return result
end

local function get_lint_packages()
	local linters_by_ft = require("lint").linters_by_ft
	local result = {}

	for _, linters in pairs(linters_by_ft) do
		for _, linter in pairs(linters) do
			result[to_mason_package(linter)] = 1
		end
	end

	return result
end

local function get_lsp_packages()
	local result = {}
	return result
end

local function get_packages_to_install()
	local result = {}

	for p, _ in pairs(get_conform_packages()) do
		result[p] = 1
	end

	for p, _ in pairs(get_lint_packages()) do
		result[p] = 1
	end

	for p, _ in pairs(get_lsp_packages()) do
		result[p] = 1
	end

	return result
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

local M = {}

function M.install()
	local packages = get_packages_to_install()
	vim.print(packages)
	for name, _ in pairs(packages) do
		if name ~= nil then
			try_install(name)
		end
	end
end

return M
