function [ output_args ] = plotplane( pose, T)
% horiz plane

resolution = 0.2;
% draw plane 
% local points 
y = -2:resolution:2;
x = zeros(length(y),1)';
xy_local = [x; y];

xy_global = pose * xy_local + repmat(T, 1, length(y));



z_global = -2:resolution:2;
%[xgrid, ygrid, zgrid] = meshgrid(xy_global(1,:), xy_global(2,:));

%surf(xgrid, ygrid, zgrid)
xlabel('x');
ylabel('y');
zlabel('z');

size_y = length(y);
for z = -2:0.1:2
    zs = repmat(z, 1, size_y);
    hold on; plot3(xy_global(1,:), xy_global(2,:), zs, 'g');
end
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-2, 2]);
%axis auto;
end

