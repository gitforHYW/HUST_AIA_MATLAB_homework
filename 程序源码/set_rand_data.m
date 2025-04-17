function set_rand_data(app)
    %设置A的随机参数
    app.A_add_rate.Value = round(unifrnd(0.001, 0.5),3); % 增援率
    app.A_hit_rate.Value = round(unifrnd(0.4, 0.9),2); % 命中率
    app.A_shoot_rate.Value = round(unifrnd(0.1, 0.9),2); % 射击率
    app.A_initial_num.Value = round(unifrnd(100, 10000)); % 初始兵力
    app.A_reduce_rate.Value = round(unifrnd(0.001, 0.05),3); % 非战斗减员率
    app.A_gue_rate.Value = round(unifrnd(0, 1),2);%游击战比率
    app.A_area.Value = round(unifrnd(10, 50));%面积
    %设置B的随机参数
    app.B_add_rate.Value = round(unifrnd(0.001, 0.5),3); % 增援率
    app.B_hit_rate.Value = round(unifrnd(0.4, 0.9),2); % 命中率
    app.B_shoot_rate.Value = round(unifrnd(0.1, 0.9),2); % 射击率
    app.B_initial_num.Value = round(unifrnd(100, 10000)); % 初始兵力
    app.B_reduce_rate.Value = round(unifrnd(0.001, 0.05),3); % 非战斗减员率
    app.B_gue_rate.Value =round(unifrnd(0, 1),2);%游击战比率
    app.B_area.Value =round(unifrnd(10, 50));%面积
    %仿真时间
    app.wartime.Value = round(unifrnd(10,100));
end