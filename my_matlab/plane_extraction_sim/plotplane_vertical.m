function [ output_args ] = plotplane_vertical( pose, center)
% verticalplane
% pose - so2; center - vec(3, 1)

resolution = 0.03;
radius = 1;
dist_thr = 0.01;
% draw plane 
for x = (center(1) - radius):resolution:(center(1) + radius)
    points = [];
    for y = (center(2) - radius):resolution:(center(2) + radius)
        for z = (center(3) - radius):resolution:(center(3) + radius)
            pt = [x, y, z];
            dist = dist_to_plane_x_gravity(pose, center(2:3), pt(2:3)');
            if abs(dist) < dist_thr
                points = cat(1, points, pt);
            end
        end
    end
    hold on; scatter3(points(:,1),points(:,2),points(:,3), 0.1, 'g');
end

xlabel('x');
ylabel('y');
zlabel('z');
xlim([-4, 4]);
axis equal;
%axis auto;
end

