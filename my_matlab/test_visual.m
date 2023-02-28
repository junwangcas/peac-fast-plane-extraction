clear;
pre_path = '/home/junwangcas/Documents/code/peac-fast-plane-extraction/cpp/cmake-build-release'
file_name = strcat(pre_path, '/orca_pts_global_6_sub_horiz.pcd');
%file_name = strcat(pre_path, '/orca_pts_global_6.pcd');


pccloud = loadpcd(file_name);
matlab_pcd_viewer(pccloud);

p = [-0.779113, -0.172364, -1.38277];
nb = [-0.984826, 0.0539208, -1.26969];
merge = [-0.901949, -0.0372443, -1.31525];

hold on; scatter3(p(1), p(2), p(3), 'r');
hold on; scatter3(nb(1), nb(2), nb(3), 'b');
hold on; scatter3(merge(1), merge(2), merge(3), 'g');



