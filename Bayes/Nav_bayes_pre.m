function [pyxn ] = Nav_bayes_pre( xx ,unx,uny, pxy, py,  C)
%--------------------------------��������---------------------------
%�����pyxn:��uny������� �õ���Ӧ�ĺ�����ʣ�pyxn(:,end)Ϊ���������
[n,~]=size(xx);
m=length(C)-1;
pyxn=[];
for k=1:n
    xxx=xx(k,:);
    sum=0;
    for i=1:C(m+1)
        mul=1;
        for j=1:m
            j_n= unx{j}==xxx(j);
            mul=mul*pxy(j_n,j,i);
        end
        pxx(i)=mul;    
        sum=sum+py(i)*pxx(i);            
    end
    p_b=sum;%��ĸ��ȫ����

    for i=1:C(m+1)
        mul=1;
        for j=1:m
            j_n= unx{j}==xxx(j);
            mul=mul*pxy(j_n,j,i);
        end
        pxx(i)=mul;
        p_a=py(i)*pxx(i);%���ӣ����ϸ���


        pyx(i)=p_a/p_b;
    end

    y_pre=max(pyx);%Ԥ���������
    rx=find(pyx==y_pre);
    y_num=uny(rx(1));%Ԥ�������ʵ��������
    
    pyxn=[ pyxn;[pyx,y_num]];
end

end

