clear;
file_name = '/home/junwangcas/Documents/code/peac-fast-plane-extraction/cpp/cmake-build-release/record_00080.seg.pcd';
pccloud = loadpcd(file_name);

height = size(pccloud, 1);
width = size(pccloud, 2);

x = pccloud(:, :, 1);
y = pccloud(:, :, 2);
z = pccloud(:, :, 3);
xyz(:, 1) = reshape(x, [height * width, 1]);
xyz(:, 2) = reshape(y, [height * width, 1]);
xyz(:, 3) = reshape(z, [height * width, 1]);

r = pccloud(:, :, 4);
g = pccloud(:, :, 5);
b = pccloud(:, :, 6);
rgb(:, 1) = reshape(r, [height * width, 1]);
rgb(:, 2) = reshape(g, [height * width, 1]);
rgb(:, 3) = reshape(b, [height * width, 1]);

xyzpointcloud = pointCloud(xyz, 'Color', rgb);
pcshow(xyzpointcloud);