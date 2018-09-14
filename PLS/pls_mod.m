function  [ p,X_mean,X_std,Y_mean,Y_std,b] = pls_mod( x,y,r )
%˵��������pls�㷨��ģ��
% x������ѵ������(��������)
% y: ����ѵ�����ݣ�����ֵ��
% r�����ɷָ���
% p: ��ά����t=x*p��
% X_mean,X_std:ѵ�����ݾ�ֵ�ͱ�׼��
% Y_mean,Y_std��~
% b����׼���Ļع�ϵ��



X=zscore(x);X_mean=mean(x);X_std=std(x);
Y=zscore(y);Y_mean=mean(y);Y_std=std(y);
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

T=t(:,1:r);

%****************************************
b=Y'*T/(T'*T);%����Ԫ�Ļع�ϵ��

%�õ�X��ά����p
temp=eye(mx);%�Խ���
for i=1:r
       if i==1
           p(:,i)=w(:,i);
       else
          for j=1:i-1
              temp=temp*(eye(mx)-w(:,j)*ap(:,j)');
          end
          p(:,i)=temp*w(:,i);
       end 
end



end

