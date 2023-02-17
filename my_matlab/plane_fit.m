clear;
file_name = '/home/junwangcas/Documents/code/peac-fast-plane-extraction/data/stair/record_00080.pcd';
pccloud = loadpcd(file_name);

x = pccloud(:, :, 1);
y = pccloud(:, :, 2);
z = pccloud(:, :, 3);
xyz(:, 1) = reshape(x, [480 * 640, 1]);
xyz(:, 2) = reshape(y, [480 * 640, 1]);
xyz(:, 3) = reshape(z, [480 * 640, 1]);

xyzpointcloud = pointCloud(xyz);
pcshow(xyzpointcloud);