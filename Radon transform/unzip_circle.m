function [A,B] = unzip_circle( num, M)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
C = M(:,num);
A=[];
B=[];

for n=1:512
    if (C(n)~=0)
        A=[A;C(n)];
        B=[B;n];
    end
end
end
