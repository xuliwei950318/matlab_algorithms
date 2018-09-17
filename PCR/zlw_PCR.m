%****************��Ԫ�ع�*******************

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
% num=num2;

%********  ���ݷ��� ����Ũ�����ݷ�һ�飬��Ũ������Ϊһ�飩****************
h_n=find(num(:,end)>9);
l_n=find(num(:,end)<=9);
h_num=num(h_n,:);
l_num=num(l_n,:);

num=h_num;

% ******** ��ʾ��ʼ���� *******************
% figure;
% subplot(211);plot(num(:,end));title('����Ũ�ȣ���������');
% subplot(212);plot(num(:,1:end-1));title('��������');
% legend('470nm','660nm','730nm','850nm','940nm');

%*******************************************************************************
[n,m]=size(num);
y=num(:,m);
x=num(:,1:m-1);

X=x;
% X=[ones(m,1),X];
Y=y;%ѵ������

con=0.9;

%��׼��������Э�������
[nn,mm]=size(X);
for j=1:mm
    x(j)=mean(X(:,j));
    s(j)=sqrt(cov(X(:,j)));
end
for i=1:nn
    for j=1:mm
        Y1(i,j)=(X(i,j)-x(j))/s(j);
    end
end

%X_te=load('C:\Documents and Settings\Administrator\����\d05_te.dat');
%�������ݱ�׼��
% [n1,m1]=size(X_te);
% for j=1:m1
%     x1(j)=mean(X_te(:,j));
%     s1(j)=sqrt(cov(X_te(:,j)));
% end
% for i=1:n1
%     for j=1:m1
%         Y(i,j)=(X_te(i,j)-x(j))/s(j);
%     end
% end
YY=Y1;
RY=cov(YY);%Э����
%����ֵ�ֽ�
[T,K]=eig(RY);
%�����ۼƹ�������ȡ��Ԫ
S=eig(full(K));%��ȡ����ֵ������С-����������������⣬��������û��˳�����������⣬���־���cov����Ľ���eig����Ľ��ǡǡ��˳���������ˣ�
Ksum=sum(sum(K,2),1);
Ssum=0;
for i=1:size(S,1)
    Ssum=Ssum+S(mm-i+1);
    if Ssum/Ksum>=con
        a=i;
        disp(a);
        break;
    end
end
for i=1:mm
    M(i)=S(mm-i+1);
    N(1:mm,i)=T(1:mm,mm-i+1);
end
KL=diag(M);
eig(full(KL));
P=N(:,1:a);%..............,,,ǰa��������������
Ka=KL(1:a,1:a);%������������������ǰa���������ԽǾ���

T=X*P;%��Ԫ
b=inv(T'*T)*T'*Y;%����Ԫ�Ļع�ϵ��
Q=P*b;%��ԭʼ�����Ĳ���
disp(Q');
y=X*Q;%���ֵ
e=Y-y;%������
figure;
plot(e,'b.-');
legend('PCR�������');


Y_mean=mean(Y);
SSE=e'*e ;% �в�ƽ����
SSR=(y-Y_mean)'*(y-Y_mean); % �ع鷽�̱���ƽ����
SST=(Y-Y_mean)'*(Y-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R2=sqrt(1-SSE/SST); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��

R2

ess=sqrt((e'*e)/n);%������ľ�����
emax=max(abs(e));%������ֵ
%**************************************************************************
%*******����������Ԫ�ع����*******************
TT=Y1*P;%��Ԫ
Y2=zscore(Y);
bb=inv(TT'*TT)*TT'*Y2;%����Ԫ�Ļع�ϵ��
QQ=P*bb;%�Ա�׼�������Ĳ���
B=[mean(Y)-std(Y)*(mean(X)./std(X))*QQ,std(Y)*QQ'./std(X)];
XX=[ones(size(X,1),1),X];
yyy=XX*B';%%%%%����Ǵ�������ϵ���ġ����
ee=Y-yyy;
eess=sqrt(ee'*ee/n);
SSR1=(yyy-Y_mean)'*(yyy-Y_mean); % �ع鷽�̱���ƽ����
SST1=(Y-Y_mean)'*(Y-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R12=sqrt(SSR1/SST1); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��
R12

figure;
plot(num(:,end),'b.-');
hold on;
plot(yyy,'r.-');
xlabel('sample number');ylabel('�����');title('PCA�ع����(��Ũ��)');
hold off;
% legend('real value','prediction of PCR','prediction of PCR(b0)');
legend('real value','prediction of PCR');
disp('�ع�ϵ����')
disp(B);
disp('��Ԫ�ع���������:')
disp(eess);
disp('��Ԫ�ع����ƽ��ֵ��')
disp(sum(abs(ee))/n);
disp('��Ԫ�ع����������ֵ��')
disp(max(abs(ee)));
disp('��Ԫ�ع�������ƽ��ֵ��')
disp(sum(abs(ee)./Y*100)/n);
disp('��Ԫ�ع����������ֵ��')
disp(max(abs(ee)./Y*100));
hf=abs(ee)./Y*100;
figure;
plot(hf,'.-');title('PCR����������%');
figure;
hist(hf);xlabel('�������С');ylabel('ռ%');title('PCR-������ֱ��ͼ');%������ֱ��ͼ
axis([0 45 0 25]);
%*******************************��Ϊ2άͼ����**********************

P=N(:,1:2);%..............,,,ǰa��������������
T=Y1*P;%��Ԫ

figure;
plot(T(:,1),T(:,2),'b.');title('ѡȡ������Ԫ-��άͼ');
hold on;
plot(T(1:3,1),T(1:3,2),'ro');
hold on;
plot(T([6,11:20],1),T([6,11:20],2),'gv');
hold off;
legend('normal','high','low');

