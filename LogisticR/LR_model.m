function [ w,x_mean,x_std ] = LR_model( x,y,alpha,echo,figure_flag )
%�߼��ع�
%�ο���http://blog.csdn.net/hechenghai/article/details/46817031
%x=[m*n]�ľ���y=[m*1]��0/1������ 
%alphaΪ�ݶ��½�ѧϰ����, itera_numΪ�ݶ��½���������


 [m, n] = size(x);
 sample_num = m;
x_mean=mean(x);x_std=std(x);
x=zscore(x);
x = [ones(m, 1), x]; %x����һά����Ϊǰ�����ֻ�ǰ����˵��

% pos = find(y == 1); neg = find(y == 0);%pos ��neg �ֱ��� yԪ��=1��0�����ڵ�λ�������ɵ�����

 g = inline('1.0 ./ (1.0 + exp(-z))','z'); %������൱��������һ��function g��z��=1.0 ./ (1.0 + exp(-z))

theta = zeros(n+1, 1);%thera��ʾ����Xi����Ԫ�ص��ӵ�Ȩ��ϵ����������������ʽ��ʾ���ҳ�ʼ��Ϊ0����ά����
J = zeros(echo, 1);%itera_num*1����������n��Ԫ�ش����n�ε���cost function��ֵ��������negtive �Ķ�����Ȼ������
%��Ϊ��negtive �ģ���������ü�Сֵ��
for i = 1:echo %�����ĳ��ѧϰ����alpha�µ���itera_num������Ĳ���   
 z = x * theta;%���z��һ����������ÿһ��Ԫ����ÿһ������Xi�����Ե��Ӻͣ���ΪX�����е�������������ﲻ��һ��һ��������ģ�
 %������������һ����ģ����z��һ��������������Xi�����Ե��Ӻ͵��������ڹ�ʽ�У��ǵ���������ʾ��������matlab�ж������е�����һ������
 h = g(z);%���h��������Xi����Ӧ��yi=1ʱ��ӳ��ĸ��ʡ����һ������Xi����Ӧ��yi=0ʱ����Ӧ��ӳ�����д��1-h��
 J(i) =(1/sample_num).*sum(-y.*log(h) - (1-y).*log(1-h));%��ʧ������ʸ����ʾ�� ����Jtheta�Ǹ�100*1����������
 grad = (1/sample_num).*x'*(h-y);%�����������ʽ�ģ����ǿ���grad�ڹ�ʽ����gradj=1/m*����Y��Xi��-yi��Xij ��д�ñȽϴ��ԣ�
 %���Y��Xi��-yi����Xij %���Ǳ��������ڳ�����������������ʽ����ģ����Բ���ֱ�Ӱѹ�ʽ�հᣬ����Ҫ���濴������������Ӧ�ı�һ�¡�
 theta = theta - alpha*grad;
end

    if figure_flag==1
    plot(0:echo-1, J(1:echo),'b-','LineWidth', 2)

    %�˴�һ��Ҫͨ��char������ת����Ϊ���ã���������õ��Ļ��ǰ�cell��
    %���Բ�Ҫ��char����ת����Ҳ������{}�����������Ͳ���ת���ˡ�
    %һ��ѧϰ���ʶ�Ӧ��ͼ�񻭳����Ժ��ٻ�����һ��ѧϰ���ʶ�Ӧ��ͼ��    

    xlabel('Number of iterations')
    ylabel('Cost function')
    title('��С����ʧ����������');
    end
w=theta ;
%prob = g([1, -0.2, -0.1]*theta);  %Ԥ��
end

