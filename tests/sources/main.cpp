#define CATCH_CONFIG_RUNNER
#include "externs/catch.hpp"
#include "helpers.hpp"

int main( int argc, char* argv[] )
{
    ChangeCWD( argc, argv );
    PrintFilesInCWD();

    return Catch::Session().run();
}
