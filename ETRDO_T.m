clear;clc;
n = 9;

%local cost function
syms x;
a = [13, 18, 2, 65, 46, 66, 12, 65, 30];
b = [35, 50, 57, 46, 51, 34, 59, 46, 48];
c = [8, 18, 17, 9, 14, 12, 15, 13, 5];

Fx = {[],[],[],[],[],[],[],[]};
for i =1:n
    Fx{i} = a(i) * sqrt( ( x - b(i) )^2 + c(i)^2 );
end

count = zeros(1,n);             % Record the trigger times of each node
x_state = zeros(1,n);           % Real-time states of each node
x_trig = zeros(1,n);            % states of the last trigger time of each node
error = zeros(1,n);             % Difference between the current time state and the last triggering time state
k_max = 800;                    % Maximum Iterations
NoneET = k_max * ones(1, n);

% Use a two-dimensional array to store the states of each iteration
for i = 1:n
    x_axis{i} = [];
    k_trig{i} = [];
end
k_axis = [];

% Main iteration part
for k = 1 : 1 : k_max
    ak = 1 / ( 1 + k );         % Iteration step length
    Ek = 5 / ( 1 + k );        % Event trigger threshold
    
    for i = 1 : 1 : n
        
        % The set of neighbors for each node
        N{1} = [ x_state(1), x_trig(4) ];
        N{2} = [ x_state(2), x_trig(4), x_trig(5) ];
        N{3} = [ x_state(3), x_trig(4), x_trig(6) ];
        N{4} = [ x_trig(1), x_trig(2), x_trig(3), x_state(4), x_trig(5), x_trig(6) ];
        N{5} = [ x_trig(2), x_trig(4), x_state(5), x_trig(7), x_trig(8) ];
        N{6} = [ x_trig(3), x_trig(4), x_state(6), x_trig(8), x_trig(9) ];
        N{7} = [ x_trig(5), x_state(7)];
        N{8} = [ x_trig(5), x_trig(6), x_state(8)];
        N{9} = [ x_trig(6), x_state(9)];

        % The set of trusted neighbors for each node
        T{1} = [ x_state(1), x_trig(4) ];
        T{2} = [ x_state(2), x_trig(4), x_trig(5) ];
        T{3} = [ x_state(3), x_trig(4), x_trig(6) ];
        T{4} = [ x_state(4), x_trig(5), x_trig(6) ];
        T{5} = [ x_trig(4), x_state(5) ];
        T{6} = [ x_trig(4), x_state(6) ];
        T{7} = [ x_trig(5), x_state(7)];
        T{8} = [ x_trig(5), x_trig(6), x_state(8)];
        T{9} = [ x_trig(6), x_state(9)];
        
        % Filter valid states
        T{i} = sort( T{i} );
        R = { [], [], [], [], [], [], [], [], [] };
        for j = 1 : 1 : length( N{i} )
            if N{i}(j) >= T{i}(1) && N{i}(j) <= T{i}(end)
                    R{i}(end+1) = N{i}(j);
            end
        end

        % update
        sigma = 0;
        for m = 1:length(R{i})
            sigma = sigma + R{i}(m);
        end
        dy=[];
        dFx = diff(Fx{i});
        dy(i) = subs(dFx, x, x_state(i));

        x_state(i) = 1 / ( length( R{i} ) ) * sigma - ak * dy(i);
        
        % Simulate malicious node behavior
        x_state(2) = 30 * sin ( 0.005 * pi * k ) + 30;
        x_state(3) = ( k / 100 )^2;     
        
        % Event Trigger Decision
        error(i) = norm( x_state(i) - x_trig(i) );
        if error(i) >= Ek
            x_trig(i) = x_state(i);
            count(i) = count(i) + 1;
            k_trig{i}(end + 1) = k;
        end

        x_axis{i}(end+1) = x_state(i);
    end
     k_axis(end+1) = k;
     
end

figure(1);
for i = 1:1:n
    if i == 2 || i == 3
        plot(k_axis,x_axis{i},'--','LineWidth',1.5);
    else
        plot(k_axis,x_axis{i},'LineWidth',1.5);
    end
    hold on;
    axis([0 k_max 0 65]);
end
grid on;
title('(a)\lambda收敛过程');
xlabel('迭代步数k');
ylabel('每个节点状态\lambda_{i}(k)')
legend('智能体1', '智能体2', '智能体3', '智能体4', '智能体5', '智能体6', '智能体7', '智能体8', '智能体9');

figure(3);
node = [1,2,3,4,5,6,7,8,9];
bar(node, [count; NoneET]');
title('(b)通信次数对比');
xlabel('节点编号');
ylabel('与邻居信息交互次数');
legend('事件触发通信','连续时间通信');

figure(4)
for tmp_node = 1 : 1 : n
    subplot(3, 3, tmp_node)
    trig_value = [];
    for i = 1:1:length(k_trig{tmp_node})
        trig_value(end + 1) = x_axis{tmp_node}(k_trig{tmp_node}(i));
    end
    stem(k_trig{tmp_node},trig_value,'LineWidth',0.5);
    title(sprintf('节点 %d 的触发时刻状态', tmp_node));
    xlabel('迭代次数k');
    ylabel('触发时刻值');
end