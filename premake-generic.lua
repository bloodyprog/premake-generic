-- generic

premake.modules.generic = {}

local m = premake.modules.generic
local p = premake

newaction {
    trigger = "generic",
    description = "Generate a Generic project.",

    onStart = function()
        p.indent('  ')
    end,

    onWorkspace = function(wks)
        p.generate(wks, ".json", m.GenerateWorkspace)
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

function m.AddProjects(wks)
    p.x('"projects": [')
    p.push()

    local count = #wks.projects
    for i = 1, count do
        m.AddProject(wks.projects[i], i < count)
    end

    p.pop()
    p.w(']')
end

function m.AddProject(prj, comma)
    p.w('{')
    p.push()

    p.x('"name": "%s",', prj.name)

    m.AddFiles(prj)

    p.pop()
    p.x('}%s', AddComma(comma))
end

function m.AddFiles(prj)
    p.x('"files": [')
    p.push()

    local files = m.GatherFiles(prj)
    local count = #files
    for i = 1, count do
        p.x('"%s"%s', files[i], AddComma(i < count))
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

            if path.iscppfile(file) then
                table.insert(files, file)
            end
        end
    }, false)

    return files
end

function AddComma(condition)
    if condition then
        return ','
    else
        return ''
    end
end

return m
