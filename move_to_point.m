function [Q_initial] = move_to_point(Six_dof, Q_initial, Porigin, Ptarget)
    t0 = linspace(0, 1, 26);
    Traj0 = mtraj(@tpoly, Porigin, Ptarget, t0);
    Traj = Traj0;
    n = size(Traj, 1);
    T = zeros(4, 4, n);
    for i = 1:n
        T(:,:,i) = transl(Traj(i,:)) * rpy2tr(0, -pi/2, 0);
    end
    Qtraj = Six_dof.ikcon(T, Q_initial, 'MaxIter', 400);
    figure(1);
    Six_dof.plot(Qtraj);
    Q_initial = Qtraj(end, :);
end