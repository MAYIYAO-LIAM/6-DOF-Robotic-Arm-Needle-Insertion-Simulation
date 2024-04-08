function plot_body()

% Set vertices
vertices = [
    -0.65, -0.2, 0;     % v1
    -0.65, -0.2, 0.6;   % v2
    -0.65, 0.2, 0.6;    % v3
    -0.65, 0.2, 0;      % v4
    -0.8, -0.2, 0;      % v5
    -0.8, -0.2, 0.6;    % v6
    -0.8, 0.2, 0.6;     % v7
    -0.8, 0.2, 0;       % v8
];
% Set faces
faces = [
    1, 2, 3, 4;  % botttom
    5, 6, 7, 8;  % top
    1, 5, 6, 2;  % side1
    2, 6, 7, 3;  % side2
    3, 7, 8, 4;  % side3
    4, 8, 5, 1;  % side4
];
% Create body
patch('Faces', faces, 'Vertices', vertices, 'FaceColor', 'yellow');
 
% Set axes
axis([-1, 1, -1, 1, -1, 1]); % 根据实际情况调整范围
% Set view
view(3);
grid off;
% Set labels
xlabel('X');
ylabel('Y');
zlabel('Z');
% Set scale
xticks(-1:0.5:1);
yticks(-1:0.5:1);
zticks(-1:0.5:1);

pause(5);
end