function [Q_initial] = move_to_origin(Six_dof, Q_initial, Ptarget, Porigin)
    t0 = linspace(0, 1, 26);
    Traj0 = mtraj(@tpoly, Ptarget, Porigin, t0);
    Traj = Traj0;
    n = size(Traj, 1);
    T = zeros(4, 4, n);
    for i = 1:n
        T(:,:,i) = transl(Traj(i,:)) * rpy2tr(0, -pi/2, 0);
    end
    Qtraj0 = Six_dof.ikcon(T, Q_initial, 'MaxIter', 400);
    Six_dof.plot(Qtraj0, 'trail', 'b');
    Q_initial = Qtraj0(end, :);
end