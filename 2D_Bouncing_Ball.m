clear all;
clc;

%Set up Box
figure(1)
axis([0 1 0 1])
grid on
hold on

deltat = 0.03;
tfinal = 35.0;
radius = 0.005;
t = 0.0;

velocity = [0.3 0];
gravity = [0 -.0981];
position = [0.5 1-radius];

alpha = .8;
beta = .99;

t_plot=t;
y_plot= position(2);
x_plot= position(1);

while t<tfinal
    if t+deltat>tfinal
        deltat=tfinal-t;
    end
    
    ball = rectangle('Position',[position(1) position(2) radius radius],'Curvature',[1,1]);
    daspect([1,1,1])
    drawnow;

    %Update Velocity
    velocity = velocity + gravity*deltat;
    
    %Update Position
    position = position + velocity*deltat;
    
    %Account for Friction
    
    %Hit Wall on the Right
    if position(1) > 1.00-radius
        position(1) = 1.0-radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal = normal*alpha;
        velocity = normal;
    end
    
    %Hit Wall on the Left
    if position(1) < radius
        position(1) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal = normal*alpha;
        velocity = normal;
    end
    
    %Hit Wall on the Floor
    if position(2) < radius
        position(2) = radius
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        normal = normal*alpha;
        velocity = normal;
    end
    
    %Hit Wall on Ceiling
    if position(2) > 1-radius
        position(2) = 1 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        normal = normal*alpha;
        velocity = normal;
    end

    t=t+deltat;
    
    t_plot=[t_plot t];
	y_plot=[y_plot position(2)];
	x_plot=[x_plot position(1)];
    
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

