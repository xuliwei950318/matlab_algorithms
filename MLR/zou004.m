%***********************�˳���Ϊ��Ԫ�𲽻ع����******
clc;clear;close all;
[num,TXT,raw]=xlsread('F:\��ɽ����Ŀ\������ȡ\obsoft\fccu-pls.xlsx','���ͳ����');
%num(1:2,:)=[];
num=num(:,1:11);
% x=num(:,1);
% y=x';%����y����
% figure;
% subplot(211);
% plot(y,'b.-');ylabel('y');title('������������');
% axis([0,500,280,320]);
% hold on;
% %%%��ȥƽ��ֵ����ڱ�׼���3�������޳�
% x_mean=mean(x);
% x_std=std(x);
% xx=abs((x-x_mean)/x_std);
% k= find(xx>=3);
% plot(k,y(k),'ro')
% x(xx>=3)=[];
% disp('���޳��ĵ�Ϊ��');
% disp(find(xx>=3));
% yy=x';%ȥ�쳣���y����
% subplot(212);
% plot(yy,'r.-');ylabel('y');title('�޳��쳣�������');
% axis([0,500,280,320]);
% num(xx>=3,:)=[];%ȥ���쳣���xy����

In=zbhg(num);%�𲽻ع�

x=num(1:end,In+1);
y=num(1:end,1);

X=x;%ѵ������
Y=y;
XX=num(:,In+1);%��������
YY=num(:,1);
[m,mm]=size(XX);
[n,p]=size(X);
X=[ones(n,1),X];
XX=[ones(m,1),XX];
[n,m]=size(X);
alpha=0.95;
% [b,bint,r,rint,stats]=regress(y,X);   %bΪ������bint�ع�ϵ����������ƣ�rΪ�вrintΪ�������䣬stats���ڻع�ģ�ͼ���.

b=(X'*X)\X'*Y %�ع�ϵ��
yy=XX*b;%Ԥ��ֵ
figure;
plot(YY,'b.-');title('��Ԫ���Իع�');
hold on
plot(yy,'r.-');
hold off;
legend('real value','prediction of MLR');

% ********  ���Ͳ�������  *****************
Y_mean=mean(YY);
SSE=(YY-yy)'*(YY-yy); % �в�ƽ����
SSR=(yy-Y_mean)'*(yy-Y_mean); % �ع鷽�̱���ƽ����
SST=(YY-Y_mean)'*(YY-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R2=sqrt(SSR/SST); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��
v=[];
for j=1:mm
    SSEE(j)=(YY-(yy-b(j+1)*XX(:,j)))'*(YY-(yy-b(j+1)*XX(:,j)));
    v(j)=sqrt(1-SSE/SSEE(j));  %���ƫ���ϵ��
end
disp(['ƫ���ϵ��Ϊ��' num2str(v)])

disp(['��Ԫ���Իع���������:' num2str(sqrt(SSE/(n)))])

disp(['��Ԫ���Իع����������ֵ��' num2str(max(abs(YY-yy)))])


%*************** F���� ******************
F=(SSR/p)/(SSE/(n-p-1)); % ����F�ֲ���F��ֵԽ��Խ��
if F > finv(alpha,p,n-p-1); % H=1�����Իع鷽������(��)��H=0���ع鲻����
    disp('b������Ϊ0���ع鷽��ͨ��F����');
else
    disp('b����Ϊ0���ع鷽��û��ͨ��F����');
end


%************* t���� ****************
X=X(:,2:end);b=b(2:end);%ȥ��b0��
S=sqrt(diag(inv(X'*X))*SSE/(n-p-1)); % ���Ӧ�2(n-p-1)�ֲ�
t=b./S; % ����T�ֲ�������ֵԽ�����Թ�ϵ����
tInv=tinv(0.5+alpha/2,n-p-1);
tH=abs(t)>tInv; % H(i)=1����ʾXi��Y�������������ã�H(i)=0��Xi��Y���������ò�����
disp('��������t��������1��ʾͨ����0��ʾûͨ��');
disp(tH');
% �ع�ϵ���������
tW=[-S,S]*tInv; % ����H0��Ҳ����˵�����beta_hat(i)��Ӧ�����У���ôXi��Y�������ò�����