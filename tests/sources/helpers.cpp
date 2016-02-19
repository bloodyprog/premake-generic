#include "helpers.hpp"

#include <fstream>
#include <sstream>

#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#else
#include <unistd.h>
#endif

void ChangeCWD( int argc, char* argv[] )
{
    if ( argc < 2 )
        return;

    char cwd[256];

#ifdef _MSC_VER
    SetCurrentDirectory(argv[1]);
    GetCurrentDirectory(sizeof(cwd), cwd);
#else
    chdir(argv[1]);
    getcwd(cwd, sizeof(cwd));
#endif

    std::cout << "{ cwd : " << cwd << " }" << std::endl;
}

nlohmann::json ParseJsonFile( const std::string& file )
{
    std::ifstream f( file );

    if( f.is_open() )
    {
        std::stringstream ss;
        ss << f.rdbuf();

        return nlohmann::json::parse( ss.str() );
    }
    else
    {
        throw std::invalid_argument(file);
    }

    return nullptr;
}
