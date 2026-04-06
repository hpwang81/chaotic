clear 
close all
clc

global a

p=0.191:0.001:0.2;   %%can_shu
N=length(p);
u=-1:0.004:1;  %%chu_shi_zhi
N1=length(u);

LP=[];
tic;
for j=1:N
    a=p(j)
    for i=1:1:N1
        x0=u(i);
        [T,Res]=lyapunov(3,@hm4_ext,@ode45,0,0.1,4000,[x0 0.5 0.5],20);
        M=length(Res);
        for  k=round(M/3):M
            S=Res(k,1)+Res(k,3);
            if abs(Res(k,2))<0.0015 && abs(S)<0.01
                Res(k,:)
               Lyapunov1(i) = Res(k,1);
               Lyapunov2(i) = Res(k,2);
               Lyapunov3(i) = Res(k,3);
               A1(i,j)=Lyapunov1(i);
               B1(i,j)=Lyapunov2(i);
               C1(i,j)=Lyapunov3(i);
               break
            end
        end
    end
end
toc;
% plot(p,LP,'o-')
% axis([0.1 2.1 -0.4 0.4])

% set(gca,'FontName','Times New Roman','FontSize',16,'LineWidth',0.8);
% xlabel('$w$','Interpreter','latex','FontSize',20);
% ylabel('$Lyapunov exponents$','Interpreter','latex','FontSize',20);
