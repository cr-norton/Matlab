clear all;
clc;

%Set up Box
figure(1)
axis([0 10 0 20])
grid on
hold on

%Walls
wall_right = 10;
wall_left = 0;
wall_bottom = 0 ;
wall_top = 20;

%Time
deltat = .02;
tfinal = 60.0;
radius = 0.5;
t = 0.0;

%Initial Settings
velocity = [4 3];
position = [5 0];
collision_position = [5 14];
collision_velocity = [0 0];
magnitude = 5;

%Graphs
t_plot=t;

ball_magnitude = sqrt(velocity(1)*velocity(1)+velocity(2)*velocity(2));
collision_ball_magnitude = sqrt(collision_velocity(1)*collision_velocity(1)+collision_velocity(2)*collision_velocity(2));

y_plot= ball_magnitude;
x_plot= collision_ball_magnitude;
total_plot = magnitude;

while t<tfinal
    if t+deltat>tfinal
        deltat=tfinal-t;
    end
    
    %Draw Balls
    ball = rectangle('Position',[position(1) position(2) radius radius],'Curvature',[1,1]);
    collision_ball = rectangle('Position',[collision_position(1) collision_position(2) radius radius],'Curvature',[1,1]);
    set(collision_ball, 'edgecolor', 'r');
    daspect([1,1,1])
    drawnow;
    
    delete(ball);
    delete(collision_ball);
    
    %Update Position
    position = position + velocity*deltat;
    collision_position = collision_position + collision_velocity*deltat;

    %Determine collision position
    cd_1 = abs(position(1)-collision_position(1));
    cd_2 = abs(position(2)-collision_position(2));
    c_dist = sqrt(cd_1*cd_1 + cd_2*cd_2);
    
    %Collision between balls
    if c_dist < (2*radius)
        
        %Handle Unit Vectors
        top = position - collision_position;
        collision_magnitude = sqrt(top(1)*top(1) + top(2)*top(2));
        unit_normal = top/collision_magnitude;
        
        %Velocity Magnitudes
        velocity_1_magnitude = sqrt(velocity(1)*velocity(1)+velocity(2)*velocity(2));
        velocity_2_magnitude = sqrt(collision_velocity(1)*collision_velocity(1)+collision_velocity(2)*collision_velocity(2));
        
        if velocity_2_magnitude > velocity_1_magnitude
        	dot_1 = collision_velocity(1)*unit_normal(1)+collision_velocity(2)*unit_normal(2);     
            normal_1 = dot_1*(-unit_normal);
            temp = sqrt(collision_velocity(1)*collision_velocity(1)+collision_velocity(2)*collision_velocity(2));
            velocity = -normal_1;
            vel_mag = sqrt(velocity(1)*velocity(1)+velocity(2)*velocity(2));
            diff = magnitude-vel_mag;
            collision_velocity = diff*unit_normal;
        end

        if velocity_1_magnitude > velocity_2_magnitude
            dot_1 = velocity(1)*unit_normal(1)+velocity(2)*unit_normal(2);     
            normal_1 = dot_1*(-unit_normal);
            temp = sqrt(velocity(1)*velocity(1)+velocity(2)*velocity(2));
            collision_velocity = -normal_1;
            vel_mag = sqrt(collision_velocity(1)*collision_velocity(1)+collision_velocity(2)*collision_velocity(2));
            diff = magnitude-vel_mag;
            velocity = diff*unit_normal;
        end
        
        fprintf('COLLISION DETECTED\n');
    end
    
    %Ball hitting walls
    %%%%%%%%%%%%%%%%%%%
    %Hit Wall on the Right
    if position(1) > wall_right-radius
        velocity(1) = -velocity(1);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on the Left
    if position(1) < wall_left
        velocity(1) = -velocity(1);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on the Floor
    if position(2) < wall_bottom
        velocity(2) = -velocity(2);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on Ceiling
    if position(2) > wall_top-radius
        velocity(2) = -velocity(2);
        fprintf('COLLISION DETECTED\n');
    end
    
    
    %Collision_Ball hitting walls
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Hit Wall on the Right
    if collision_position(1) > wall_right-radius
        collision_velocity(1) = -collision_velocity(1);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on the Left
    if collision_position(1) < wall_left
        collision_velocity(1) = -collision_velocity(1);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on the Floor
    if collision_position(2) < wall_bottom
        collision_velocity(2) = -collision_velocity(2);
        fprintf('COLLISION DETECTED\n');
    end
    %Hit Wall on Ceiling
    if collision_position(2) > wall_top-radius
        collision_velocity(2) = -collision_velocity(2);
        fprintf('COLLISION DETECTED\n');
    end
    
    t=t+deltat;
    
    ball_magnitude = sqrt(velocity(1)*velocity(1)+velocity(2)*velocity(2));
    collision_ball_magnitude = sqrt(collision_velocity(1)*collision_velocity(1)+collision_velocity(2)*collision_velocity(2));
    
    t_plot=[t_plot t];
    y_plot = [y_plot ball_magnitude];
    x_plot = [x_plot collision_ball_magnitude];
end

xlabel('x');
ylabel('height');
title('Euler Method of Falling Ball in 2D');

figure(2)
axis([0 1 0 1])
plot(t_plot, y_plot,'ro', t_plot, x_plot);
xlabel('time');
ylabel('value');
title('Position of x & y: y is red, x is blue');
grid on
hold on