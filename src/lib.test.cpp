#include <catch2/catch_test_macros.hpp>
#ifdef TEMPLATE_MODULE
import lib;
#else
#include "lib.hpp"
#endif // TEMPLATE_MODULE

TEST_CASE("Behold", "The Truth:") { REQUIRE(lib::return_true()); }
