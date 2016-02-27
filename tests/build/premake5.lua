
workspace( "Tests" )

    configurations( { "Debug", "Release" } )
        location( _ACTION )

    configuration( "Debug" )
        targetdir( "output/bin/debug" )
        objdir( "output/obj/debug" )

    configuration( "Release" )
        targetdir( "output/bin/release" )
        objdir( "output/obj/release" )

project( "Tests" )

    kind( "ConsoleApp" )
    language( "C++" )

    files {
        path.join( "../sources/**.h" ),
        path.join( "../sources/**.hpp" ),
        path.join( "../sources/**.cpp" )
    }

    configuration { "Debug" }
        defines { "DEBUG" }
        flags { "ExtraWarnings", "FatalWarnings", "Symbols" }

    configuration { "Release" }
        defines { "NDEBUG" }
        flags { "ExtraWarnings", "FatalWarnings", "Optimize" }

    configuration { "gmake" }
        buildoptions { "-std=c++11", "-std=c++1y" }
        postbuildcommands { "$(TARGET) ../../samples/probe" }

    configuration { "vs*" }
        buildoptions { "/wd\"4706\"" }
        postbuildcommands { "\"$(TargetPath)\" ../../samples/probe" }
