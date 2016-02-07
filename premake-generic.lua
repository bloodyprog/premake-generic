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

    m.GenerateProjects(wks)

    p.pop()
    p.w('}')
end

function m.GenerateProjects(wks)
    p.x('"projects": [')
    p.push()

    local count = #wks.projects
    for i = 1, count do
        m.GenerateProject(wks.projects[i], i < count)
    end

    p.pop()
    p.w(']')
end

function m.GenerateProject(prj, comma)
    p.w('{')
    p.push()

    p.x('"name": "%s"', prj.name)

    p.pop()
    p.x('}%s', addComma(comma))
end

function addComma(condition)
    if condition then
        return ','
    else
        return ''
    end
end

return m
