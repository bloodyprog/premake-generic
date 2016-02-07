-- generic

premake.modules.generic {}

local m = premake.modules.generic

newaction {
    trigger = "generic",
    description = "Generate a Generic project.",

    onStart = function()
        print("testing Generic action!")
    end
}

return m
