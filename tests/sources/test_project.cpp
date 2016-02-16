#include "externs/catch.hpp"
#include "helpers.hpp"

namespace
{
    void ValidateStructure( nlohmann::json& object )
    {
        CHECK( object.is_object() );
        CHECK( object.size() == 3 );

        CHECK( object["project"].is_string() );
        CHECK( object["configs"].is_array() );
        CHECK( object["files"].is_array() );
    }
}

TEST_CASE( "Project structure" )
{
    auto test_B1 = ParseJsonFile( "test_B1.prj.json" );
    auto test_C1 = ParseJsonFile( "test_C1.prj.json" );
    auto test_C2 = ParseJsonFile( "test_C2.prj.json" );
    auto test_C3 = ParseJsonFile( "test_C3.prj.json" );

    ValidateStructure( test_B1 );
    ValidateStructure( test_C1 );
    ValidateStructure( test_C2 );
    ValidateStructure( test_C3 );
}
