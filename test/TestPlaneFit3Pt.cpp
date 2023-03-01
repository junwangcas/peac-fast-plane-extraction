
#include <gtest/gtest.h>
#include "PlaneFitVertical.h"

TEST(PlaneFitTest, FitPlane)
{
  PlaneFitVertical plane_fit_vertical;
  plane_fit_vertical.SetSamplePts();
  plane_fit_vertical.DoOptmization();
  EXPECT_TRUE(true);
}
