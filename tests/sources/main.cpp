#define CATCH_CONFIG_RUNNER
#include "externs/catch.hpp"
#include "helpers.hpp"

int main( int argc, char* argv[] )
{
    ChangeCWD( argc, argv );

    return Catch::Session().run(argc - 1, &argv[1]);
}
