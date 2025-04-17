function draw_bar(app,t,y)
    % 添加坐标轴标签
    xlabel(app.UIAxes, ' ');
    ylabel(app.UIAxes, ' '); 
    axis(app.UIAxes, [0,1,0,1.1]);
    %设置显示的帧数
    K=50;
    num0=max(y(1,1),y(1,2));
     for i = 1:K
         %清空并设置坐标轴范围
        cla(app.UIAxes);
        %计算此时甲乙两军的数量
        Anum=y(i*round((101/K)),1);
        Bnum=y(i*round((101/K)),2);
        barA=round(Anum/num0,3);
        barB=round(Bnum/num0,3);
        %绘制散点
        bar1=bar(app.UIAxes,0.3,barA ,0.2, 'b'); % 'b' 表示蓝色
        hold (app.UIAxes,'on'); % 保持当前图形，以便在同一坐标轴上绘制第二个柱状tu
        bar2=bar(app.UIAxes,0.7, barB,0.2, 'r'); % 'r' 表示红色
        %绘制顶端文字(剩余兵力)
        text(app.UIAxes,0.3, barA, num2str(round(Anum)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
        text(app.UIAxes,0.7, barB, num2str(round(Bnum)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom');
        legend(app.UIAxes, [bar1, bar2], {'甲军兵力', '乙军兵力'}, 'Location', 'northeast');
        %延时
        pause(0.05);
     end
end