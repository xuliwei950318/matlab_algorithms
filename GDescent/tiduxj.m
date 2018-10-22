%%
%�ݶ��½��㷨(gradient descent)
%˵������һ����Ԫ����ʽ��������Сֵ(x1,x2)����>min(fn)
%ʱ�䣺2016-01-04
%���ߣ�zlw

%%
clc;clear;close all;

syms x1 x2 r;
fn=x1-x2+2*x1^2+2*x1*x2+x2^2;%���庯��
%exmp:fn0=subs(fn,{x1,x2},{1,2});%����(1,2)���ĺ���ֵ
dfn1=diff(fn,x1);%��x1ƫ��
dfn2=diff(fn,x2);%��x2ƫ��

e=0.000001;%��Χ
x_next=[0,0];%��ʼ������
for k=1:10000
    t1(k)=x_next(1);t2(k)=x_next(2);
    dfn=[subs(dfn1,{x1,x2},{t1(k),t2(k)}),subs(dfn2,{x1,x2},{t1(k),t2(k)})];%����õ��ƫ��
    d=-dfn;
    if d*d'<=e
        x_min=[t1(k),t2(k)];%������ŵ�
        break;
    else
        x_temp=[t1(k),t2(k)]+r*d;
        yr=subs(fn,{x1,x2},{x_temp(1),x_temp(2)});
        dyr=diff(yr,r);
        r_min=double(solve(dyr,r));  %(�����Ų���r)����Ϊ0ʱ��rֵ,solve���ʽ���̺�ǿ��
        x_next=[t1(k),t2(k)]+r_min*d;
    end
end
disp('��Сֵ��(x1,x2)Ϊ��');
disp(x_min);
disp('��СֵΪ��')
disp(double(subs(fn,{x1,x2},x_min)));

