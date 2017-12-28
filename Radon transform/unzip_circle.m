function [A,B] = unzip_circle( num, M)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
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
