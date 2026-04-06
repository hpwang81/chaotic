function f=hm4_ext(t,X)

x=X(1); 
y=X(2); 
z=X(3);

global a
Y= [X(4), X(7),X(10);
    X(5), X(8),X(11);
    X(6), X(9),X(12)];

f=zeros(9,1);
    
%%%%%%%%%%%%%%shilnikov
% 
tt=10;
w=0.3;
% a=0.01;
b=0.5;
c=2;
fz=(z*z-b);
gxy=a-x*x-c*y*y;
f(1)=tt*(-w*y+fz*x);
f(2)=tt*(w*x+fz*y);
f(3)=tt*(gxy*z);

Jac=tt*[ z^2 - b,       -w,             2*x*z;
              w,  z^2 - b,             2*y*z;
           -2*x*z, -2*c*y*z, - x^2 - c*y^2 + a]; 

%cang的新系统

% tt=1;
% a=1;
% b=2;
% c=2;
% f(1)=tt*((z-b)*x-y);
% f(2)=tt*(x+(z-b)*y);
% f(3)=tt*((a-c*x*x-y*y)*z);
% Jac=tt*[ z - b,     -1,                 x;
%          1,      z - b,                 y;
%          -2*c*x*z, -2*y*z, - c*x^2 - y^2 + a];  

f(4:12)=Jac*Y;

