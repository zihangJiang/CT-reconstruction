function [A,B] = unzip( num, M)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
C = M(:,num);
A=[];
B=[];
mid = round(-200*sin(2* pi /360*(num-55))+258);
for n=1:512
    if (C(n)~=0 && (n<=mid-25 || n>=mid+25))
        A=[A;C(n)];
        B=[B;n];
    end
end
end

