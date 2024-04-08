function [Q_initial] = pure_jacobian_test(Six_dof, Q_initial, P1, P2, P3)
    v_ee = 0.1; % End-effector velocity, unit: m/s

    % Generate trajectory
    t1 = linspace(0, norm(P2 - P1) / v_ee, 26);
    t2 = linspace(0, norm(P3 - P2) / v_ee, 26);
    Traj1 = mtraj(@tpoly, P1, P2, t1);
    Traj2 = mtraj(@tpoly, P2, P3, t2);
    Traj_rest = [Traj1; Traj2];
    n_rest = size(Traj_rest, 1);
    T_rest = zeros(4, 4, n_rest);
    for i = 1:n_rest
        T_rest(:,:,i) = transl(Traj_rest(i,:)) * rpy2tr(0, -pi/2, 0);
    end

    Qtraj_rest = zeros(n_rest, 6);
    Qtraj_rest(1,:) = Q_initial; % 使用初始关节角度作为起始点

    % Use inverse Jacobian and inverse kinematics to compute joint angles
    for i = 2:n_rest
        J = Six_dof.jacobe(Qtraj_rest(i-1,:));
        v = (Traj_rest(i,:) - Traj_rest(i-1,:)) / (t1(2) - t1(1));
        v_norm = norm(v);
        if v_norm > v_ee
            v = v / v_norm * v_ee;
        end
        qdot = pinv(J) * [v, 0, 0, 0]';
        q_guess = Qtraj_rest(i-1,:) + qdot' * (t1(2) - t1(1));
        Qtraj_rest(i,:) = Six_dof.ikcon(T_rest(:,:,i), q_guess', 'MaxIter', 400);
    end

    % Calculate actual end-effector velocities
    actual_ee_vel = zeros(n_rest, 3);
    for i = 2:n_rest
        actual_ee_vel(i,:) = (Traj_rest(i,1:3) - Traj_rest(i-1,1:3)) / (t1(2) - t1(1));
    end

    % Execute the trajectory
    for i = 1:size(Qtraj_rest, 1)
        figure(1);
        Six_dof.plot(Qtraj_rest(i,:));
        drawnow;

        % Plot actual end-effector velocities
        figure(2);
        clf;
        plot(1:i, actual_ee_vel(1:i,:));
        xlabel('Time Step');
        ylabel('Actual End-Effector Velocities (m/s)');
        title('Actual End-Effector Velocities');
        legend('X', 'Y', 'Z');

        if i <= length(t1)
            pause(t1(2) - t1(1));
        else
            pause(t2(2) - t2(1));
        end
    end

    Q_initial = Qtraj_rest(end, :);
end