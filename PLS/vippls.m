%%%%%%%%%%%%%%% �ó������ڻع齨ģ�ı���ɸѡ��vippls�� %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%

clc;clear;close all;
%xȫ��������,y����ֵ

load FREEZEGATEST.mat
Xtrn=f_sd_ll_a;
Ytrn=f_y_ll_a;
x=Xtrn(:,1:100);
y=Ytrn;
[n,m]=size(x);

r=m;
X=zscore(x);
Y=zscore(y);
[~,mx]=size(X);

E0=X;F0=Y;
for i=1:r
    M=E0'*F0*F0'*E0;
    [L, K]=eig(M); %��������ֵK����������T
    S=diag(K);%��ȡ����ֵ
    [~,ind]=sort(S,'descend');%����-С����ind���
    w(:,i)=L(:,ind(1)); %����������ֵ��Ӧ����������
    t(:,i)=E0*w(:,i);     %����ɷ� ti �ĵ÷�
    ap(:,i)=E0'*t(:,i)/(t(:,i)'*t(:,i)) ;%������������ap
    E1=E0-t(:,i)*ap(:,i)' ;   %����в����
    E0=E1;
        
end

%����ÿ��������vipֵ��vipֵԽ�����ñ���Խ��Ҫ���Ӵ�С����ѡȡǰ����������
for i=1:mx
    temp4=0;temp5=0;
    for j=1:r
        temp1=ap(:,j)'*ap(:,j)*t(:,j)'*t(:,j);
        temp2=abs(w(i,j))/(w(:,j)'*w(:,j));
        temp3=temp1*temp2;
        temp4=temp4+temp3;
        temp5=temp5+temp1;    
    end
    vip(i)=sqrt(mx*temp4/temp5);
end
disp(vip);
[~,sn]=sort(vip,'descend');%sn��Ϊ�Ӹߵ������б������
disp('������Ҫ����������')
disp(sn)
