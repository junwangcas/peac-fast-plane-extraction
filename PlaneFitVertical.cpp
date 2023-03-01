#include "PlaneFitVertical.h"
#include "iostream"

PlaneFitVertical::PlaneFitVertical()
{
  angle_ = 1.1;
  pose_so2_ = Sophus::SO2d(angle_);
  bias_axis_ = Eigen::Vector2d(0, 1);
  // std::cout << pose_so2.matrix().size() << "\n";
  // std::cout << "unit_complex " << pose_so2.unit_complex().transpose()<< "\n";
}

PlaneFitVertical::~PlaneFitVertical()
{

}


void PlaneFitVertical::SetSamplePts()
{
  Eigen::Vector3d pt1{0, 0, 1};
  Eigen::Vector3d pt2{0, 1, 0};
  Eigen::Vector3d pt3{1, 0, 1};

  pts_lmks_.emplace_back(pt1);
  pts_lmks_.emplace_back(pt2);
  pts_lmks_.emplace_back(pt3);
}

void PlaneFitVertical::DoOptmization()
{
  int sum_pts = pts_lmks_.size();
  Eigen::Vector3d center_pt = GetCenter(pts_lmks_);
  Eigen::Vector2d center_pt_2d = center_pt.block<2, 1>(1, 0);
  for (int i = 0; i < max_iter_; i++) {
    Eigen::MatrixXd r = Eigen::MatrixXd::Zero(sum_pts, 1);
    Eigen::MatrixXd J = Eigen::MatrixXd::Zero(sum_pts, 1);
    for (int idpt = 0; idpt < pts_lmks_.size(); idpt++) {
      Eigen::Vector2d lmk = pts_lmks_[idpt].block<2, 1>(1, 0);
      int row = idpt;
      Eigen::Vector2d delta_p = lmk - center_pt_2d;
      r(row, 0) = DistToPlane(pose_so2_, center_pt_2d, lmk);

      Sophus::SO2d ix = pose_so2_.inverse();
      double d_e_ix = bias_axis_.transpose() * (ix.matrix() * Skew(1) * delta_p);
      double d_ix_x = -1;
      double d_e_x = d_e_ix * d_ix_x;

      J(row, 0) = d_e_x;

//      std::cout << " error: " << r.transpose() << "\n";
//      std::cout << " J: " << J.transpose() << "\n";
    }

    auto dx = - (J.transpose() * J).inverse() * J.transpose() * r;
    pose_so2_ = pose_so2_ * Sophus::SO2d::exp(dx(0, 0));
    std::cout << " error " << r.norm() << " dx " << dx << "\n";
    std::cout << " log " << pose_so2_.log() << "\n";
  }
  angle_ = pose_so2_.log();
}

Eigen::Vector3d PlaneFitVertical::GetCenter(const std::vector<Eigen::Vector3d> &pts_lmks)
{
  double sum_x = 0;
  double sum_y = 0;
  double sum_z = 0;
  for (auto &pt : pts_lmks) {
    sum_x += pt.x();
    sum_y += pt.y();
    sum_z += pt.z();
  }
  Eigen::Vector3d center;
  center.x() = sum_x / pts_lmks.size();
  center.y() = sum_y / pts_lmks.size();
  center.z() = sum_z / pts_lmks.size();
  return center;
}

double PlaneFitVertical::DistToPlane(const Sophus::SO2d &pose, const Eigen::Vector2d &center,
                                     const Eigen::Vector2d &lmk)
{
  Eigen::Vector2d delta_p = lmk - center;
  double dist = bias_axis_.transpose() * (pose.inverse() * delta_p);
  return dist;
}

Eigen::Matrix2d PlaneFitVertical::Skew(const double val)
{
  Eigen::Matrix2d skew_mat = Eigen::Matrix2d::Zero();
  skew_mat(0, 1) = -val;
  skew_mat(1, 0) = val;
  return skew_mat;
}

void PlaneFitVertical::AddPts(std::vector<Eigen::Vector3d> &pts_lmks)
{
  pts_lmks_ = pts_lmks;
}
