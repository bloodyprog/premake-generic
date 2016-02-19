#include "helpers.hpp"

#include <fstream>
#include <sstream>

#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#else
#include <unistd.h>
#endif

void SetCWD(std::string cwd)
{
    #ifdef _MSC_VER
        SetCurrentDirectory(cwd.c_str());
    #else
        chdir(cwd.c_str());
    #endif
}

std::string GetCWD()
{
    char cwd[256];

#ifdef _MSC_VER
    GetCurrentDirectory(sizeof(cwd), cwd);
#else
    getcwd(cwd, sizeof(cwd));
#endif

    return cwd;
}

void ChangeCWD( int argc, char* argv[] )
{
    if ( argc < 2 )
        return;

    SetCWD(argv[1]);

    std::cout << "{ cwd : " << GetCWD() << " }" << std::endl;
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
