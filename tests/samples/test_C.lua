
require( "../premake-generic" )

solution( "test_C")
    configurations( { "Debug" } )
        location( _ACTION )

project( "test_C1" )
    kind( "SharedLib" )

project( "test_C2" )
    kind( "SharedLib" )

project( "test_C3" )
    kind( "SharedLib" )
