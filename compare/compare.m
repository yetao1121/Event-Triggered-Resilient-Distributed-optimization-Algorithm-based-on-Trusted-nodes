n = 9;
k_max = 800;

[x_axis1, ~] = ETRDO_T(1);
[x_axis2, ~] = ETRDO_T(2);
[x_axis3, ~] = ETRDO_T(3);
[x_axis4, k_axis] = ETRDO_T(4);

figure(1);
subplot(2, 2, 1);
for i = 1:1:n
    if i == 2 || i == 3
        plot(k_axis,x_axis1{i},'--','LineWidth',1.5);
    else
        plot(k_axis,x_axis1{i},'LineWidth',1.5);
    end
    hold on;
    axis([0 k_max 0 65]);
end
grid on;
title('(a)事件触发阈值为 0 的状态收敛轨迹');
xlabel('迭代步数k');
ylabel('每个节点状态\lambda_{i}(k)')
legend('智能体1', '智能体2', '智能体3', '智能体4', '智能体5', '智能体6', '智能体7', '智能体8', '智能体9');

subplot(2, 2, 2);
for i = 1:1:n
    if i == 2 || i == 3
        plot(k_axis,x_axis2{i},'--','LineWidth',1.5);
    else
        plot(k_axis,x_axis2{i},'LineWidth',1.5);
    end
    hold on;
    axis([0 k_max 0 65]);
end
grid on;
title('(b)事件触发阈值为 5/(1+k) 的状态收敛轨迹');
xlabel('迭代步数k');
ylabel('每个节点状态\lambda_{i}(k)')
legend('智能体1', '智能体2', '智能体3', '智能体4', '智能体5', '智能体6', '智能体7', '智能体8', '智能体9');

subplot(2, 2, 3);
for i = 1:1:n
    if i == 2 || i == 3
        plot(k_axis,x_axis3{i},'--','LineWidth',1.5);
    else
        plot(k_axis,x_axis3{i},'LineWidth',1.5);
    end
    hold on;
    axis([0 k_max 0 65]);
end
grid on;
title('(c)事件触发阈值为 50/(1+k) 的状态收敛轨迹');
xlabel('迭代步数k');
ylabel('每个节点状态\lambda_{i}(k)')
legend('智能体1', '智能体2', '智能体3', '智能体4', '智能体5', '智能体6', '智能体7', '智能体8', '智能体9');

subplot(2, 2, 4);
for i = 1:1:n
    if i == 2 || i == 3
        plot(k_axis,x_axis4{i},'--','LineWidth',1.5);
    else
        plot(k_axis,x_axis4{i},'LineWidth',1.5);
    end
    hold on;
    axis([0 k_max 0 65]);
end
grid on;
title('(d)事件触发阈值为 100/(1+k) 的状态收敛轨迹');
xlabel('迭代步数k');
ylabel('每个节点状态\lambda_{i}(k)')
legend('智能体1', '智能体2', '智能体3', '智能体4', '智能体5', '智能体6', '智能体7', '智能体8', '智能体9');