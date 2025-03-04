#include <gtest/gtest.h>

#ifdef TEMPLATE_MODULE
import lib;
#else
#include "lib.hpp"
#endif // TEMPLATE_MODULE

TEST(behold, the_truth) {
  ASSERT_TRUE(lib::return_true()); 
}
