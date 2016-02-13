#define CATCH_CONFIG_RUNNER
#include "externs/catch.hpp"

void ChangeCWD( int argc, char* argv[] )
{
    if ( argc < 2 )
        return;

    chdir( argv[1] );

    char buffer[256];
    char *answer = getcwd(buffer, sizeof(buffer));
    std::cout << "{ cwd : " << answer << " }" << std::endl;
}

int main( int argc, char* argv[] )
{
    ChangeCWD( argc, argv );

    return Catch::Session().run();
}
