function p_pls( x,y,r )
%�ú���ʵ�ֶ���ʽ-pls�㷨����,��ԭpls�����Ͻ��иĽ�������ȡ�ĳɷ־�����ж���ʽ��չ��ʵ��һ�ַ����Ա任�����ڴ�����������ݡ�
% ���ߣ�zlw
% ʱ�䣺2015-10-14
%˵����x,y�ֱ�Ϊ�����������ݺ����������������룬rѡ���ɷָ���

X=zscore(x);

% 
% % ���ݹ�һ��
% [n,~]=size(x);
% x_2=sqrt(diag(x*x'));
% for i=1:n
%     X(i,:)=x(i,:)/x_2(i);
% end
% X=zscore(X);

Y=zscore(y);
[n,mx]=size(X);

E0=X;F0=Y;
for i=1:mx
    M=E0'*F0*F0'*E0;
    [L, K]=eig(M); %��������ֵK����������T
    S=diag(K);%��ȡ����ֵ
    [~,ind]=sort(S,'descend');%����-С����ind���
    w(:,i)=L(:,ind(1)); %����������ֵ��Ӧ����������
    t(:,i)=E0*w(:,i);     %����ɷ� ti �ĵ÷�
    alpha(:,i)=E0'*t(:,i)/(t(:,i)'*t(:,i)) ;%����                 alpha_i ,����(t(:,i)'*t(:,i))�ȼ���norm(t(:,i))^2
    E1=E0-t(:,i)*alpha(:,i)' ;   %����в����
    E0=E1;
        
end

T=t(:,1:r);
% b=Y'*T/(T'*T);%��׼�����ݻع�ϵ��
% YY=T*b';%��׼�����ֵ
% yy=YY*std(y)+mean(y);%����׼��


%********* ����Ԫ���ж���ʽ��չ **********
a=r;
TT(:,1:a)=T;
TT(:,a+1:2*a)=T.^2;
k=2*a+1;
for i=1:a-1
    for j=i+1:a
        TT(:,k)=diag(T(:,i)*T(:,j)');
        k=k+1;
    end
end
%****************************************

PZ=[TT,Y];
IN=zbhg(PZ);
TTN=TT(:,IN);
bTN=Y'*TTN/(TTN'*TTN);%���𲽶���ʽ��Ԫ�Ļع�ϵ��
YTN=TTN*bTN';
yTN=YTN*std(y)+mean(y);%����׼��
figure;
plot(y);title('�𲽶���ʽƫ��С���˻ع�');
hold on;
plot(yTN);legend('real value','prediction of SWP-PLS');
hold off;

%*************** ������� ****************
e=y-yTN;
disp('��������')
disp(sqrt(e'*e/n));
disp('���ƽ��ֵ��')
disp(sum(abs(e))/n);
disp('������ֵ');
disp(max(abs(e)));
disp('������');
disp(abs(e./y*100));
disp('���������ֵ');
disp(max(abs(e./y*100)));
disp('������ƽ��ֵ');
disp(mean(abs(e./y*100)));
figure;
hist(abs(e./y*100));title('SWP-PLS-������ֱ��ͼ'); axis([0 45 0 25]);
disp('************************* ����p-pls*****************************************');



b=Y'*TT/(TT'*TT);%�Զ���ʽ��Ԫ�Ļع�ϵ��

YY=TT*b';%��׼�����ֵ
yy=YY*std(y)+mean(y);%����׼��
%******************** ��ͼ ************************
figure;
plot(y);title('����ʽƫ��С���˻ع�');
hold on;
plot(yy);legend('real value','prediction of P-PLS');
hold off;

%*************** ������� ****************
e=y-yy;
disp('��������')
disp(sqrt(e'*e/n));
disp('���ƽ��ֵ��')
disp(sum(abs(e))/n);
disp('������ֵ');
disp(max(abs(e)));
disp('������');
disp(abs(e./y*100));
disp('���������ֵ');
disp(max(abs(e./y*100)));
disp('������ƽ��ֵ');
disp(mean(abs(e./y*100)));

figure;
hist(abs(e./y*100));title('P-PLS-������ֱ��ͼ'); 
axis([0 45 0 25]);
end



