#include "helpers.hpp"

#include <fstream>
#include <sstream>

json ParseJsonFile( const std::string& file )
{
    std::ifstream f( file );

    if( f.is_open() )
    {
        std::stringstream ss;
        ss << f.rdbuf();

        return json::parse( ss.str() );
    }

    return nullptr;
}
