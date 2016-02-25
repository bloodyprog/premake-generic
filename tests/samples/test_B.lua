
require( "../../src/premake-generic" )

solution( "test_B" )
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

    files {
        "folder_A/sub_folder_AA/file_AA1.cpp",
        "folder_A/sub_folder_AA/file_AA1.h",
        "folder_A/sub_folder_AB/file_AB1.cpp",
        "folder_B/file_B1.cpp",
        "folder_B/file_B1.hpp",
        "file_at_root.cpp"
    }
