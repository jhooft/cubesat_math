%Place a point mass cubesat into orbit with intial conditions.
%No oblateness of Earth. Orbital precession from angular velocity of Earth.
%%Need to check integration time stamps against projected clock time.

function orbit_1

Re = 6.371*10^6; % m                         Radius of Earth
G = 6.67408 * 10^(-11); % m^3 kg^-1 s^-2     Gravitational constant
m = 1.2;  % kg                               mass of cubesat
M = 5.972 * 10^24; % kg                      mass of Earth

omega_e = 7.29 * 10^(-5); % s^-1   (ie radians per second)   angular vel/frequency??? Earth around geographic North
omega_se = 1.99 * 10^(-7);  % s^-1                           angular vel Earth around sun
%%%   w can be chosen to be the sum of these if desired (under correct
%%%   computational conditions)
w = omega_e;

%%%%%%%%%%%%%%%%%%%% set initial conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = 0; 
y0 = 0;            % (x,y,z) = (0,0,*) indicates starting directly above north pole
z0 = Re + 500000;  % 500000 m = 500 km
xd0 = 7777;        % 7777 m s^-1 = 28000 km hr^-1  
yd0 = 0;           % (xd,yd,zd) = (*,0,0) indicates heading directly toward vernal equinox
zd0 = 0;

%%%%%%%%%%%%%%%%%%%%%%%% set time steps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0 = 0;
tf = 39000;%arbitrary - we'll unpack the results of integration into a vector that can be querried after the fact

p0 = [x0 y0 z0 xd0 yd0 zd0]'; %vector of initial position and velocity data
[t,p] = ode45(@orbit,[t0 tf],p0); %integrate

%%%unpack data from vector of integration results [t,p]
XX = p(:,1); YY = p(:,2); ZZ = p(:,3);

plot_orbit(1)            % argument 1 to show 'earth', 0 to omit
%display_data(t,2);      %send vector of times and desired step increment for display 
display_final_state

function dp = orbit(t,p)
    x = p(1); y = p(2); z = p(3);
    xd = p(4); yd = p(5); zd = p(6);
    r = sqrt(x^2 + y^2 + z^2);                 %distance from center of Earth
    xdd = -(G*M/(r^3))*x + 2*w*yd + w^2*x;     % x acceleration
    ydd = -(G*M/(r^3))*y - 2*w*xd + w^2*y;     % y acceleration
    zdd = -(G*M/(r^3))*z;                      % z acceleration
    dp = [xd yd zd xdd ydd zdd]';
end %function orbit

function plot_orbit(show_earth)
    if show_earth==1
        [a,b,c]=sphere(60); 
        surf(a*Re,b*Re,c*Re);                %sphere with radius of earth centered at origin
        colormap winter                      %blue green color scheme on sphere
        shading interp                       %no grid lines on sphere
        hold on
    end    
    plot3(XX, YY, ZZ, 'r');
    xlabel('x - positive to vernal equinox')
    ylabel('y')
    zlabel('z - positive to geographic north')
    xlim([-9*10^6 9*10^6])
    ylim([-9*10^6 9*10^6])
    zlim([-9*10^6 9*10^6])
end %function plot_orbit    

function display_final_state
    [s t]=size(p);
    disp(p(s,:))
    final_vec=p(s,:);
    xf=final_vec(1);
    yf=final_vec(2);
    zf=final_vec(3);
    %xdf=final_vec(4);
    %ydf=final_vec(5);
    %zdf=final_vec(6);
    r=sqrt(xf^2 + yf^2 + zf^2);
    altitude = r-Re;
    fprintf('Final altitude above surface is: %d m', altitude);    
end %function display_final_state

function display_data(t,increment)
    %disp('   t_step        x       y       z       xd        yd       zd');
    for i=1:increment:length(t)   
        disp([t(i) p(i,:)]);
    end 
end %function display_data

end %function orbit_1
