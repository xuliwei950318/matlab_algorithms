%%%%%%%%%%%%%%% �ó������ڻع齨ģ�ı���ɸѡ�����pls�� %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% ����ǰ�򽻲���֤�ͺ���ɸ������֤ѡ�� %%%%%%%%%%%%%%%%

clc;clear;close all;
%xȫ��������,y����ֵ

load FREEZEGATEST.mat
Xtrn=f_sd_ll_a;
Ytrn=f_y_ll_a;
x=Xtrn(:,1:400);
y=Ytrn;
[n,m]=size(x);
k=m/5;%��k�����䣬ÿ������5��������



%**************** ǰ��ѡȡ���� forward_ipls *************************
xx=x;t=1:k;XX=[];%XX��һ��������������%xx��Ųв��������
for j=1:k 
    r_pls=3+floor(2*sqrt(j));%�ɷָ�����������������
    for i=1:k-j+1;
        X=[XX,xx(:,(5*i-4):5*i)];%ǰ�����ӱ���
        [p,X_mean,X_std,Y_mean,Y_std,b]= pls_mod( X,y,r_pls );%����plsģ��
        y_pls = pls_pr( X,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%plsԤ�����
        e=y-y_pls;
        RMSE(i)=sqrt(e'*e/n);
    end
    e_min(j)=min(RMSE);
    k_min=find(RMSE()==min(RMSE));%�����С���������
    RMSE=[];
    s(j)=t(k_min);
    XX=[XX,x(:,5*s(j)-4:5*s(j))]; %XX��һ��������������
    xx(:,5*k_min-4:5*k_min)=[];%xx��Ųв��������
    t(k_min)=[];%t��Ų���������ţ�Ϊ��һɾ�����������ʣ�µ��������   
    if j>1
        if e_min(j)>e_min(j-1)
%             disp(j-1);
            disp('ǰ�������С��')
            disp(e_min(j-1))
            break;
        end
    end
end
disp('ǰ��ѡȡ�ı������䣺');
disp(s(1:end-1));

%**************** ����ѡȡ���� reverse_ipls *************************
xx=x;t=1:k;%
e_min=[];s=[];
for j=1:k 
%     r_pls=3+floor(2*sqrt(k/j));%�ɷָ�����������������
    r_pls=3+floor(2*sqrt(k-j+1));%�ɷָ�����������������
    for i=1:k-j+1;
        X=xx;
        X(:,(5*i-4):5*i)=[];%����ɾ���������
        [p,X_mean,X_std,Y_mean,Y_std,b]= pls_mod( X,y,r_pls );%����plsģ��
        y_pls = pls_pr( X,p,X_mean,X_std,Y_mean,Y_std,b,r_pls);%plsԤ�����
        e=y-y_pls;
        RMSE(i)=sqrt(e'*e/n);
    end
    e_min(j)=min(RMSE);
    k_min=find(RMSE()==min(RMSE));%�����С���������
    RMSE=[];
    s(j)=t(k_min);
    xx(:,5*k_min-4:5*k_min)=[];%xxȥ������������         
    if j>1
        if e_min(j)>e_min(j-1)
%             disp(j-1);
            disp('���������С��')
            disp(e_min(j-1))
            break;
        end
    end
    t(k_min)=[];%t���ʣ������������ţ���һɾ����������ʣ�µ�������� 
end
disp('����ѡȡ�ı������䣺');
disp(t);
