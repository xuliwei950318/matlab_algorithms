clear all
close all
clc
load BP50GATEST.mat    %���ͷе�����
% ѵ��������
Xtrn=bp50_s1d_ll_a;
Ytrn=bp50_y1_ll_a;

% ����������
Xtst=bp50_s1d_ll_b;
Ytst=bp50_y1_ll_b;

mX=mean(Xtrn);
stdX=std(Xtrn);

mY=mean(Ytrn);
stdY=std(Ytrn);

Ntrn=length(Ytrn);
Ntst=length(Ytst);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��׼��
Xtrn=zscore(Xtrn);
Ytrn=zscore(Ytrn);

Xtst=(Xtst-repmat(mX,Ntst,1))./repmat(stdX,Ntst,1);
Ytst=(Ytst-repmat(mY,Ntst,1))./repmat(stdY,Ntst,1);


LV=15;% PLS ���ɷָ���

[B b]=plskernel_1(Xtrn,Ytrn,LV);

Ypre_tst=Xtst*B+b;%�Բ������ݵ�Ԥ����

% ����׼��
Yreal=Ytst*stdY+mY;
Yreal_pre=Ypre_tst*stdY+mY;

RMSE_tst=sqrt(sum((Yreal-Yreal_pre).^2)/Ntst)

figure;hold on
plot(Yreal,'r-')
plot(Yreal_pre,'b--')
legend('����ֵ','Ԥ��ֵ')







