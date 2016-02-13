
require( "../premake-generic" )

solution( "test_B" )
    configurations( { "Debug" } )
        location( _ACTION )

project( "test_B1" )
    kind( "ConsoleApp" )
