function [ y ] = LR_pre( x,w,x_mean,x_std )
%�߼��ع�
%�ο���http://blog.csdn.net/hechenghai/article/details/46817031
 
[n,~]=size(x);
%��׼��
for j=1:n
    x(j,:)=(x(j,:)-x_mean)./x_std;
end
x = [ones(n, 1), x]; %x����һά����Ϊǰ�����ֻ�ǰ����˵��

g = inline('1.0 ./ (1.0 + exp(-z))','z'); %������൱��������һ��function g��z��=1.0 ./ (1.0 + exp(-z))

y = g(x*w);  %Ԥ��
end


