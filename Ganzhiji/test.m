clc;clear;close all;

X=[3,3;4,3;1,1];
Y=[1;1;-1];

[W,b]=perceptron(X,Y,100);



sign=X*W+b; %���ߺ���

sign(sign>0)=1;
sign(sign<0)=-1;

disp(sign);


