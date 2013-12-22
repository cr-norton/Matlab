%Load image and initial needs
I = imread('Landscape.jpg');
I=im2double(I); % Convert the variable into double
imshow(I) % Display the image
m=size(I,1);
n=size(I,2);

% Add some noise to the image
for i=1:m
    for j=1:n
        I_noisy(i,j) = I(i,j)+((rand(1))-.5)/5;
    end
end

figure;
imshow(I_noisy);
diff_im = I_noisy;

%Constants
dx = 1;
dy = 1;
V = .5;
K = 30;
delta_t = 1/10;
num_iter = 15;

%Add noise to Image
for i = 1:m
    for j = 1:n
		r = ( j-1 )*m + i;
		U_old(r) = I_noisy( i, j );
    end
end

%Set Start point for diffusion - Will diffuse multiple times
U_new = U_old;

for t = 1:num_iter
    %Boundary Conditions
    
    %North & South
    for j = 2:n-1
        i = 1;
        r = ( j - 1 )*m + i;
        r_n = r - m;
        r_s = r + m;
        r_e = r + 1;
        r_w = r - 1;
        g_n = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r) )/(2*dx) )^2 + ( ( U_old(r_n) - U_old(r) )/dy )^2 ) );
        g_s = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r_s) )/dy )^2 ) );
        g_e = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
        g_w = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
        r_x1 = ( U_old(r_e) - U_old(r) ) / dx;
        r_x2 = ( abs(U_old(r) - U_old(r_e)) ) / dx;
        r_y1 = ( U_old(r_s) - U_old(r) ) / dy;
        r_y2 = ( U_old(r) - U_old(r_n) ) / dy;
        U_new(r) = U_old(r) + delta_t*( (g_e*r_x1 - g_w*r_x2)/dx + (g_n*r_y1 - g_s*r_y2)/dy );
    end
    for j = 2:n-1
        i = m;
        r = ( j - 1 )*m + i;
        r_n = r - m;
        r_s = r + m;
        r_e = r + 1;
        r_w = r - 1;
        g_n = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r) )/(2*dx) )^2 + ( ( U_old(r_n) - U_old(r) )/dy )^2 ) );
        g_s = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r_s) )/dy )^2 ) );
        g_e = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
        g_w = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
        r_x1 = ( U_old(r_e) - U_old(r) ) / dx;
        r_x2 = ( abs(U_old(r) - U_old(r_e)) ) / dx;
        r_y1 = ( U_old(r_s) - U_old(r) ) / dy;
        r_y2 = ( U_old(r) - U_old(r_n) ) / dy;
        U_new(r) = U_old(r) + delta_t*( (g_e*r_x1 - g_w*r_x2)/dx + (g_n*r_y1 - g_s*r_y2)/dy );
    end
    
    %East & West
    for i = 2:m-1
		j = 1;
        r = ( j - 1 )*m + i;
        r_n = r - m;
        r_s = r + m;
        r_e = r + 1;
        r_w = r - 1;
        g_n = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r) )/dy )^2 ) );
        g_s = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r_s) )/dy )^2 ) );
        g_e = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r) )/(2*dy) )^2 ) );
        g_w = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_w) )/dx )^2 + ( ( U_old(r_s) - U_old(r) )/(2*dy) )^2 ) );
        r_x1 = ( U_old(r_e) - U_old(r) ) / dx;
        r_x2 = ( U_old(r) - U_old(r_w) ) / dx;
        r_y1 = ( U_old(r_s) - U_old(r) ) / dy;
        r_y2 = ( U_old(r) - U_old(r) ) / dy;
        U_new(r) = U_old(r) + delta_t*( (g_e*r_x1 - g_w*r_x2)/dx + (g_n*r_y1 - g_s*r_y2)/dy );
    end
    for i = 2:m-1
        j = n;
        r = ( j - 1 )*m + i;
        r_n = r - m;
        r_s = r + m;
        r_e = r + 1;
        r_w = r - 1;
        g_n = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r_n) - U_old(r) )/dy )^2 ) );
        g_s = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r) )/dy )^2 ) );
        g_e = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( abs(( U_old(r) - U_old(r_n) ))/(2*dy) )^2 ) );
        g_w = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_w) )/dx )^2 + ( abs(( U_old(r) - U_old(r_n) )/(2*dy)) )^2 ) );
        r_x1 = ( U_old(r_e) - U_old(r) ) / dx;
        r_x2 = ( U_old(r) - U_old(r_w) ) / dx;
        r_y1 = ( U_old(r) - U_old(r) ) / dy;
        r_y2 = ( U_old(r) - U_old(r_n) ) / dy;
        U_new(r) = U_old(r) + delta_t*( (g_e*r_x1 - g_w*r_x2)/dx + (g_n*r_y1 - g_s*r_y2)/dy );
    end
    
    %Diffuse main picture
	for i = 2:m-1
		for j = 2:n-1
			r = ( j - 1 )*m + i;
			r_n = r - m;
			r_s = r + m;
			r_e = r + 1;
			r_w = r - 1;
			g_n = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r_n) - U_old(r) )/dy )^2 ) );
			g_s = V / ( 1 + (1/K)*sqrt( ( ( U_old(r_e) - U_old(r_w) )/(2*dx) )^2 + ( ( U_old(r) - U_old(r_s) )/dy )^2 ) );
			g_e = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_e) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
			g_w = V / ( 1 + (1/K)*sqrt( ( ( U_old(r) - U_old(r_w) )/dx )^2 + ( ( U_old(r_s) - U_old(r_n) )/(2*dy) )^2 ) );
			r_x1 = ( U_old(r_e) - U_old(r) ) / dx;
			r_x2 = ( U_old(r) - U_old(r_w) ) / dx;
			r_y1 = ( U_old(r_s) - U_old(r) ) / dy;
			r_y2 = ( U_old(r) - U_old(r_n) ) / dy;
			U_new(r) = U_old(r) + delta_t*( (g_e*r_x1 - g_w*r_x2)/dx + (g_n*r_y1 - g_s*r_y2)/dy );
		end
    end
    
    U_old = U_new;
end

%Convert Vector to Matrix for Imaging
for i = 1:m
	for j = 1:n
		r = ( j-1 )*m + i;
		U_grid( i, j ) = U_new(r);
	end
end

%Show new image
figure;
imshow(U_grid);