#pragma once
//#include "sophus/so2.hpp"
#include "dmsophus/so2.hpp"


class PlaneFitVertical {
 public:
  PlaneFitVertical();
  ~PlaneFitVertical();

 public:
  void SetSamplePts();
  void AddPts(std::vector<Eigen::Vector3d> &pts_lmks);
  void DoOptmization();
  Eigen::Vector3d GetCenter(const std::vector<Eigen::Vector3d> &pts_lmks);
  double DistToPlane(const Sophus::SO2d &pose, const Eigen::Vector2d &center, const Eigen::Vector2d &lmk);
  Eigen::Matrix2d Skew(const double val);

 public:
  double angle_;
  Sophus::SO2d pose_so2_;
  std::vector<Eigen::Vector3d> pts_lmks_;
  Eigen::Vector2d bias_axis_;

  int max_iter_ = 10;


};


