#include "externs/catch.hpp"
#include "helpers.hpp"

namespace
{
    void ValidateStructure(nlohmann::json& object)
    {
        CHECK(object.is_object());
        CHECK(object.size() == 3);

        CHECK(object["project"].is_string());
        CHECK(object["configs"].is_array());
        CHECK(object["files"].is_array());
    }
}

TEST_CASE("Project structure")
{
    auto test_B1 = ParseJsonFile("test_B1.prj.json");
    auto test_C1 = ParseJsonFile("test_C1.prj.json");
    auto test_C2 = ParseJsonFile("test_C2.prj.json");
    auto test_C3 = ParseJsonFile("test_C3.prj.json");

    ValidateStructure(test_B1);
    ValidateStructure(test_C1);
    ValidateStructure(test_C2);
    ValidateStructure(test_C3);
}

TEST_CASE("Test B1")
{
    auto test_B1 = ParseJsonFile("test_B1.prj.json");

    SECTION("Configs")
    {
        auto& configs = test_B1["configs"];
        REQUIRE(configs.size() == 1);

        auto& config = configs[0];
        CHECK(config.size() == 4);

        CHECK(config["name"].is_string());
        CHECK(config["name"] == "Debug");

        CHECK(config["defines"].is_array());
        CHECK(config["defines"].size() == 3);
        CHECK(config["defines"][0] == "DEFINE_1");
        CHECK(config["defines"][1] == "DEFINE_2");
        CHECK(config["defines"][2] == "DEFINE_3");

        CHECK(config["includedirs"].is_array());
        CHECK(config["includedirs"].size() == 2);
        CHECK(config["includedirs"][0] == "../some/include/path");
        CHECK(config["includedirs"][1] == "../some/other/include/path");

        CHECK(config["pchsource"].is_null());
    }

    SECTION("Files")
    {
        auto& files = test_B1["files"];

        REQUIRE(files.size() == 6);

        CHECK(files[0].is_string());
        CHECK(files[1].is_string());
        CHECK(files[2].is_string());
        CHECK(files[3].is_string());
        CHECK(files[4].is_string());
        CHECK(files[5].is_string());

        CHECK(files[0] == "../folder_A/sub_folder_AA/file_AA1.c");
        CHECK(files[1] == "../folder_A/sub_folder_AA/file_AA1.h");
        CHECK(files[2] == "../folder_A/sub_folder_AB/file_AB1.cpp");
        CHECK(files[3] == "../folder_B/file_B1.cpp");
        CHECK(files[4] == "../folder_B/file_B1.hpp");
        CHECK(files[5] == "../file_at_root.cpp");
    }
}
