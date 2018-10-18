clc;clear all;close all;
[num1,TXT1,raw1]=xlsread('C:\Users\Administrator\Desktop\���Ʊ�ҵ�������.xlsx','sheet1');
[num2,TXT2,raw2]=xlsread('C:\Users\Administrator\Desktop\Ѫ�Ǽ������_20150930.xlsx','sheet1');
num1(:,1)=[];
num2(:,1)=[];
zz=find(isnan(num2(:,1)));%ȥ��nan��Ч������
num2(zz,:)=[];

num=[num1;num2];

%********  ���ݷ��� ����Ũ�����ݷ�һ�飬��Ũ������Ϊһ�飩****************
h_n=find(num(:,end)>9);
l_n=find(num(:,end)<=9);
h_num=num(h_n,:);
l_num=num(l_n,:);


num=h_num;%num=l_num;
%********************* ��ʼ�� ������ ****************************
[n,m]=size(num);

x=num(:,1:end-1);
y=num(:,end);

%********************** ��ʼ�� �� ���� ******************************
n_train=[1:2:n];%ѵ��������
n_test=[2:2:n];%Ԥ��������
x_train=x(n_train,:);y_train=y(n_train,:);%ѵ������
x_test=x(n_test,:);%Ԥ���������ݣ�

r=3;
con=0.9;%��Ԫ�ۼƹ�����
r_pls=3;%plsѡȡ�ɷָ���
%************** osc���ݴ��� ***********************

[p,w,X_train ] = osc1_mod( x_train,y_train,r);
% [p,w,X_train ] = osc2_mod( x_train,y_train,r);

X_test  = osc_pr( x_test,p,w );

%*************** ��Ԫ���Իع� ****************
b=(X_train'*X_train)\X_train'*y_train;%�ع�ϵ��
y_mlr=x_test*b;

%***************��pcr��ģ��Ԥ�⡡****************
[P,X_mean,X_std,Y_mean,Y_std,b]= pcr_mod( X_train,y_train,con );%����pcrģ��

y_pcr = pcr_pr( X_test,P,X_mean,X_std,Y_mean,Y_std,b);%Ԥ��������

%*************** pls��ģ��Ԥ�� *************
[p,X_mean,X_std,Y_mean,Y_std,b]= pls_mod( X_train,y_train,r_pls );%����plsģ��

y_pls = pls_pr( X_test,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%Ԥ��������

%******************** p_pcr��ģ��Ԥ�� ********************************
[P,X_mean,X_std,Y_mean,Y_std,b,r]= p_pcr_mod( X_train,y_train,con );%����p_pcrģ��

y_p_pcr = p_pcr_pr( X_test,P,X_mean,X_std,Y_mean,Y_std,b,r);%Ԥ��������

%******************** p_pls��ģ��Ԥ�� ********************************
[p,X_mean,X_std,Y_mean,Y_std,b]= p_pls_mod( X_train,y_train,r_pls );%����p_plsģ��

y_p_pls = p_pls_pr( X_test,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%Ԥ��������

%******************** ��� ************************
k=length(n_test);
err_mlr=sum(abs(y(n_test)-y_mlr)./y(n_test)*100)/k
err_pcr=sum(abs(y(n_test)-y_pcr)./y(n_test)*100)/k
err_pls=sum(abs(y(n_test)-y_pls)./y(n_test)*100)/k
err_p_pcr=sum(abs(y(n_test)-y_p_pcr)./y(n_test)*100)/k
err_p_pls=sum(abs(y(n_test)-y_p_pls)./y(n_test)*100)/k
    

%******************** ��ͼ ************************
figure;
plot(y_mlr);
hold on;
plot(y_pcr);
hold on;
plot(y_pls);
hold on;
plot(y_p_pcr);
hold on;
plot(y_p_pls);
hold on
plot(y(n_test),'b.-');
title('Ԥ������');
legend('mlrԤ��','pcrԤ��','plsԤ��','p-pcrԤ��','p-plsԤ��','y��ֵ');
