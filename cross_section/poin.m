clc
clear all
close all

a=0.25;
b=2;
c=0.5;
w=0.3;

t_start=0;
t_final=5000;

ts=[t_start,t_final];

RelTol=1e-9;            %Relative tolerance
AbsTol=1e-9;            %Absolute tolerance
options=odeset('RelTol',RelTol,'AbsTol',AbsTol);


% xx=normrnd(0,1,[10,1]);
% yy=normrnd(0,1,[10,1]);
xx=-1:0.1:1;
yy=-2:0.1:2;
zz=0.5;

[x0,y0,z0] = meshgrid(xx,yy,zz);
X0=x0(:);
Y0=y0(:);
Z0=z0(:);
XX0=[X0,Y0,Z0];
Pxy_z0=[];
% 
parfor i=1:length(X0)

% for i=1:length(X0)
    XX0(i,:)
    [t,x]=ode45(@(t,X) sys_model_ode(t,X,a,b,c,w),ts,XX0(i,:),options);
    N=length(x(:,1));
    lxy=0;
    Pxy=zeros(50000,2);
    k0=round(0.3*N);
    az=0.2;
    for k=k0:(N-1)
        if (x(k,3)-az)*(x(k+1,3)-az)<0
            lxy=lxy+1;
            m=(x(k+1,1)-x(k,1))/(x(k+1,3)-x(k,3));
            n=(x(k+1,2)-x(k,2))/(x(k+1,3)-x(k,3));
            Pxy(lxy,1)=-m*(x(k,3)-az)+x(k,1);
            Pxy(lxy,2)=-n*(x(k,3)-az)+x(k,2);
        end
    end
    Pxy_z0(:,:,i)=Pxy;
end
mmx=[];
for i=1:length(X0)
    flag=find(Pxy_z0(:,1,i)~=0);  %%除掉Pxy中多余的0
    mmx=[mmx;max(Pxy_z0(flag,1,i))-min(Pxy_z0(flag,1,i))];
    hold on
    plot(Pxy_z0(flag,1,i),Pxy_z0(flag,2,i),'.','MarkerSize',2);
end
box on
% figure
% plot(mmx)

box on

xlabel('$y_n$','Interpreter','latex','FontSize',20);
ylabel('$z_n$','Interpreter','latex','FontSize',20);
%plot(x(k0:N,1),x(k0:N,2))

%% 图形设置
% set (gcf,'windowstyle','normal')
% set(gcf,'unit','centimeters','position',[5 3 25 18]) %%5表示图形窗口距离显示屏左边5cm，3为距离显示屏下边3cm，30表示图形的长度，20表示高度
% set(gca,'Position',[.15 .15 0.6 .8]); %%0.15表示坐标轴左下角距离图形窗口左边0.15，下边0.15，0.6表示占图形窗口长度60%，0.8表示占图形窗口高度80%
% set(gca, 'LineWidth',1);
% set(gca,'FontSize',20);
% set(gca,'FontWeight','bold');
% set(gcf,'PaperType','a3');
% set(gcf,'Renderer','painters');
% saveas(gcf,'fig20210513','pdf')
% % % saveas(gcf,'figfig20210323','epsc')
% saveas(gcf,'bif0513a','png')
% print bif0513.png -dpng -r300




function xdot=sys_model_ode(t,X,a,b,c,w)
x=X(1);
y=X(2);
z=X(3);

fz=(z*z-c);%%%% 1D_xi_tong
gxy=(a-x*x-b*y*y);

xdot(1)=-w*y+fz*x;
xdot(2)=w*x+fz*y;
xdot(3)=gxy*z;




xdot=1*xdot';
end

