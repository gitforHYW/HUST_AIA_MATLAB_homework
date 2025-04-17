function set_sta_data(app)
    %设置A的参数
    app.A_add_rate.Value = 0.3; % 增援率
    app.A_hit_rate.Value = 0.6; % 命中率
    app.A_shoot_rate.Value = 0.6; % 射击率
    app.A_initial_num.Value = 6100; % 初始兵力
    app.A_reduce_rate.Value = 0.04; % 非战斗减员率
    app.A_gue_rate.Value =0.6;%游击战比率
    app.A_area.Value = 21;%面积
    %设置B的参数
    app.B_add_rate.Value = 0.25; % 增援率
    app.B_hit_rate.Value = 0.6; % 命中率
    app.B_shoot_rate.Value = 0.4; % 射击率
    app.B_initial_num.Value = 9100; % 初始兵力
    app.B_reduce_rate.Value = 0.02; % 非战斗减员率
    app.B_gue_rate.Value = 0.5;%游击战比率
    app.B_area.Value = 18;%面积
    %仿真时间
    app.wartime.Value = 30;
end