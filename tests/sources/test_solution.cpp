#include "externs/catch.hpp"
#include "helpers.hpp"

namespace
{
    void ValidateStructure( nlohmann::json& object )
    {
        CHECK( object.is_object() );
        CHECK( object.size() == 2 );

        CHECK( object["solution"].is_string() );
        CHECK( object["projects"].is_array() );
    }
}

TEST_CASE( "Solution structure" )
{
    auto test_A = ParseJsonFile( "test_A.sln.json" );
    auto test_B = ParseJsonFile( "test_B.sln.json" );
    auto test_C = ParseJsonFile( "test_C.sln.json" );

    ValidateStructure( test_A );
    ValidateStructure( test_B );
    ValidateStructure( test_C );
}

TEST_CASE( "Solution with no projects" )
{
    auto test_A = ParseJsonFile( "test_A.sln.json" );
    auto& solution = test_A["solution"];
    auto& projects = test_A["projects"];

    CHECK( solution == "test_A" );
    CHECK( projects.empty() );
}

TEST_CASE( "Solution with a single project" )
{
    auto test_B = ParseJsonFile( "test_B.sln.json" );
    auto& solution = test_B["solution"];
    auto& projects = test_B["projects"];

    CHECK( solution == "test_B" );
    CHECK( projects.size() == 1 );

    CHECK( projects[0].is_string() );
    CHECK( projects[0] == "test_B1.prj.json" );
}

TEST_CASE( "Solution with many projects" )
{
    auto test_C = ParseJsonFile( "test_C.sln.json" );
    auto& solution = test_C["solution"];
    auto& projects = test_C["projects"];

    CHECK( solution == "test_C" );
    CHECK( projects.size() == 3 );

    CHECK( projects[0].is_string() );
    CHECK( projects[0] == "test_C1.prj.json" );

    CHECK( projects[1].is_string() );
    CHECK( projects[1] == "test_C2.prj.json" );

    CHECK( projects[2].is_string() );
    CHECK( projects[2] == "test_C3.prj.json" );
}
