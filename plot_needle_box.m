function plot_needle_box(length, width, height, center)
    % 
    vertices = [
        center(1) - length/2, center(2) - width/2, center(3) - height/2;
        center(1) + length/2, center(2) - width/2, center(3) - height/2;
        center(1) + length/2, center(2) + width/2, center(3) - height/2;
        center(1) - length/2, center(2) + width/2, center(3) - height/2;
        center(1) - length/2, center(2) - width/2, center(3) + height/2;
        center(1) + length/2, center(2) - width/2, center(3) + height/2;
        center(1) + length/2, center(2) + width/2, center(3) + height/2;
        center(1) - length/2, center(2) + width/2, center(3) + height/2;
    ];

    % 定义长方体的面
    faces = [
        1, 2, 3, 4;
        5, 6, 7, 8;
        1, 2, 6, 5;
        3, 4, 8, 7;
        2, 3, 7, 6;
        1, 4, 8, 5;
    ];

    % 绘制长方体
    patch('Vertices', vertices, 'Faces', faces, 'FaceColor', 'red');
end