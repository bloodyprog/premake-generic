-- blueprint

premake.modules.blueprint = {}

local m = premake.modules.blueprint
local p = premake

local splitProjects = true

newaction {
    trigger = "blueprint",
    description = "Generate a Blueprint project.",

    onStart = function()
        p.indent('  ')
    end,

    onWorkspace = function(wks)
        p.generate(wks, ".wks.json", m.GenerateWorkspace)
    end,

    onProject = function(prj)
        if splitProjects then
            p.generate(prj, ".prj.json", m.GenerateProject)
        end
    end
}

function m.GenerateWorkspace(wks)
    p.w('{')
    p.push()

    p.x('"workspace": "%s",', wks.name)

    m.AddProjects(wks)

    p.pop()
    p.w('}')
end

function m.GenerateProject(prj)
    m.AddProject(prj)
end

function m.AddProjects(wks)
    p.x('"projects": [')
    p.push()

    local count = #wks.projects
    for i, prj in ipairs(wks.projects) do
        if splitProjects then
            p.x('"%s"%s', string.format("%s.prj.json", prj.name), AddComma(i < count))
        else
            m.AddProject(prj, i < count)
        end
    end

    p.pop()
    p.w(']')
end

function m.AddProject(prj, comma)
    p.w('{')
    p.push()

    p.x('"project": "%s",', prj.name)

    m.AddConfigs(prj)
    m.AddFiles(prj)

    p.pop()
    p.x('}%s', AddComma(comma))
end

function m.AddConfigs(prj)
    p.x('"configs": [')
    p.push()

    local configs = m.GatherConfigs(prj)
    local count = #configs
    for i, cfg in ipairs(configs) do
        m.AddConfig(prj, cfg, i < count)
    end

    p.pop()
    p.w('],')
end

function m.AddConfig(prj, cfg, comma)
    p.w('{')
    p.push()

    p.x('"name": "%s",', cfg.name)

    m.AddDefines(cfg)
    m.AddIncludeDirectories(prj, cfg)
    m.AddPrecompiledHeader(prj, cfg)

    p.pop()
    p.x('}%s', AddComma(comma))
end

function m.AddDefines(cfg)
    p.w('"defines": [')
    p.push()

    local count = #cfg.defines
    for i, define in ipairs(cfg.defines) do
        p.x('"%s"%s', define, AddComma(i < count))
    end

    p.pop()
    p.w('],')
end

function m.AddIncludeDirectories(prj, cfg)
    p.w('"includedirs": [')
    p.push()

    local count = #cfg.includedirs
    for i, include in ipairs(cfg.includedirs) do
        p.x('"%s"%s', p.project.getrelative(prj, include), AddComma(i < count))
    end

    p.pop()
    p.w('],')
end

function m.AddPrecompiledHeader(prj ,cfg)
    p.x('"pchsource": %s', AddQuotedOrNil(p.project.getrelative(prj, cfg.pchsource)))
end

function m.GatherConfigs(prj)
    local configs = {}

    for cfg in p.project.eachconfig(prj) do
        table.insert(configs, cfg)
    end

    return configs
end

function m.AddFiles(prj)
    p.x('"files": [')
    p.push()

    local files = m.GatherFiles(prj)
    local count = #files
    for i, file in ipairs(files) do
        p.x('"%s"%s', file, AddComma(i < count))
    end

    p.pop()
    p.w(']')
end

function m.GatherFiles(prj)
    local files = {}

    local sourceTree = p.project.getsourcetree(prj, function(lhs, rhs)
        local istop = (lhs.parent.parent == nil)

        local lhsName = lhs.name
        local rhsName = rhs.name

        if lhs.relpath then
            if not rhs.relpath then
                return not istop
            end
            lhsName = lhs.relpath:gsub("%.%.%/", "")
        end

        if rhs.relpath then
            if not lhs.relpath then
                return istop
            end
            rhsName = rhs.relpath:gsub("%.%.%/", "")
        end

        return lhsName < rhsName
    end)

    p.tree.traverse(sourceTree, {
        onleaf = function(node)
            local file = node.relpath

            if path.iscppfile(file) or path.iscppheader(file) then
                table.insert(files, file)
            end
        end
    }, false)

    return files
end

function AddComma(condition)
    if condition then
        return ","
    else
        return ""
    end
end

function AddQuotedOrNil(value)
    if value then
        return '"' .. value .. '"'
    else
        return "null"
    end
end

return m
