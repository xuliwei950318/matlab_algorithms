%*********************** pls �ع���� *************************

%*************����pls����************
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
% num(:,[1,end-1])=[];

%********  ���ݷ��� ����Ũ�����ݷ�һ�飬��Ũ������Ϊһ�飩****************
h_n=find(num(:,end)>9);
l_n=find(num(:,end)<=9);
h_num=num(h_n,:);
l_num=num(l_n,:);

num=l_num;

%*******************************************************************
[n,m]=size(num);

x=num(:,1:end-1);%ѵ��
y=num(:,end);
[xn,xm]=size(x);
pz=[x,y];
%*************************************************************
% LV=3;%��ȡ�ɷָ���
% [B b]=plskernel_1(x,y,LV);%pls��һ�ֽⷨ��Bϵ����b������
% b
% B
%*************************************************************
sol=pls(x,y,2);
disp('');
disp('PLS�ع�ϵ����');
disp(vpa(sol',4));
figure;
plot(num(1:end,end),'b.-');
hold on;
[row,col]=size(pz);
X0=[ones(xn,1),x];
y0=X0*sol;
t0=1:xn;
plot(t0,y0,'r.-');xlabel('sample number');ylabel('�����');title('PLS�ع����(��Ũ��)');
hold off;
legend('real value','prediction of PLS');

e=y-y0;
% figure;
% plot(e,'b.-');
% legend('PLS�������');
% axis([0 500 -20 20]);
Y_mean=mean(y);
SSE=(y-y0)'*(y-y0) ;% �в�ƽ����
SSR=(y0-Y_mean)'*(y0-Y_mean); % �ع鷽�̱���ƽ����
SST=(y-Y_mean)'*(y-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R2=sqrt(SSR/SST); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��
disp('�����ϵ����')
disp(R2)
disp('PLS�ع���������:')
disp(sqrt(SSE/(n)));
disp('PLS�ع����ƽ��ֵ��')
disp(sum(abs(e))/n);
disp('PLS�ع����������ֵ��')
disp(max(abs(y-y0)));
disp('PLS�ع�������ƽ��ֵ��')
disp(sum(abs(e)./y*100)/n);
disp('PLS�ع����������ֵ��')
disp(max(abs(e)./y*100));
hf=abs(e)./y*100;
figure;
plot(hf,'.-');title('PLS����������%');
figure;
hist(hf);xlabel('�������С');ylabel('ռ%');title('PLS-������ֱ��ͼ');%������ֱ��ͼ
axis([0 45 0 20]);

Xt=x(:,1:end);bt=sol(2:end);%ȥ��b0��
St=sqrt(diag(inv(Xt'*Xt))*SSE/(row-xm-1)); % ���Ӧ�2(n-p-1)�ֲ�
tt=bt./St; % ����T�ֲ�������ֵԽ�����Թ�ϵ����
disp('t����ֵ��');
disp(tt');