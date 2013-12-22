clear all;
clc;

deltat = 0.03;
tfinal = 50.0;
radius = 0.05;
t = 0.0;

velocity = [0.3 0.1 0.2];
gravity = [0 -.0981 0];
position = [0.5 1-radius 0.5];

%Set up Box
figure(1)
axis([0 1 0 1 0 1])
grid on
hold on

alpha = .8;
beta = .99;

t_plot = t;
y_plot= position(2);
x_plot= position(1);
z_plot= position(3);

while t<tfinal
    if t+deltat>tfinal
        deltat=tfinal-t;
    end

    [x, y, z] = sphere;
    surf(radius*x+position(1), radius*y+position(2), radius*z+position(3));
    drawnow;
    
    
    %Update Velocity
    velocity = velocity + gravity*deltat;
    
    %Update Position
    position = position + velocity*deltat;
    
    %Account for Friction
    
    %Hit Wall on X and Y and Z
    if position(1) > 1.00-radius && position(2)>1.0-radius && position(3)>1.00-radius
        position(1) = 1.0 - radius;
        position(2) = 1.0 - radius;
        position(3) = 1.0 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal(2) = -normal(2);
        normal(3) = -normal(3);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on X and Z
    if position(1) > 1.00-radius && position(3)>1.00-radius
        position(1) = 1.0 - radius;
        position(2) = 1.0 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal(3) = -normal(3);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    if position(1) < radius && position(3) < radius
        position(1) = radius;
        position(2) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal(3) = -normal(3);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on X and Y
    if position(1) > 1.00-radius && position(2)>1.00-radius
        position(1) = 1.0 - radius;
        position(2) = 1.0 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal(2) = -normal(2);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    if position(1) < radius && position(2) < radius
        position(1) = radius;
        position(2) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal(2) = -normal(2);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end

    %Hit Wall on Y and Z
    if position(2) > 1.00-radius && position(3)>1.00-radius
        position(2) = 1.0 - radius;
        position(3) = 1.0 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        normal(3) = -normal(3);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    if position(2) < radius && position(3) < radius
        position(2) = radius;
        position(3) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        normal(3) = -normal(3);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on X
    if position(1) > 1.00-radius
        position(1) = 1 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on X
    if position(1) < radius
        position(1) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(1) = -normal(1);
        normal = normal*alpha;
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Floor
    if position(2) < radius
        position(2) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on Z
    if position(3) > 1.00 - radius
        position(3) = 1.0 - radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;        
        normal(3) = -normal(3);
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on Z
    if position(3) < radius
        position(3) = radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(3) = -normal(3);
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    %Hit Wall on Ceiling
    if position(2) > 1-radius
        position(2) = 1-radius;
        tan = velocity;
        tan = tan*beta;
        velocity = tan;
        normal = velocity;
        normal(2) = -normal(2);
        velocity = normal;
        fprintf('COLLISION DETECTED\n');
    end
    
    t=t+deltat;
    
    t_plot=[t_plot t];
	y_plot=[y_plot position(2)];
	x_plot=[x_plot position(1)];
    z_plot=[z_plot position(3)];
    
end

xlabel('x');
ylabel('y');
zlabel('z');
title('Euler Method of Falling Ball');

figure(2)
axis([0 1 0 1])
plot(t_plot, y_plot,'ro', t_plot, x_plot, t_plot, z_plot);
xlabel('time');
ylabel('value');
title('Position of x & y & z: y is red, x is blue, z is green');
grid on
hold on
