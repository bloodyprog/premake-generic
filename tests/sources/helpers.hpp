#pragma once

#include "externs/json.hpp"

using namespace nlohmann;

json ParseJsonFile( const std::string& file );
