%%%%%%%%%%%%%%%%%%%%%%%%%%��Ԫ�ع�+�������������ʵ��   �����з������ܣ�%%%%%%%%%%%%%%%%%%%%
                   %���й��ߺ���b=lsqlin(x,y)����û����㣩
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%*******************���ȶ�ȡ����*****************
clc;clear;close all;
[num1,TXT1,raw1]=xlsread('data\���Ʊ�ҵ�������.xlsx','sheet1');
[num2,TXT2,raw2]=xlsread('data\Ѫ�Ǽ������_20150930.xlsx','sheet1');
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
y=num(:,m);
x=num(:,1:m-1);
bb=lsqlin(x,y);
disp(bb');


a=corrcoef(x);%�������ϵ��
%*******************************************
%***************��Ԫ�ع����*****************

n1=round(n/3*2);%ѵ��������
n2=round(n/3);%����������
x1=x(1:n1,:);
x2=x(n1+1:n,:);

X=[ones(n1,1),x1];%ѵ������
Y=y(1:n1);%
XX=[ones(n2,1),x2];%��������
YY=y(n1+1:n);

b=(X'*X)\X'*Y;%�ع�ϵ��
disp('�ع�ϵ����');
disp(b');
y1=X*b;%���ֵ
yy=XX*b;%Ԥ��ֵ
figure;
plot(y,'b.-');title('��Ԫ���Իع�(num)');
hold on
plot(y1,'r.-');
hold on;
plot(n1+1:n,yy,'g.-');
hold off;
legend('real value','fitting of MLR','prediction of MLR');
%************************************************************************
%***************  ���Ͳ�������   *********************
e=YY-yy;
Y_mean=mean(YY);
SSE=(YY-yy)'*(YY-yy); % �в�ƽ����
SSR=(yy-Y_mean)'*(yy-Y_mean); % �ع鷽�̱���ƽ����
SST=(YY-Y_mean)'*(YY-Y_mean); % ԭ����Y�ܱ���ƽ���ͣ�������SST=SSR+SSE
R2=sqrt(SSR/SST); % �����ϵ�������ⶨϵ�����������ع����ռ�����İٷֱȣ���ϳ̶ȣ�Խ��Խ��
v=[];
disp('�����ϵ����')
disp(R2)
for j=1:m-1
    SSEE(j)=(YY-(yy-b(j+1)*XX(:,j)))'*(YY-(yy-b(j+1)*XX(:,j)));
    v(j)=sqrt(1-SSE/SSEE(j));  %���ƫ���ϵ��
end
disp('ƫ���ϵ��Ϊ��')
disp(v);

disp('��Ԫ���Իع���������:')
disp(sqrt(SSE/(n2)));
disp('��Ԫ���Իع����ƽ��ֵ��')
disp(sum(abs(e))/n2);
disp('��Ԫ���Իع����������ֵ��')
disp(max(abs(YY-yy)));
disp('��Ԫ���Իع�������ƽ��ֵ��')
disp(sum(abs(e)./YY*100)/n2);
%*************************************************************************
%*************** F���� ******************
p=m-1;
alpha=0.95;
F=(SSR/p)/(SSE/(n-p-1)) ;% ����F�ֲ���F��ֵԽ��Խ��
disp('F����ֵ:');
disp(F)
if F > finv(alpha,p,n-p-1); % H=1�����Իع鷽������(��)��H=0���ع鲻����
    disp('b������Ϊ0���ع鷽��ͨ��F����');
else
    disp('b����Ϊ0���ع鷽��û��ͨ��F����');
end


%************* t���� ****************
X=X(:,2:end);b=b(2:end);%ȥ��b0��
S=sqrt(diag(inv(X'*X))*SSE/(n-p-1)); % ���Ӧ�2(n-p-1)�ֲ�
t=b./S; % ����T�ֲ�������ֵԽ�����Թ�ϵ����
disp('t����ֵ��');
disp(t');
tInv=tinv(0.5+alpha/2,n-p-1);
tH=abs(t)>tInv; % H(i)=1����ʾXi��Y�������������ã�H(i)=0��Xi��Y���������ò�����
disp('��������t��������1��ʾͨ����0��ʾûͨ��');
disp(tH');
% �ع�ϵ���������
tW=[-S,S]*tInv; % ����H0��Ҳ����˵�����beta_hat(i)��Ӧ�����У���ôXi��Y�������ò�����
if prod(abs(tH))==0 %�۳�
   pp=find(abs(t)==min(abs(t)));
   %%num(:,pp+1)=[];
   disp('��Ҫ���޳��ı���λ���ǣ�');
   disp(pp);
%elseif prod(abs(tH))==1
end



