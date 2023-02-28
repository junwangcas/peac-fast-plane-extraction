% z 方向无关，当成一个2d的pose就好了，而且T也是固定的。
addpath('../../spatialmath-matlab/');
clear;
DoF = 1;

NUM_POSES = 1;
NUM_STATES = NUM_POSES * DoF;
NUM_MEAS = 3;
MAX_ITER = 20;

% Simulator
% poses, controls
poses = cell(NUM_POSES, 1);
poses{1} = SO2(1.1);
%poses{1} = SO2(0.0);

%% visualize
% ground truth 
% initial values
%subplot(1, 2, 1);
%for i = 1:NUM_POSES
%    hold on; poses{i}.plot;
%end
%xlim([-1, 4]); ylim([-2, 3]);
%axis equal
%axis auto
%title('2 poses - init');


%lmks = [0.5, 1, 1; 0, 1, 1; -0.5, 0, 1];
lmks = [0, 0, 1; 0, 1, 0; 1, 0, 1];
center = mean(lmks);
bias_axis = [0, 1];


sploth = subplot(1, 1, 1);
%sploth = plot;
% estimator

for iteration = 1:MAX_ITER
    scatter3(lmks(:,1), lmks(:,2), lmks(:,3));
    xlabel('x');ylabel('y'); zlabel('z');

    r = zeros(NUM_MEAS, 1);
    J = zeros(NUM_MEAS, NUM_STATES);
    for idlmk = 1:size(lmks, 1)
        lmk = lmks(idlmk, 2:3)';
        row = idlmk;

        delta_p = lmk - center(2:3)';
        %r(row) = bias_axis * (poses{1}.inv * delta_p);
        r(row) = dist_to_plane_x_gravity(poses{1}, center(2:3)', lmk);

        ix = poses{1}.inv;
        d_e_ix = bias_axis * (ix * skew(1) * delta_p);
        d_ix_x = -1;
        d_e_x = d_e_ix * d_ix_x;

        J(row, 1) = d_e_x; 
    end
    r
    dx = - inv(J' * J) * J' * r
    % update
    %test = vec2so2([dx()]);
    %test2 = SO2.exp(test);
    %poses{1} = poses{1} * test2;
    poses{1} = poses{1} * SO2.exp(vec2so2([dx()]));
    plotplane_vertical(poses{1}, center(2:3)');
    angle = poses{1}.angle
    waitforbuttonpress;
    cla(sploth);
end































