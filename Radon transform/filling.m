function [ C ] = filling( A,B )
%%=============�����Բ�õ�ÿ��Բ�����ݺ���=============%%

C=A;
for k=1:180
   for n=1:512
       a=B(k,1);
       b=B(k,2);
       c=B(k,3);
       temp=a*n^2+b*n+c;
       if temp>0
           C(n,k)=A(n,k)-sqrt(temp);
           if C(n,k)<0.01
               C(n,k)=0;
           end
       end

   end
end
end

