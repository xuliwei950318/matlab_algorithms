function [ pr,wr,X ] = osc2_mod( x,y,r)
%˵����LS�������ź�У����ls_osc����Ȩֵ���������ls�ع��㷨��
% x:ѵ�������Ա���
% y:ѵ�����������
% r:�����ź�У���ɷָ���
% pr:��������
% wr:Ȩֵ����

%r=3;osc�ɷָ���
X=x;
mm=size(x,2);
for i=1:r
    X_cov=cov(X);
    [L, K]=eig(X_cov); %��������ֵK����������L
    p=L(:,end);
    t1=X*p;%������ɷ�

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
        t=X*p/(p'*p);
        tnew=t- y*inv(y'*y)*y'*t;%tnew��t��y��������Ϣ
        pnew=X'*tnew/(tnew'*tnew);%pnew�Ǳ任������tnew=x*pnew;
        dif=norm(tnew-told)/norm(tnew);%�ﵽһ�����Ƚ���
        p=pnew;
        told=tnew;
        if k>fn
            dif=0;
        end
    end
    
%******************************************************************
    w=tnew'*X/(X'*X);%��С������ع�ϵ��w
    w=w';
    t=X*w;%
    X=X-t*p';
    
    pr(:,i)=p;
    wr(:,i)=w;
    tr(:,i)=t;
    
end

end

