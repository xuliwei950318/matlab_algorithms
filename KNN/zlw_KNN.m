%*************** k-����Ԥ������ ******************

%ȡ������С��ǰ3�������м�Ȩ���
%***********************************

clc;clear;close all;
[num,txt,raw]=xlsread('C:\Users\Administrator\Desktop\���Ʊ�ҵ�������.xlsx','sheet1');
num(:,1)=[];
[n,m]=size(num);
x=num(:,1:m-1);
y=num(:,m);

n1=n*0.8;
x1=x(1:n1,:);%��������
x2=x(n1+1:end,:);%��������

for i=1:n-n1
    for j=1:n1
        a(i,j)=sqrt(sum((x2(i,:)-x1(j,:)).^2));%��������������������ݼ�ľ���    
    end
    [b,c]=sort(a(i,:));%�Ծ�������
    y_pr(i)=0.5*y(c(1))+0.3*y(c(2))+0.2*y(c(3));%���������3������м�ȨԤ��
end
%[b,c]=sort(a,2);%�Ծ����������cΪ���������
figure;
plot(y(n1+1:end),'b.-');title('k-����Ԥ��');
hold on;
plot(y_pr,'ro-');
hold off;
legend('��ʵֵ','Ԥ��ֵ');
axis([1 6 0 10]);
disp('��������');
ess=sqrt(sum((y(n1+1:end)'-y_pr).^2)/(n-n1))
