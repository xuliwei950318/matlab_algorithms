function [ pr,wr,X ] = osc1_mod( x,y,r)
%˵����PLS�������ź�У����pls_osc����Ȩֵ���������pls�ع��㷨��
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
%     t=t-y*inv(y'*y)*y'*t;%��һ�����ò��ü���Ԥ������
    p=X'*t/(t'*t); 
    X=X-t*p';
    
    pr(:,i)=p;
    wr(:,i)=w;
    tr(:,i)=t;
    
end

end

