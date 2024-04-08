function [Q_initial] = move_between_points(Six_dof, Q_initial, P1, P2, P3, dt)
    % set the speed
    v_ee = 0.1;
    % Pierce
    max_steps1 = ceil(norm(P2 - P1) / (v_ee * dt)) + 1;
    Traj1 = zeros(max_steps1, 3);
    Traj1(1,:) = P1;
    step1 = 1;
    while norm(Traj1(step1,:) - P2) > v_ee * dt
        step1 = step1 + 1;
        direction = (P2 - Traj1(step1-1,:)) / norm(P2 - Traj1(step1-1,:));
        Traj1(step1,:) = Traj1(step1-1,:) + direction * v_ee * dt;
    end
    Traj1 = Traj1(1:step1,:);
    
    % Move out
    max_steps2 = ceil(norm(P3 - P2) / (v_ee * dt)) + 1;
    Traj2 = zeros(max_steps2, 3);
    Traj2(1,:) = P2;
    step2 = 1;
    while norm(Traj2(step2,:) - P3) > v_ee * dt
        step2 = step2 + 1;
        direction = (P3 - Traj2(step2-1,:)) / norm(P3 - Traj2(step2-1,:));
        Traj2(step2,:) = Traj2(step2-1,:) + direction * v_ee * dt;
    end
    Traj2 = Traj2(1:step2,:);
    
    Traj_rest = [Traj1; Traj2(2:end,:)];
    n_rest = size(Traj_rest, 1);
    T_rest = zeros(4, 4, n_rest);
    for i = 1:n_rest
        T_rest(:,:,i) = transl(Traj_rest(i,:)) * rpy2tr(0, -pi/2, 0);
    end
    
    Qtraj_rest = zeros(n_rest, 6);
    Qtraj_rest(1,:) = Q_initial; % Use the end point of the first part of the trajectory as the starting point
    
    % Calculation of joint angles using inverse Jacobi matrix and inverse kinematics
    for i = 2:n_rest
        J = Six_dof.jacobe(Qtraj_rest(i-1,:));
        v = (Traj_rest(i,:) - Traj_rest(i-1,:)) / dt;
        qdot = pinv(J) * [v, 0, 0, 0]';
        q_guess = Qtraj_rest(i-1,:) + qdot' * dt;
        Qtraj_rest(i,:) = Six_dof.ikcon(T_rest(:,:,i), q_guess', 'MaxIter', 400);
    end
    
    % Calculate actual end speed
    actual_ee_vel = zeros(n_rest, 3);
    for i = 2:n_rest
        actual_ee_vel(i,:) = (Traj_rest(i,1:3) - Traj_rest(i-1,1:3)) / dt;
    end
    
    % Execute trajectory and display end speed profile
    for i = 1:size(Qtraj_rest, 1)
        figure(1);
        Six_dof.plot(Qtraj_rest(i,:));
        drawnow;
        
        % Plot speed
        figure(2);
        clf;
        plot(1:i, actual_ee_vel(1:i,1), 'r.-', 1:i, actual_ee_vel(1:i,2), 'g.-', 1:i, actual_ee_vel(1:i,3), 'b.-');
        xlabel('time_step');
        ylabel('ee_vol (m/s)');
        title('End-effector Velocity');
        legend('X', 'Y', 'Z');
        % 获取 Figure 1 的位置
        fig1_pos = get(1, 'Position');

        % 设置 Figure 2 的位置，使其显示在 Figure 1 右侧
        set(2, 'Position', [fig1_pos(1)+fig1_pos(3), fig1_pos(2), fig1_pos(3), fig1_pos(4)]);
        pause(dt);
    end
    close(figure(2));
    Q_initial = Qtraj_rest(end, :);
end