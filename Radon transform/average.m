%=֮ǰ����������main23.m=====��ʼ��========================================%
sum1=0;sum2=0;sum3=0;sum4=0;sum5=0;
count1=0;count2=0;count3=0;count4=0;count5=0;
R=zeros(256,256);
AS3=xlsread('A�⸽��.xls','����4');
%=====================�����������=========================================%
for i=1:256
    for j=1:256
        z=rec_RL(j,i);
        if(filternumber( i,j,z) ==1)
            sum1=sum1+z;
            count1=count1+1;

        elseif(filternumber( i,j,z) ==2)
            sum2=sum2+z;
            count2=count2+1;

        elseif(filternumber( i,j,z) ==3)
            sum3=sum3+z;
            count3=count3+1;

        elseif(filternumber( i,j,z) ==4)
            sum4=sum4+z;
            count4=count4+1;

        elseif(filternumber( i,j,z) ==5)
            sum5=sum5+z;
            count5=count5+1;
            
        end
    end
end
%=============������ľ�ֵ��Ϊ�Ǹ����ֵ==================================%
average1=[sum1/count1 sum2/count2 sum3/count3 sum4/count4 sum5/count5];

for i=1:256
    for j=1:256
        z=rec_RL(j,i);
        if(filternumber( i,j,z) ==1)
            R(j,i)=average1(1);

        elseif(filternumber( i,j,z) ==2)
            R(j,i)=average1(2);
            if(i<120 || i>130 || j<100)
                R(j,i)=average1(1);
            end

        elseif(filternumber( i,j,z) ==3)
            R(j,i)=average1(3);
            
        elseif(filternumber( i,j,z) ==4)
            R(j,i)=average1(4);
            
        elseif(filternumber( i,j,z) ==5)
            R(j,i)=average1(5);
            
        end
    end
end
%===�ڶ���==�ֱ��ò�����ֵ���������ֵ����ķ���===�ҳ�10�����Ӧ��������======%
Points=AS3;
answer=zeros(10,3);
answer1=zeros(10,3);
for k=1:10
    p=Points(k,:);
    temp=2.56*[p(1),100-p(2)];
    answer(k,:)=[p interp2(rec_RL,temp(1),temp(2))];
    answer1(k,:)=[p interp2(R,temp(1),temp(2))];
end

answer
answer1