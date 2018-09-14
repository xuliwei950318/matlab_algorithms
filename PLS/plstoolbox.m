function [theta1,zero1]=plstoolbox(X,Y,maxLv)
if nargin<3
    maxLv=rank(X)
elseif maxLv>rank(X)
  error('������ɷ�������X����')
end
Xold=X;
Yold=Y;
%��׼��
[ro,co]=size(X);
meanval=mean(X);
stdval=nanstd(X);
meanvaly=mean(Y);
stdvaly=nanstd(Y);
X=(X-ones(ro,1)*mean(X))./(ones(ro,1)*nanstd(X));
Y=(Y-ones(ro,1)*mean(Y))./(ones(ro,1)*nanstd(Y));

out=0;
[m,ssq,P,Q,W,T,U,B] = pls(X,Y,maxLv,out);  %����PLS�����亯��
co=maxLv;
I=eye(co,co);
for i=1:co
    I(i,i)=I(i,i)*B(i);
end
B=I;

theta=W*inv(P'*W)*B*Q';
theta1=stdvaly*theta./stdval';
zero1=meanvaly-stdvaly*meanval*(theta./stdval');