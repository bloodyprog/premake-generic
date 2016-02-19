#pragma once

#include "externs/json.hpp"

void ChangeCWD( int argc, char* argv[] );
void PrintFilesInCWD();

nlohmann::json ParseJsonFile( const std::string& file );
