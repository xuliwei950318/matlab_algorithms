%%%********* ����ʽƫ��С���� ����ʵ�� *****************
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

num=h_num;

%*******************************************************************
[n,m]=size(num);

x=num(:,1:end-1);%ѵ��
y=num(:,end);
% [xn,xm]=size(x);
% pz=[x,y];
p_pls(x,y,3);