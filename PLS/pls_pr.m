function y = pls_pr( x,p,X_mean,X_std,Y_mean,Y_std,b,r)
%˵��������p_pls�㷨ģ�ͽ���Ԥ��
% x����������(��������)
% p: pls����Ľ�ά����
% X_mean,X_std:ѵ�����ݾ�ֵ�ͱ�׼��
% Y_mean,Y_std��~
% b����׼���Ļع�ϵ��
% r:����ʽ��չ��Ԫ����
% y:Ԥ������


[n,~]=size(x);
%��׼��
for j=1:n
    x(j,:)=(x(j,:)-X_mean)./X_std;
end

%�������ݳɷ�ti
t=x*p;
T=t(:,1:r);

%****************************************

Y=T*b';%��׼��Ԥ��ֵ
y=Y*Y_std+Y_mean;%����׼��


