function [ dist ] = dist_to_plane_x_gravity(pose, center, cand_pt)
% pose - so(2), center (y,z), cand_pt (y,z )
bias_axis = [0, 1];
delta_p = cand_pt - center;
dist = bias_axis * (pose.inv * delta_p);
end

