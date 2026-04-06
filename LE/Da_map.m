clear
clc
close all

load ('LE1.mat')
load ('LE2.mat')
load ('LE3.mat')

%% 鐢讳笁涓笉鍚岀殑鏉庨泤鏅澶寚鏁?
figure(1)
imagesc(A11)
colorbar

figure(2)
imagesc(B11)
colorbar

figure(3)
imagesc(C11)
colorbar

%% 鐢讳笉鍚岀殑鑰楁暎搴?
% N=length(C11(1,:)) %x鍧愭爣鐨勯暱搴?51
% M=length(C11(:,1)) %y鍧愭爣鐨勯暱搴?51
% 
% for i=1:N
%     i
%     for j=1:M
%         j
%         J=502-j;
%         A=A11(j,i);
%         B=B11(j,i);
%         C=C11(j,i);
%         S=A+B+C 
%         if S<=-0.01 %&& B<=-0.05                 
%             plot(i,j,'.b','MarkerSize',19) %周期
%         elseif abs(S)<0.01 && A>=0.01 %&& abs(B)<0.01 && C<=-0.05
%             hold on
%             plot(i,j,'.m','MarkerSize',19) %保守混沌
%         elseif abs(S)<0.01 && abs(A)<0.01 %&& abs(B)<0.01 && C>-0.05
%             hold on
%             plot(i,j,'.y','MarkerSize',19) %不变环面
%         else 
%             hold on
%             plot(i,j,'.r','MarkerSize',19) %鍏朵粬琛屼负
%         end        
%         
%    end
% end
axis([0 502 0 502])