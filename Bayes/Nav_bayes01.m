%���ر�Ҷ˹ --- �����㷨
%����x����֮���໥����

%���룺 x[n*m]=[����1������2��...����m]����������1��2...m��ֵ�ֱַ�Ϊij��(����ɢ��ֵ)
%       y[n*1]=[��1����2��...��k]
%�磺x=[1,'��'      y=[���ǡ�
%       0,'��'         ����
%       1,'��'         ���ǡ�
%       0,'��']        ����]

%�����p(xi)
clc;clear;close all;

x=[1,1,0,1,0,0,1,1,0,0
   0,1,1,0,0,1,1,1,0,1
   0,1,1,2,0,1,1,0,2,2];
y=[1,0,0,1,0,0,0,1,0,1];



x=x';
y=y';


[n,m]=size(x);%ȷ��x����ά��m��
for i=1:m 
    C(i)=length(unique(x(:,i)));%ȷ��xÿ������������Ci��
end
uny=unique(y);
C(m+1)=length(uny);%ȷ��y��������

%-----------------------------����������ʣ���������------------------
for i=1:C(m+1)  %y�������
    num=find(y==uny(i));
    sumy(i)=sum(y==uny(i));
    py(i)=sumy(i)/n;%�������P��Y=yi��
    
    xi=x(num,:);%y==yi�µ�x����
    for j=1:m   %x������������
        unx{j}=unique(x(:,j));
        for k=1:C(j)  %xÿ�������µ������
            pxy(k,j,i)=sum(xi(:,j)==unx{j}(k))/sumy(i);%�������ʾ���ÿһ��Ϊyi������xi�����ĸ�������������
        end
    end
end

%--------------------------------��������---------------------------
% unx uny pxy py  C

xx=[0;0;0];

sum=0;
for i=1:C(m+1)
    mul=1;
    for j=1:m
        j_n=unx{j}==xx(j);
        mul=mul*pxy(j_n,j,i);
    end
    pxx(i)=mul;    
    sum=sum+py(i)*pxx(i);            
end
p_b=sum;%��ĸ��ȫ����

for i=1:C(m+1)
    mul=1;
    for j=1:m
        j_n=find(unx{j}==xx(j));
        mul=mul*pxy(j_n,j,i);
    end
    pxx(i)=mul;
    p_a=py(i)*pxx(i);%���ӣ����ϸ���
    

    pyx(i)=p_a/p_b;
end

y_pre=max(pyx);%Ԥ���������
y_num=uny(unique(find(pyx==y_pre)));%Ԥ�������ʵ��������

disp('Ԥ��Ϊ�����   ����')
disp([y_num,y_pre])

