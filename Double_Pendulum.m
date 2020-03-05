%% Double Pendulum 
% Daniel Huang
% Double Pendulum simulation with massless rods 
%% Setup
clc;clear;close all
global m1 m2 r1 r2 g
m1 = 5; % Mass of weight [kg]
m2 = 3; % Mass of joint [kg]
r1 = 3; % Length of (0,0) to joint [m]
r2 = 3; % Length of joint to weight [m]
g = 9.81; % Acceleration due to gravity [m/s^2]
% Phi: Angle between r1 and r2
phi0 = pi; % Initial angle of phi [rad]
phid0 = 0; % Initial angular velocity of phi [rad/s]
% Theta (the): Angle between global vertical and r1 
the0 = 0; % Initial angle of theta [rad]
thed0 = 0; % Initial angular velocity of theta [rad/s]
t0 = 0; % Initial time [s]
t1 = 100; % Final time [s]
tspan = [t0 t1];
Initials = [the0;thed0;phi0;phid0]';
% Solve using ODE45 (Large steps, more work per step)
sol(1) = ode45(@(t,x)eqn(t,x),tspan,Initials,[]);
% Solve using ODE23 (Small steps, less work per step)
sol(2) = ode23(@(t,x)eqn(t,x),tspan,Initials,[]);

%% Plots of phi and theta
subplot(2,1,1)
plot(sol(1).x,sol(1).y(1,:),sol(2).x,sol(2).y(1,:),'--')
title('\theta vs time')
legend('ODE45','ODE23')
xlabel('Time [s]')
ylabel('\theta [rad]')

subplot(2,1,2)
plot(sol(1).x,sol(1).y(3,:),sol(2).x,sol(2).y(3,:),'--')
title('\phi vs time')
legend('ODE45','ODE23')
xlabel('Time[s]')
ylabel('\phi [rad]')

%% Position - Animation with trailing points. 
fprintf('Choose an ODE solver to animate:\n1. ODE45\n2. ODE23\n')
n = input('Please input "1" or "2": ');
if n == 1 || n == 2
    t = sol(n).x;
    phi = sol(n).y(3,:);
    the = sol(n).y(1,:);
    Px = r2*sin(phi).*cos(the)+(r1+r2*cos(phi)).*sin(the);
    Py = r2*sin(phi).*sin(the)-(r1+r2*cos(phi)).*cos(the);
    Px1 = r1*sin(the);
    Py1 = -r1*cos(the);
    a = 1.1*(r1+r2);

    figure(3)
    for ii = 1:length(t)-2
        drawnow
        plot([Px(ii+2) Px1(ii+2)],[Py(ii+2) Py1(ii+2)],'k',Px(ii+1),Py(ii+1),'b.',...
            Px(ii),Py(ii),'b.',[Px1(ii+2) 0],[Py1(ii+2) 0],'r');
        axis('square')
        time = num2str(t(ii+2));
        label = strcat(time, ' [s]');
        legend(label)
        
        xlim([-a a])
        ylim([-a a])
        %pause(0.1)
    end
else
    fprintf('Invalid input.\n')
end

fprintf('Press any key to continue...\n')
pause()

%% Plot 3D (t,x,y)
t = sol(1).x;
phi = sol(1).y(3,:);
the = sol(1).y(1,:);

Px = r2*sin(phi).*cos(the)+(r1+r2*cos(phi)).*sin(the);
Py = r2*sin(phi).*sin(the)-(r1+r2*cos(phi)).*cos(the);

t2 = sol(2).x;
phi2 = sol(2).y(3,:);
the2 = sol(2).y(1,:);

Px2 = r2*sin(phi2).*cos(the2)+(r1+r2*cos(phi2)).*sin(the2);
Py2 = r2*sin(phi2).*sin(the2)-(r1+r2*cos(phi2)).*cos(the2);

figure(4)
plot3(t,Px,Py,'r',t2,Px2,Py2,'b--')
title('3D Trajectory vs Time')
xlabel('Time [s]')
ylabel('x-distance [m]')
zlabel('y-distance [m]')
legend('ODE45','ODE23')

