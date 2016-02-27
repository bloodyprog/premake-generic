#include "externs/catch.hpp"
#include "helpers.hpp"

namespace
{
    void ValidateStructure( nlohmann::json& object )
    {
        CHECK( object.is_object() );
        CHECK(object.size() == 2);

        CHECK( object["workspace"].is_string() );
        CHECK( object["projects"].is_array() );
    }
}

TEST_CASE( "Workspace structure" )
{
    auto test_A = ParseJsonFile( "test_A.wks.json" );
    auto test_B = ParseJsonFile( "test_B.wks.json" );
    auto test_C = ParseJsonFile( "test_C.wks.json" );

    ValidateStructure( test_A );
    ValidateStructure( test_B );
    ValidateStructure( test_C );
}

TEST_CASE( "Workspace with no projects" )
{
    auto test_A = ParseJsonFile( "test_A.wks.json" );
    auto& workspace = test_A["workspace"];
    auto& projects  = test_A["projects"];

    CHECK( workspace == "test_A" );
    CHECK( projects.empty() );
}

TEST_CASE( "Workspace with a single project" )
{
    auto test_B = ParseJsonFile( "test_B.wks.json" );
    auto& workspace = test_B["workspace"];
    auto& projects  = test_B["projects"];

    CHECK( workspace == "test_B" );

    REQUIRE( projects.size() == 1 );
    CHECK( projects[0].is_string() );
    CHECK( projects[0] == "test_B1.prj.json" );
}

TEST_CASE( "Workspace with many projects" )
{
    auto test_C = ParseJsonFile( "test_C.wks.json" );
    auto& workspace = test_C["workspace"];
    auto& projects = test_C["projects"];

    CHECK( workspace == "test_C" );

    REQUIRE( projects.size() == 3 );

    CHECK( projects[0].is_string() );
    CHECK( projects[0] == "test_C1.prj.json" );

    CHECK( projects[1].is_string() );
    CHECK( projects[1] == "test_C2.prj.json" );

    CHECK( projects[2].is_string() );
    CHECK( projects[2] == "test_C3.prj.json" );
}
