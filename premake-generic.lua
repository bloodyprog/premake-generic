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

    p.x('"workspace": "%s"', wks.name)

    p.pop()
    p.w('}')
end

return m
