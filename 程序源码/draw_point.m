function draw_point(app,~,y)
    % 添加坐标轴标签
    xlabel(app.UIAxes, ' ');
    ylabel(app.UIAxes, ' '); 
    %设置显示的帧数
    K=50;
     for i = 1:K
         %清空并设置坐标轴范围
        cla(app.UIAxes);
        axis(app.UIAxes, [0,1,0,1]);
        %计算此时甲乙两军的数量
        Anum=y(i*round((101/K)),1);
        Bnum=y(i*round((101/K)),2);
        xmax=round(Anum/(Anum+Bnum),3);
        %生成甲军的散点
        xa_range = 0:0.01:xmax+0.025;
        ya_range = 0:0.01:1;
        % 生成随机x和y坐标
        xa = rand(1, 1000*xmax) * (max(xa_range) - min(xa_range)) + min(xa_range);
        ya = rand(1, 1000*xmax) * (max(ya_range) - min(ya_range)) + min(ya_range);
        %生成乙军的散点
        xb_range = xmax-0.025:0.01:1;
        yb_range = 0:0.01:1;
        % 生成随机x和y坐标
        xb = rand(1, 1000-1000*xmax) * (max(xb_range) - min(xb_range)) + min(xb_range);
        yb = rand(1, 1000-1000*xmax) * (max(yb_range) - min(yb_range)) + min(yb_range);
        %绘制散点
        point1=scatter(app.UIAxes, xb, yb, 18, 'r', 'o'); % 'b' 表示红色，'filled' 表示填充点
        hold(app.UIAxes, 'on');
        point2=scatter(app.UIAxes, xa, ya, 18, [0.118,0.565,1], 'o'); % 'b' 表示蓝色，'filled' 表示填充点
        hold(app.UIAxes, 'on');
        legend(app.UIAxes, [point2, point1], {'甲军兵力', '乙军兵力'}, 'Location','northeast');
        %延时
        pause(0.01);
     end
end