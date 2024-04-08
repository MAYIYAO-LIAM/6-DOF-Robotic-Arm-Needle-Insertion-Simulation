function plot_visible_workspace(Six_dof, L)
    
    num = 30000;
    P = zeros(num, 3);
    
    for i = 1:num
        q1 = L(1).qlim(1) + rand * (L(1).qlim(2) - L(1).qlim(1));
        q2 = L(2).qlim(1) + rand * (L(2).qlim(2) - L(2).qlim(1));
        q3 = L(3).qlim(1) + rand * (L(3).qlim(2) - L(3).qlim(1));
        q4 = L(4).qlim(1) + rand * (L(4).qlim(2) - L(4).qlim(1));
        q5 = L(5).qlim(1) + rand * (L(5).qlim(2) - L(5).qlim(1));
        q6 = L(6).qlim(1) + rand * (L(6).qlim(2) - L(6).qlim(1));
        
        q = [q1 q2 q3 q4 q5 q6];
        T = Six_dof.fkine(q);
        P(i,:) = transl(T);
    end
    
    plot3(P(:,1), P(:,2), P(:,3), 'b.', 'markersize', 1);
    hold on;
    grid on;
    daspect([1 1 1]);
    view([45 45]);
    Six_dof.plot([0 0 0 0 0 0]);
end