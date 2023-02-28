function [ output_args ] = plotplane_vertical( pose, T)
% verticalplane

resolution = 0.2;
% draw plane 
% local points 
y = -2:resolution:2;
z = zeros(length(y),1)';
yz_local = [y; z];

yz_global = pose * yz_local + repmat(T, 1, length(y));



%x_global = -2:resolution:2;
%[xgrid, ygrid, zgrid] = meshgrid(xy_global(1,:), xy_global(2,:));

%surf(xgrid, ygrid, zgrid)
xlabel('x');
ylabel('y');
zlabel('z');

size_y = length(y);
for x = -2:0.1:2
    xs = repmat(x, 1, size_y);
    hold on; plot3(xs, yz_global(1,:), yz_global(2,:), 'g');
end
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-4, 4]);
axis equal;
%axis auto;
end

