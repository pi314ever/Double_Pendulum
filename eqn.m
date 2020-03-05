function [xdot] = eqn(t,x)
global m1 m2 r1 r2 g 

xdot = zeros(4,1);

xdot(1) = x(2);
xdot(3) = x(4);

bot = (m1*r1*cos(x(3)).*(m2*r1*cot(x(3))-m1*r2*sin(x(3)))+m1*r2*sin(x(3)).*(m2*r1*+m1*r1+m1*r2*cos(x(3))));
top = (-(-m1*(x(2)+x(4)).^2*r2.*sin(x(3))+m2*g*sin(x(1))+m1*g*sin(x(1))).*(m2*r1*cot(x(3))-m1*r2*sin(x(3)))...
    -(m2*r1+m1*r1+m1*r2*cos(x(3))).*(m1*r1*x(2).^2+m1*(x(2)+x(4)).^2*r2.*cos(x(3))-m2*g*sin(x(1)).*cot(x(3))+m1*g*cos(x(1))));
xdot(4) = (top/bot);
xdot(2) = ((m1*r2*xdot(4).*cos(x(3))-m1*(x(2)+x(4)).^2*r2.*sin(x(3))+m2*g*sin(x(1))+m1*g*sin(x(1)))/...
    (-m2*r1-m1*r1-m1*r2*cos(x(3))));
%xdot = xdot';

end

