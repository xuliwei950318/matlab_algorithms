%******* P-PCR ����ʽ��Ԫ�ع� ���� ****************
%˵��������Ԫ���ö�������ʽ��t1,t2,t1^2,t2^2,t1*t2����չ�����������ע�����������ֶԸö����;���άѡ������ķ�����1��PCA���ν�ά��2���𲽻ع�ѡ�������
%���ߣ�zlw
%ʱ�䣺2015-10-13

%*************** ����Ԥ���� ****************
clc;clear;close all;
[num1,TXT1,raw1]=xlsread('C:\Users\Administrator\Desktop\���Ʊ�ҵ�������.xlsx','sheet1');
[num2,TXT2,raw2]=xlsread('C:\Users\Administrator\Desktop\Ѫ�Ǽ������_20150930.xlsx','sheet1');
num1(:,1)=[];
num2(:,1)=[];
zz=find(isnan(num2(:,1)));%ȥ��nan��Ч������
num2(zz,:)=[];

num=[num1;num2];
% num(:,[1,end-1])=[];
% 
%********  ���ݷ��� ����Ũ�����ݷ�һ�飬��Ũ������Ϊһ�飩****************
h_n=find(num(:,end)>9);
l_n=find(num(:,end)<=9);
h_num=num(h_n,:);
l_num=num(l_n,:);

num=h_num;

%************ ���ɷַ���  ******************************
con=0.9;%�ۼƹ�����
[n,m]=size(num);
y=num(:,m);
x=num(:,1:m-1);

X=zscore(x); %���ݱ�׼��
%���ݹ�һ��  ���ٱ�׼��
% [n,~]=size(x);
% x_2=sqrt(diag(x*x'));
% for i=1:n
%     X(i,:)=x(i,:)/x_2(i);
% end
% X=zscore(X);

Y=zscore(y);
[u,s,v] = svds(X);

X_cov=cov(X); %����Э����
[L, K]=eig(X_cov); %��������ֵK����������T
K=eig(K);
Ksum=sum(K);
mm=size(K,1);
Ssum=0;
for i=1:mm
    Ssum=Ssum+K(mm-i+1);
    if Ssum/Ksum>=con
        a=i;
        disp(a);
        break;
    end
end
for i=1:mm
    M(i)=K(mm-i+1);
    N(1:mm,i)=L(1:mm,mm-i+1);
end
%KL=diag(M);
P=N(:,1:a);
T=X*P;

%********* ����Ԫ���ж���ʽ��չ **********
TT(:,1:a)=T;
TT(:,a+1:2*a)=T.^2;
k=2*a+1;
for i=1:a-1
    for j=i+1:a
        TT(:,k)=diag(T(:,i)*T(:,j)');
        k=k+1;
    end
end
%****************************************
% 
%************** ����չ�����ٴν�����Ԫ��ȡ **********************
% TT_cov=cov(TT); %����Э����
% [LT, KT]=eig(TT_cov); %��������ֵK����������T
% KT=eig(KT);
% Ksum=sum(KT);
% mT=size(KT,1);
% Ssum=0;
% for i=1:mT
%     Ssum=Ssum+KT(mT-i+1);
%     if Ssum/Ksum>=con
%         r=i;
%         disp(r);
%         break;
%     end
% end
% for i=1:mT
%     MT(i)=KT(mT-i+1);
%     NT(1:mT,i)=LT(1:mT,mT-i+1);
% end
% %KL=diag(M);
% PT=NT(:,1:r);
% TR=TT*PT;
% bT=Y'*TR/(TR'*TR);%�Զ���ʽ��Ԫ������Ԫ�Ļع�ϵ��
% YT=TR*bT';
% yT=YT*std(y)+mean(y);%����׼��
% figure;
% plot(y);title('����ʽ������Ԫ�ع�');
% hold on;
% plot(yT);legend('real value','prediction of PP-PCR');
% hold off;
% 
% %*************** ������� ****************
% e=y-yT;
% disp('��������')
% disp(sqrt(e'*e/n));
% disp('���ƽ��ֵ��')
% disp(sum(abs(e))/n);
% disp('������ֵ');
% disp(max(abs(e)));
% disp('������');
% disp(abs(e./y*100));
% disp('���������ֵ');
% disp(max(abs(e./y*100)));
% disp('������ƽ��ֵ');
% disp(mean(abs(e./y*100)));
% 
% figure;
% hist(abs(e./y*100));title('������ֱ��ͼ'); 
% disp('******************************************************************');


%*************** �𲽻ع�ѡȡ����ʽ��չ������Ԫ ***********************
PZ=[TT,Y];
IN=zbhg(PZ);
TTN=TT(:,IN);
bTN=Y'*TTN/(TTN'*TTN);%�Զ���ʽ��Ԫ������Ԫ�Ļع�ϵ��
YTN=TTN*bTN';
yTN=YTN*std(y)+mean(y);%����׼��
figure;
plot(y);title('�𲽶���ʽ��Ԫ�ع�');
hold on;
plot(yTN);legend('real value','prediction of SWP-PCR');
hold off;


%*************** ������� ****************
e=y-yTN;
disp('��������')
disp(sqrt(e'*e/n));
disp('���ƽ��ֵ��')
disp(sum(abs(e))/n);
disp('������ֵ');
disp(max(abs(e)));
disp('������');
disp(abs(e./y*100));
disp('���������ֵ');
disp(max(abs(e./y*100)));
disp('������ƽ��ֵ');
disp(mean(abs(e./y*100)));

figure;
plot(abs(e./y*100));
figure;
hist(abs(e./y*100));title('SWP-PCR-������ֱ��ͼ'); axis([0 40 0 25]);
disp('************************ ����p-pcr******************************************');



b=Y'*TT/(TT'*TT);%�Զ���ʽ��Ԫ�Ļع�ϵ��

YY=TT*b';%��׼�����ֵ
yy=YY*std(y)+mean(y);%����׼��
%******************** ��ͼ ************************
figure;
plot(y);title('����ʽ��Ԫ�ع�');
hold on;
plot(yy);legend('real value','prediction of P-PCR');
hold off;

%*************** ������� ****************
e=y-yy;
disp('��������')
disp(sqrt(e'*e/n));
disp('���ƽ��ֵ��')
disp(sum(abs(e))/n);
disp('������ֵ');
disp(max(abs(e)));
disp('������');
disp(abs(e./y*100));
disp('���������ֵ');
disp(max(abs(e./y*100)));
disp('������ƽ��ֵ');
disp(mean(abs(e./y*100)));

figure;
hist(abs(e./y*100));title('P-PCR-������ֱ��ͼ'); 
axis([0 40 0 25]);









