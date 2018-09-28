%�߼��ع�
%�ο���http://blog.csdn.net/hechenghai/article/details/46817031

clear; close all; clc;
 x = [60 70
     65 75
     80 90
     70 60
     55 85
     78 57
     60 61
     90 95
     50 90
     75 58
     80 80
     65 72
     93 84
     74 69
     81 73
     40 38
     51 41
     39 68
     49 62
     51 39
     58 57
     60 53
     30 90
     70 40
     20 30
     40 86
     90 40
     55 72
     79 48
     42 85]; %ÿһ����һ������
 y = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
 
 [m, n] = size(x);
 sample_num = m;
 x =zscore(x);
x = [ones(m, 1), x]; %x����һά����Ϊǰ�����ֻ�ǰ����˵��

% Plot the training data
 % Use different markers for positives and negatives
figure;
pos = find(y == 1); neg = find(y == 0);%pos ��neg �ֱ��� yԪ��=1��0�����ڵ�λ�������ɵ�����
 plot(x(pos, 2), x(pos,3), '+')%��+��ʾ��Щyi=1����Ӧ������
 hold on
 plot(x(neg, 2), x(neg, 3), 'o')
 hold on
 xlabel('Exam 1 score')
 ylabel('Exam 2 score')
 itera_num=500;%��������
 g = inline('1.0 ./ (1.0 + exp(-z))','z'); %������൱��������һ��function g��z��=1.0 ./ (1.0 + exp(-z))
 plotstyle = {'b-', 'r-', 'g-', 'k-', 'b--', 'r--'};
 figure;%�����µĴ���
 alpha = [ 1, 0.0008,0.0007,0.0006,0.0005 ,1.0004 ];%����ͷֱ����⼸��ѧϰ���ʿ����ĸ�����
 for alpha_i = 1:length(alpha) %alpha_i��1,2��...6����ʾ����ѧϰ�������������߸�ʽ���������꣺alpha(alpha_i)��plotstyle(alpha_i)
     theta = zeros(n+1, 1);%thera��ʾ����Xi����Ԫ�ص��ӵ�Ȩ��ϵ����������������ʽ��ʾ���ҳ�ʼ��Ϊ0����ά����
     J = zeros(itera_num, 1);%J�Ǹ�100*1����������n��Ԫ�ش����n�ε���cost function��ֵ��������negtive �Ķ�����Ȼ������
     %��Ϊ��negtive �ģ���������ü�Сֵ��
     for i = 1:itera_num %�����ĳ��ѧϰ����alpha�µ���itera_num������Ĳ���   
         z = x * theta;%���z��һ����������ÿһ��Ԫ����ÿһ������Xi�����Ե��Ӻͣ���ΪX�����е�������������ﲻ��һ��һ��������ģ�
         %������������һ����ģ����z��һ��������������Xi�����Ե��Ӻ͵��������ڹ�ʽ�У��ǵ���������ʾ��������matlab�ж������е�����һ������
         h = g(z);%���h��������Xi����Ӧ��yi=1ʱ��ӳ��ĸ��ʡ����һ������Xi����Ӧ��yi=0ʱ����Ӧ��ӳ�����д��1-h��
         J(i) =(1/sample_num).*sum(-y.*log(h) - (1-y).*log(1-h));%��ʧ������ʸ����ʾ�� ����Jtheta�Ǹ�100*1����������
         grad = (1/sample_num).*x'*(h-y);%�����������ʽ�ģ����ǿ���grad�ڹ�ʽ����gradj=1/m*����Y��Xi��-yi��Xij ��д�ñȽϴ��ԣ�
         %���Y��Xi��-yi����Xij %���Ǳ��������ڳ�����������������ʽ����ģ����Բ���ֱ�Ӱѹ�ʽ�հᣬ����Ҫ���濴������������Ӧ�ı�һ�¡�
         theta = theta - alpha(alpha_i).*grad;
     end
     plot(0:itera_num-1, J(1:itera_num),char(plotstyle(alpha_i)),'LineWidth', 2)

          %�˴�һ��Ҫͨ��char������ת����Ϊ���ã���������õ��Ļ��ǰ�cell��

     %���Բ�Ҫ��char����ת����Ҳ������{}�����������Ͳ���ת���ˡ�
     %һ��ѧϰ���ʶ�Ӧ��ͼ�񻭳����Ժ��ٻ�����һ��ѧϰ���ʶ�Ӧ��ͼ��    
     hold on
     if(1 == alpha(alpha_i)) %ͨ��ʵ�鷢��alphaΪ0.0013 ʱЧ����ã����ʱ�ĵ������thetaֵΪ�����ֵ
         theta_best = theta;
     end
 end
 legend('0.0009', '0.001','0.0011','0.0012','0.0013' ,'0.0014');%��ÿһ���߶θ�ʽ��ע��
 xlabel('Number of iterations')
 ylabel('Cost function')
 prob = g([1, -0.2, -0.1]*theta);  %Ԥ��