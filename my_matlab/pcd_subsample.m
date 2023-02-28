addpath('./matpcl/');
pre_path = '/home/junwangcas/Documents/code/peac-fast-plane-extraction/cpp/cmake-build-release'
input_file_name = strcat(pre_path, '/orca_vertical_17.pcd');
out_file = strcat(pre_path, '/orca_vertical_17_sub.pcd');
pccloud = loadpcd(input_file_name);

matlab_pcd_viewer(pccloud);

z_max = 2.5;
x_max = 2.5;
y_max = 3.0;
pccloud_subsample = pccloud;
for i = 1:size(pccloud_subsample, 1)
    for j = 1:size(pccloud_subsample, 2)
        x = pccloud_subsample(i, j, 1);
        y = pccloud_subsample(i, j, 2);
        z = pccloud_subsample(i, j, 3);
        if abs(z) > z_max || abs(x) > x_max || abs(y) > y_max
            pccloud_subsample(i, j, 1) = NaN;
            pccloud_subsample(i, j, 2) = NaN;
            pccloud_subsample(i, j, 3) = NaN;
        end
    end
end
savepcd(out_file, pccloud_subsample);
matlab_pcd_viewer(pccloud_subsample);



