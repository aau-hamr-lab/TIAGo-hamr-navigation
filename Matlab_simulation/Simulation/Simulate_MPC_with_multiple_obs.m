function Simulate_MPC_with_multiple_obs (t,x_ol,x_cl,u_cl,x_goal,N,rob_diameter,n_obstacle, obs_param)
%% Figure setup
figure(100)
fig = gcf; %Current figure handle
fig.Color = 'w';
fig.Units = 'normalized';
fig.OuterPosition = [0 0 0.5 1];
fig.PaperPositionMode = 'auto';

%% Draw simulation

% Footprint of the robot
robot_radius = rob_diameter/2;
draw_ang=0:0.005:2*pi;               % angles for to draw the robot
x_robot = robot_radius*cos(draw_ang);
y_robot = robot_radius*sin(draw_ang);

% arrow triangle parameters
arrow_h = 0.1; arrow_w=0.05;

x_obs = [];
y_obs = [];

% obstacle represent
for k = 1:n_obstacle
    x_obs = [x_obs; obs_param(k, 3)/2*cos(draw_ang)];
    y_obs = [y_obs; obs_param(k, 3)/2*sin(draw_ang)];
end

x_driven = [];
y_driven = [];

step_size = 1;

for k = 1:step_size:size(x_ol,2) % go through the open loop
    % Plot goal position
    plotArrow(x_goal(1), x_goal(2), x_goal(3), robot_radius, arrow_h, arrow_w, 'g')
    hold on
    
    % Plot obstacle
    for j = 1:n_obstacle
        plot(obs_param(j,1)+x_obs(j,:),obs_param(j,2)+y_obs(j,:),'k', 'LineWidth', 1.5)
        hold on
        plot(obs_param(j,1), obs_param(j,2),'k.')
        hold on
    end
    
    % Plot the driven (executed) trajectory
    x1 = x_ol(1,k,1); y1 = x_ol(2,k,1); th1 = x_ol(3,k,1);
    x_driven = [x_driven x1];
    y_driven = [y_driven y1];
    
    plot(x_driven,y_driven,'b','linewidth', 1.5); % plot exhibited trajectory
    hold on 
    
    % Plot prediction
    if k < size(x_ol,2)
        plot(x_cl(1:N,1,k), x_cl(1:N,2,k), 'r--*')
        for i = 2:N+1
            plot(x_cl(i,1,k)+x_robot, x_cl(i,2,k)+y_robot,'--r');     % plot robot footprint in predictions
        end
    end

    % Plot Robot footprint
    plotArrow(x1, y1, th1, robot_radius, arrow_h, arrow_w, 'k');
    plot(x1+x_robot,y1+y_robot,'k');      % plot robot circle
    
    hold off
    
    ylabel('$y$-position [m]','interpreter','latex','FontSize', 16)
    xlabel('$x$-position [m]','interpreter','latex','FontSize', 16)
    axis([-.2 x_goal(1)+1 -.2 x_goal(2)+1])
    
    %pause(0.1)
    
    box on;
    grid on;
    drawnow
end
%close(gcf)
