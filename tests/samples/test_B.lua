
require( "../../src/blueprint" )

workspace( "test_B" )
    configurations( { "Debug" } )
        location( _ACTION )

project( "test_B1" )
    kind( "ConsoleApp" )

    defines {
        "DEFINE_1",
        "DEFINE_2",
        "DEFINE_3"
    }

    includedirs {
        "some/include/path",
        "some/other/include/path"
    }

    pchheader("some/precompiled.hpp")
    pchsource("some/precompiled.cpp")

    files {
        "folder_A/sub_folder_AA/file_AA1.c",
        "folder_A/sub_folder_AA/file_AA1.h",
        "folder_A/sub_folder_AB/file_AB1.cpp",
        "folder_B/file_B1.cpp",
        "folder_B/file_B1.hpp",
        "file_at_root.cpp"
    }
