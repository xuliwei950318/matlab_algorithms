%%%%%%%%%%%%%%%%%%%%% �����ź�У��ƫ��С���ˣ�osc-pls�� %%%%%%%%%%%%%%%%%%%%%%%%
%���ߣ�zlw
%ʱ�䣺2015-10-28
%˵����

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

%************ OSC���ݴ���  ******************************
[n,m]=size(num);
y=num(:,m);
x=num(:,1:m-1);

r=3;%osc�ɷָ���
% [n,m]=size(x);
% X=zscore(x);
X=x;
for i=1:r
    X_cov=cov(X);
    [L, K]=eig(X_cov); %��������ֵK����������L
    p1=L(:,end);
    t1=X*p1;%������ɷ�

%  %����������ɷֵ���һ�ַ���   
%     [u,s,v] = svds(X,1);
%      p = v(:,1);
%      p = p*sign(sum(p));
%      told = u(:,1)*s(1);

%***************************************************
%ѭ���������ɷ�t1����y�����Ĳ���
    dif=1;k=0;fn=500;   told=t1;
    while dif > 1e-12
        k=k+1;
        t=X*p1/(p1'*p1);
        tnew=t- y*inv(y'*y)*y'*t;%tnew��t��y��������Ϣ
        pnew=X'*tnew/(tnew'*tnew);%pnew�Ǳ任������tnew=x*pnew;
        dif=norm(tnew-told)/norm(tnew);%�ﵽһ�����Ƚ���
        p1=pnew;
        told=tnew;
        if k>fn
            dif=0;
        end
    end
    
%******************************************************************
    %����PLS���������Ż���������Ϣtnew
    %w=pls(X,tnew,a);%ʵ����w��X��tnew��PLS�ع�ϵ��,Ҳ����PCR��MLR��w
    mm=m-1;
    E0=X;F0=tnew; temp=eye(mm);
    for j=1:mm
        M=E0'*F0*F0'*E0;
        [LL, KK]=eig(M); %��������ֵK����������T
        S=diag(KK);%��ȡ����ֵ
        [~,ind]=sort(S,'descend');%����-С����ind���
        ww(:,j)=LL(:,ind(1)); %����������ֵ��Ӧ����������
        tt(:,j)=E0*ww(:,j);     %����ɷ� ti �ĵ÷�
        alpha(:,j)=E0'*tt(:,j)/(tt(:,j)'*tt(:,j)) ;%����                 alpha_i ,����(t(:,j)'*t(:,j))�ȼ���norm(t(:,j))^2
        E1=E0-tt(:,j)*alpha(:,j)' ;   %����в����
        E0=E1;
        
       %����w*����
       if j==1
           w_star(:,j)=ww(:,j);
       else
          for jj=1:j-1
              temp=temp*(eye(mm)-ww(:,jj)*alpha(:,jj)');
          end
          w_star(:,j)=temp*ww(:,j);
       end   
    end
    T=tt(:,1:r);
    b=tnew'*T/(T'*T);%��׼������Ԫ�Ļع�ϵ��
    w=w_star(:,1:r)*b';%��׼����X�Ļع�ϵ����������T=X*w_star���������Ƶ���w��
   
 %*********************************************************************   
    t=X*w;%pls�ع�Ԥ��ֵ
    t=t-y*inv(y'*y)*y'*t;
    p=X'*t/(t'*t); 
    X=X-t*p';
    
    pr(:,i)=p;
    wr(:,i)=w;
    tr(:,i)=t;
    
end
    