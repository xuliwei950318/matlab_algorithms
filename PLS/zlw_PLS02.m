%*********************** pls �ع���� (����)*************************

%*************����pls0����************
%************ע�⣺��ֻ��1�������ʱ��pls��pcr���ǲ���ͬ��

clc;clear;close all;
[num1,TXT1,raw1]=xlsread('C:\Users\Administrator\Desktop\���Ʊ�ҵ�������.xlsx','sheet1');
[num2,TXT2,raw2]=xlsread('C:\Users\Administrator\Desktop\Ѫ�Ǽ������_20150930.xlsx','sheet1');
num1(:,1)=[];
num2(:,1)=[];
zz=find(isnan(num2(:,1)));%ȥ��nan��Ч������
num2(zz,:)=[];

% for i=1:5:size(num2,1)
%     num2v((i-1)/5+1,:)=mean(num2(i:i+4,:));%ȡƽ��ֵ�����þ�ֵ��ģ��
% end
% num2=num2v;

num=[num1;num2];
% num=num2;
[n,m]=size(num);
n1=round(n/3*2);%ѵ��������
n2=round(n/3);%����������

x=num(1:n1,1:end-1);%ѵ��
y=num(1:n1,end);
X=num(n1+1:end,1:end-1);%����
Y=num(n1+1:end,end);
[xnn,xmm]=size(X);
[xn,xm]=size(x);
pz=[x,y];
sol=pls0(pz,xm,1);
disp('');
disp('PLS�ع�ϵ����');
disp(vpa(sol',4));
figure;
plot(num(1:end,end),'b.-');
hold on;
[row,col]=size(pz);
X0=[ones(xn,1),x];
X=[ones(xnn,1),X];
y0=X0*sol;
yy=X*sol;
t0=1:xn;t1=n1+1:n;
plot(t0,y0,'r.-');xlabel('sample number');ylabel('�����');title('PLS�ع����(num)');
hold on;
plot(t1,yy,'g.-');
hold off;
legend('real value','fitting of PLS','prediction of PLS');

e=Y-yy;
% figure;
% plot(e,'b.-');
% legend('PLS�������');
% axis([0 500 -20 20]);
Y_mean=mean(Y);
SSE=(Y-yy)'*(Y-yy) ;% �в�ƽ����
SSR=(yy-Y_mean)'*(yy-Y_mean); % �ع鷽�̱���ƽ����
SST=(Y-Y_mean)'*(Y-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R2=sqrt(SSR/SST); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��
disp('�����ϵ����')
disp(R2)
disp('PLS�ع���������:')
disp(sqrt(SSE/(n2)));
disp('PLS�ع����ƽ��ֵ��')
disp(sum(abs(e))/n2);
disp('PLS�ع����������ֵ��')
disp(max(abs(Y-yy)));
disp('PLS�ع�������ƽ��ֵ��')
disp(sum(abs(e)./Y*100)/n2);

Xt=x(:,1:end);bt=sol(2:end);%ȥ��b0��
St=sqrt(diag(inv(Xt'*Xt))*SSE/(row-xm-1)); % ���Ӧ�2(n-p-1)�ֲ�
tt=bt./St; % ����T�ֲ�������ֵԽ�����Թ�ϵ����
disp('t����ֵ��');
disp(tt');