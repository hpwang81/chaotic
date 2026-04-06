clear
close all
clc

global a b c w
w=0.3;
a=0.25;
b=2;
c=0.5;

% 计算关键参数
z1=sqrt(c);           % 水平分界线位置 ≈0.707
ymax=sqrt(a/b);       % 垂直分界线位置 ≈0.353

% 设置图形范围
y_min = -1.3;   y_max = 1.3;
z_min = -2; z_max = 2;

% 定义四种填充颜色 [R G B]
color_corner = [0.99 0.96 0.84];  
color_topbot = [0.9 0.94 0.8]; 
color_leftright = [0.85 0.92 0.96]; 
color_center = [0.98 0.9 0.8];  

figure;
hold on;

% 1. 填充四个角（左上、右上、左下、右下）
% 左上
fill([y_min -ymax -ymax y_min], [z1 z1 z_max z_max], color_corner, 'EdgeColor', 'none');
% 右上  
fill([ymax y_max y_max ymax], [z1 z1 z_max z_max], color_corner, 'EdgeColor', 'none');
% 左下
fill([y_min -ymax -ymax y_min], [-z1 -z1 z_min z_min], color_corner, 'EdgeColor', 'none');
% 右下
fill([ymax y_max y_max ymax], [-z1 -z1 z_min z_min], color_corner, 'EdgeColor', 'none');

% 2. 填充上下边条（上中、下中）
% 上中
fill([-ymax ymax ymax -ymax], [z1 z1 z_max z_max], color_topbot, 'EdgeColor', 'none');
% 下中
fill([-ymax ymax ymax -ymax], [-z1 -z1 z_min z_min], color_topbot, 'EdgeColor', 'none');

% 3. 填充左右边条（左中、右中）
% 左中
fill([y_min -ymax -ymax y_min], [-z1 -z1 z1 z1], color_leftright, 'EdgeColor', 'none');
% 右中
fill([ymax y_max y_max ymax], [-z1 -z1 z1 z1], color_leftright, 'EdgeColor', 'none');

% 4. 填充中心区域
fill([-ymax ymax ymax -ymax], [-z1 -z1 z1 z1], color_center, 'EdgeColor', 'none');

% 绘制轨迹（使用不同颜色区分上下）
colors = {[0.2 0.6 0.9], [0.9 0.4 0.2],[0.00 0.60 0.30],[0.80 0.40 0.00]};  % 蓝色（上）、橙红色（下）

for i=1:4
    x0=[0  0.5    0.5;...
        0  0.5    -0.5;...
        0.92  0.5    0.5;...
        0.92  0.5    -0.5];
    
    options=odeset('RelTol',1e-9 , 'AbsTol',1e-9);
    [t,x1]=ode45(@sys_model_ode,[0 2000],x0(i,:),options);
    
    n1=length(x1(:,1));    
    span1=round(n1*0.25):n1;  % 舍弃前25%暂态
    
    plot(x1(span1,2),x1(span1,3), 'Color', colors{i}, 'LineWidth', 0.8);
end

% 绘制参考线
plot([y_min y_max],[z1 z1],'r-.','LineWidth',0.8);      % 上水平红线
plot([y_min y_max],[-z1 -z1],'r-.','LineWidth',0.8);    % 下水平红线
plot([y_min y_max],[0 0],'k-','LineWidth',0.8);         % z=0轴线

plot([ymax ymax],[z_min z_max],'b-.','LineWidth',0.8);   % 右垂直绿线
plot([-ymax -ymax],[z_min z_max],'b-.','LineWidth',0.8); % 左垂直绿线
plot([0 0],[z_min z_max],'k-','LineWidth',0.8);          % y=0轴线

% 设置坐标轴属性
axis([y_min y_max z_min z_max]);
% axis equal;
box on;
set(gca,'Layer','top');  % 确保坐标轴线在填充层之上
set(gcf,'PaperType','a2');
set(gca,'Position',[.15 .15 .8 .8]);
set(gcf,'Renderer','painters');
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1);

xlabel('$y$','Interpreter','latex','FontSize',18);
ylabel('$z$','Interpreter','latex','FontSize',18);