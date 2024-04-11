%% plot
clear;
clc;
L(1) = Link('revolute', 'd',0.1625, 'a', 0, 'alpha',1.570796327 );
L(2) = Link('revolute', 'd',0, 'a', -0.425, 'alpha', 0);
L(3) = Link('revolute', 'd',0, 'a', -0.39225, 'alpha', 0);
L(4) = Link('revolute', 'd',0.1333, 'a', 0, 'alpha', 1.570796327);
L(5) = Link('revolute', 'd',0.0997, 'a', 0, 'alpha', -1.570796327);
L(6) = Link('revolute', 'd',0.0996, 'a', 0, 'alpha', 0);
L(1).qlim = [-180,180]/180*pi;
L(2).qlim = [-180,180]/180*pi;
L(3).qlim = [-180,180]/180*pi;
L(4).qlim = [-180,180]/180*pi;
L(5).qlim = [-180,180]/180*pi;
L(6).qlim = [-180,180]/180*pi;
Six_dof = SerialLink(L,'name','6-dof');
Six_dof.base = transl(0,0,0.28);
%Six_dof.qlim = [0 pi/2; 0 pi/2; -pi/2 pi/2; -pi/2 pi/2; 0 pi/2; -pi/2 pi/2];
q_start = [0 -pi/4 pi/4 0 -pi/4 0];
Six_dof.plotopt = {'jointdiam', 0.8, 'jointlen', 1.2}; 
Six_dof.teach
%% visibile workspace
% plot_visible_workspace(Six_dof, L);

%% position parameters
P0 = [-0.5, 0.3, 0];
%1
P11 = [-0.5, 0.1, 0.1];
P12 = [-0.6, 0.1, 0.1];
P13 = [-0.5, 0.1, 0.1];
%2
P21 = [-0.5, 0.1, 0.2];
P22 = [-0.6, 0.1, 0.2];
P23 = [-0.5, 0.1, 0.2];
%3
P31 = [-0.5, 0.1, 0.3];
P32 = [-0.6, 0.1, 0.3];
P33 = [-0.5, 0.1, 0.3];
%4
P41 = [-0.5, 0.1, 0.4];
P42 = [-0.6, 0.1, 0.4];
P43 = [-0.5, 0.1, 0.4];
%5
P51 = [-0.5, -0.1, 0.4];
P52 = [-0.6, -0.1, 0.4];
P53 = [-0.5, -0.1, 0.4];
%6
P61 = [-0.5, -0.1, 0.3];
P62 = [-0.6, -0.1, 0.3];
P63 = [-0.5, -0.1, 0.3];
%7
P71 = [-0.5, -0.1, 0.2];
P72 = [-0.6, -0.1, 0.2];
P73 = [-0.5, -0.1, 0.2];
%8
P81 = [-0.5, -0.1, 0.1];
P82 = [-0.6, -0.1, 0.1];
P83 = [-0.5, -0.1, 0.1];
%% plot body and box
plot_body();
P01 = [-0.6, 0.3, -0.1];
plot_needle_box(0.1, 0.1, 0.2, P01);

%% Start 
P_start = Six_dof.fkine(q_start);
t0 = linspace(0, 1, 26);
Traj0 = mtraj(@tpoly, P_start.t', P0, t0);
Traj = Traj0;
n=size(Traj,1);
T=zeros(4,4,n);
for i = 1:n
    T(:,:,i) = transl(Traj(i,:)) * rpy2tr(0, -pi/2, 0);
end
Qtraj0=Six_dof.ikcon(T, 'MaxIter', 400);
Six_dof.plot(Qtraj0);
Q_initial = Qtraj0(end, :);
pause(1);

%% pure jacobian (test)
% Q_initial = move_to_point(Six_dof, Q_initial, P0, P11);
% Q_initial = pure_jacobian_test(Six_dof, Q_initial, P11, P12, P13);
% Q_initial = move_to_origin(Six_dof, Q_initial, P13, P0);
% pause(1);

%% 1
Q_initial = move_to_point(Six_dof, Q_initial, P0, P11);
Q_initial = move_between_points(Six_dof, Q_initial, P11, P12, P13, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P13, P0);
pause(1);

%% 2
Q_initial = move_to_point(Six_dof, Q_initial, P0, P21);
Q_initial = move_between_points(Six_dof, Q_initial, P21, P22, P23, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P23, P0);
pause(1);

%% 3
Q_initial = move_to_point(Six_dof, Q_initial, P0, P31);
Q_initial = move_between_points(Six_dof, Q_initial, P31, P32, P33, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P33, P0);
pause(1);

%% 4
Q_initial = move_to_point(Six_dof, Q_initial, P0, P41);
Q_initial = move_between_points(Six_dof, Q_initial, P41, P42, P43, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P43, P0);
pause(1);

%% 5
Q_initial = move_to_point(Six_dof, Q_initial, P0, P51);
Q_initial = move_between_points(Six_dof, Q_initial, P51, P52, P53, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P53, P0);
pause(1);

%% 6
Q_initial = move_to_point(Six_dof, Q_initial, P0, P61);
Q_initial = move_between_points(Six_dof, Q_initial, P61, P62, P63, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P63, P0);
pause(1);

%% 7
Q_initial = move_to_point(Six_dof, Q_initial, P0, P71);
Q_initial = move_between_points(Six_dof, Q_initial, P71, P72, P73, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P73, P0);
pause(1);

%% 8
Q_initial = move_to_point(Six_dof, Q_initial, P0, P81);
Q_initial = move_between_points(Six_dof, Q_initial, P81, P82, P83, 0.1);
Q_initial = move_to_origin(Six_dof, Q_initial, P83, P0);
pause(1);