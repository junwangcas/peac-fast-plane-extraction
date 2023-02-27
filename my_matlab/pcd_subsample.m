pre_path = '/home/junwangcas/Documents/code/peac-fast-plane-extraction/cpp/cmake-build-release'
input_file_name = strcat(pre_path, '/orca_pts_global_6.pcd');
out_file = strcat(pre_path, '/orca_pts_global_6_sub_horiz.pcd');
pccloud = loadpcd(input_file_name);

matlab_pcd_viewer(pccloud);

z_max = 2;
pccloud_subsample = pccloud;
for i = 1:size(pccloud_subsample, 1)
    for j = 1:size(pccloud_subsample, 2)
        z = pccloud_subsample(i, j, 3);
        if abs(z) > z_max
            pccloud_subsample(i, j, 3) = NaN;
        end
    end
end
savepcd(out_file, pccloud_subsample);
matlab_pcd_viewer(pccloud_subsample);



