%************** ����ͶӰ�㷨ѡȡ��������,����pls��ģ��SPA PLS�� ***************
%(successive projections algorithm) SPA
%�ο����ף�����������ͶӰ�㷨�������ܵ�����������������ѡȡ��
%ʱ�䣺2015-11-5

clc;clear;close all;
%xȫ��������,y����ֵ

load FREEZEGATEST.mat
Xtrn=f_sd_ll_a;
Ytrn=f_y_ll_a;

%************************** ��ʼ�� �� ��������*********************************
x=Xtrn(:,1:400);%����ѡȡ��ǰ100ά������
y=Ytrn;

[n,m]=size(x);
N=10;%��������Ҫѡȡ�ı�������N<=m
r_pls=5;%pls�ɷָ�����r_pls<=N

%**********************  ����ͶӰ�㷨 *********************************
for i=1:m
    xi=x(:,i);
    t=1:m;t(i)=[];
    KN(1)=i;%��i��������ѡ
    for k=2:N
        px=zeros(n,m);pl=zeros(1,m);
        for j=t
            xj=x(:,j);
            px(:,j)=xi-(xi'*xj)*xj/(xj'*xj);%xi��xj�ϵ�����ͶӰpx����xi��ȥ��xj�ϵ�ͶӰ��
            pl(j)=px(:,j)'*px(:,j);
        end
        [~,ind]=sort(pl,'descend');
        xi=px(:,ind(1));
        ti=find(t()==ind(1));
        t(ti)=[];
        KN(k)=ind(1);
    end
    MN(i,:)=KN;
end
MN  %ÿһ�д���һ���������ţ���ѡ����m�����

%********* ��m������ֱ����pls��ģ��ѡȡ���rmse��С��һ����Ϊ���ո������� **********
for i=1:m
    X=x(:,MN(i,:));
    [p,X_mean,X_std,Y_mean,Y_std,b]= pls_mod( X,y,r_pls );%����plsģ��
    y_pls = pls_pr( X,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%plsԤ�����
    e=y-y_pls;
    rmse(i)=sqrt(e'*e/n);
end
e_min=min(rmse);
a=find(rmse()==e_min);
disp('����ͶӰ-���ű����飺');
disp(MN(a,:));
%*************** ������ֵͨ��F�����һ��ɸѡ���� **************************
AN=MN(a,:);
Qtol=(rmse(a))^2*n;%�в�ƽ���ͣ�
alpha=0.95;
disp('********************* �����ǰ�����ֵF����ɸѡ�������� *********************');
for i=1:N
    Q=[];
    for j=1:N-i+1
        AP=AN;
        AP(j)=[];
        X=x(:,AP);
        [p,X_mean,X_std,Y_mean,Y_std,b]= pls_mod( X,y,r_pls );%����plsģ��
        y_pls = pls_pr( X,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%plsԤ�����
        e=y-y_pls;
        Q(j)=e'*e;
    end
    pm=find(Q()==min(Q));
    c(i)=(min(Q)-Qtol)/Qtol;%
    
    %*************** F���� ******************
    if i==1
        F=(c(1)/(n-2)) / (Qtol/(n-1));
        disp('F����ֵ:');
        disp(F);
    else
        F=(c(i)/(n-i-1)) / (c(i-1)/(n-i));
        disp('F����ֵ:');
        disp(F);
    end
    FV= finv(alpha,n-i-1,n-i);
    if F > FV
        disp('�����Լ���ɾ������');
        break;
        else
        disp(['����ɾ������',num2str(AN(pm))]);
    end
               
    AN(pm)=[];%ȥ��������С�ı�����
    Qtol=min(Q);
end
disp('����ѡȡ�ı�����');
disp(AN);



 