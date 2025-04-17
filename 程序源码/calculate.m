function [t,y]=calculate(app)
    %初始化灯的颜色
    app.A_Lamp.Color=[1,0,0];
    app.B_Lamp.Color=[1,0,0];
    %收集A的参数
    Adata.add_rate=app.A_add_rate.Value ; % 增援率
    Adata.hit_rate=app.A_hit_rate.Value ; % 命中率
    Adata.shoot_rate=app.A_shoot_rate.Value ; % 射击率
    Adata.initial_num=app.A_initial_num.Value ; % 初始兵力
    Adata.reduce_rate=app.A_reduce_rate.Value ; % 非战斗减员率
    Adata.gue_rate=app.A_gue_rate.Value ;%游击战比率
    Adata.area=app.A_area.Value ;%面积
    %收集B的参数
    Bdata.add_rate=app.B_add_rate.Value ; % 增援率
    Bdata.hit_rate=app.B_hit_rate.Value ; % 命中率
    Bdata.shoot_rate=app.B_shoot_rate.Value ; % 射击率
    Bdata.initial_num=app.B_initial_num.Value ; % 初始兵力
    Bdata.reduce_rate=app.B_reduce_rate.Value ; % 非战斗减员率
    Bdata.gue_rate=app.B_gue_rate.Value ;%游击战比率
    Bdata.area=app.B_area.Value ;%面积
    %仿真时间
    wartime=app.wartime.Value;

    [t, y] = probsolve(Adata, Bdata, wartime);
    drawline(app,t, y);
    winner_decd(app,y(end, 1),y(end, 2));
end

%用于解微分方程的函数
function [t,y]=probsolve(Adata, Bdata, time)
    
    initial = [Adata.initial_num; Bdata.initial_num];
    
    options = odeset('RelTol',1e-6,'AbsTol',1e-8);
    [t,y]=ode15s(@(t, y) stamtrx(t, y, Adata, Bdata)*[y(1);y(2)]+...
        Bmtrx(t, y, Adata, Bdata),0:time/100:time,initial,options);

end

%用于求状态空间矩阵A的函数
function mtrx = stamtrx(~, y, Adata, Bdata)
    %计算状态空间矩阵
    k=0.1;
    mtrx=[-Adata.reduce_rate,-k*((1-Adata.gue_rate)...
        *Bdata.hit_rate*Bdata.shoot_rate+...
        Adata.gue_rate*Bdata.hit_rate*Bdata.shoot_rate*...
        Bdata.area/(Adata.area+0.01));
        
        -k*((1-Bdata.gue_rate)*Adata.hit_rate*Adata.shoot_rate+...
        Bdata.gue_rate*Adata.hit_rate*Adata.shoot_rate*...
        Adata.area/(Bdata.area+0.01)),-Bdata.reduce_rate];
    %如果人数等于0那么让导数也等于0
    if y(1)<=0
        mtrx(1, :) = 0;
    end
    if y(2)<=0
        mtrx(2, :) = 0;
    end
end
%用于求状态空间矩阵B的函数
function Bmtrx=Bmtrx(t, y, Adata, Bdata)
    Bmtrx=[Adata.add_rate*y(1)/(t+1)^3;...
        Bdata.add_rate*y(2)/(t+1)^3];
end

%用于画图
function drawline(app,t, y)
    cla(app.UIAxes);
    %设置线条
    line1 = animatedline(app.UIAxes, 'Color', '#1976D2', 'LineWidth', 2);
    line2 = animatedline(app.UIAxes, 'Color', '#FF9800', 'LineWidth', 2);
    %设置坐标轴范围
    axis(app.UIAxes, [0, t(end), 0 ...
        , 1.1 * max(y(1, 1) , y(1, 2))]);   
    %设置图例
    legend(app.UIAxes, "甲方兵力", "乙方兵力");
    len_t = length(t);
    for k = 1:len_t
        addpoints(line1, t(k) ,y(k, 1));
        addpoints(line2, t(k) ,y(k, 2));
        drawnow limitrate;
        pause(1.5 / len_t);
    end  
end

%判断胜负
function winner_decd(app,A_num, B_num)
    if A_num>=2*B_num
        app.B_Lamp.Color=[1,0,0];
        app.winner_show.Text="甲军获胜";
        app.winner_show.FontColor=[0,0,1];
        for i = 1:3
            app.A_Lamp.Color=[1,0,0];%red
            pause(0.2);
            app.A_Lamp.Color=[0,1,0];%green
            pause(0.2);
        end
        
    elseif B_num>=2*A_num
        app.A_Lamp.Color=[1,0,0];
        app.winner_show.Text="乙军获胜";
        app.winner_show.FontColor=[1,0,0];
        for i = 1:3
            app.B_Lamp.Color=[1,0,0];%red
            pause(0.2);
            app.B_Lamp.Color=[0,1,0];%green
            pause(0.2);
        end
    else
        app.winner_show.Text="两败俱伤";
        app.winner_show.FontColor=[1,0.84,0];
        for i = 1:3
            app.B_Lamp.Color=[0,0,0];
            app.A_Lamp.Color=[0,0,0];
            pause(0.2);
            app.B_Lamp.Color=[1,0.84,0];
            app.A_Lamp.Color=[1,0.84,0];
            pause(0.2);
        end      
    end
end