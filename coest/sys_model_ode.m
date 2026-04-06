function xdot=sys_model_ode(t,X)
global a b c w
x=X(1);
y=X(2);
z=X(3);


fz=z^2-c;
gxy=a-x*x-b*y*y;

xdot(1)=fz*x-w*y;
xdot(2)=w*x+fz*y;
xdot(3)=gxy*z;


xdot=1*xdot';