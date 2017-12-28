%==============��ʼ��=====================================================%
%AS0=xlsread('A�⸽��.xls','����1');
AS1=xlsread('A�⸽��.xls','����2');
%AS2=xlsread('A�⸽��.xls','����3');
%AS3=xlsread('A�⸽��.xls','����4');
%AS4=xlsread('A�⸽��.xls','����5');
Ellipse=zeros(180,3);
Circle=zeros(180,3);


%=====��ȥ����Բ������,��ϵõ�ÿ����Բ�ķ���sqrt(ax^2+bx+c),��¼a,b,c=======%


for k=1:180
    [A,B]=unzip(k,AS1);
    A=A.^2;
    target=polyfit(B,A,2);
    Ellipse(k,1)=target(1);
    Ellipse(k,2)=target(2);
    Ellipse(k,3)=target(3);
end

%================ȥ����Բ������,����Բ������===============================%

Circle_sin=filling(AS1,Ellipse);

%================�õ�ÿ��Բ�ķ���sqrt(ax^2+bx+c),��¼a,b,c=================%

for k=1:180
    [A,B]=unzip_circle(k,Circle_sin);
    A=A.^2;
    target=polyfit(B,A,2);
    Circle(k,1)=target(1);
    Circle(k,2)=target(2);
    Circle(k,3)=target(3);
end

%==============����Բ�뾶�Ĳ�������̽�������===============================%

diameter=0;
for k=1:180
    a=Circle(k,1);
    b=Circle(k,2);
    c=Circle(k,3);
    diameter=diameter+sqrt(b^2-4*a*c)/abs(a);
end
diameter=diameter/180;
R=8/diameter


%=============�����Բ��Բ������=======˳����������Ĳ�=====================%
center_Ellipse=zeros(180,1);
center_Circle=zeros(180,1);
center_Distance=zeros(180,1);



for k=1:180
    target=Ellipse(k,:);
    target2=Circle(k,:);
    center_Ellipse(k)=-target(2)/(2*target(1));
    center_Circle(k)=-target2(2)/(2*target2(1));
    center_Distance(k)=-target(2)/(2*target(1))+target2(2)/(2*target2(1));
end

%===============��Ƕ�ֵ===================================================%
degree=zeros(180,1);
for k=1:180
    degree(k)=180*asin(center_Distance(k)*R/45)/pi;
end
%=========================����arcsin����===================================%

temp=1;
min=abs(degree(2)-degree(1));

for k=2:180
    if(abs(degree(k)-degree(k-1))<min)
        min=abs(degree(k)-degree(k-1));
        temp=k;
    end
end
for k=temp:180
    degree(k)=180-degree(k);
end

%=================�ֱ���ϳ�Բ����Բ�����Ĳ���϶�Ӧ���ĵ���������===========%
f = fittype('a*sin(b*x+c)+d'); %   ��Ϻ�������ʽ 
fit1 = fit(degree,center_Ellipse,f,'StartPoint',[48,0.01,0.8498,200]);
fit2 = fit(degree,center_Circle,f,'StartPoint',[200,0.01,0.4905,200]);

%=====�������������������������ĵ���ת���ĵľ���,�������ת��������=========%

%=================WARNING����ԭ��Ϊ���Ͻ�==================================%

r1=fit2.a*R;%=====RΪ̽�������============================================%
r2=fit1.a*R;

%=================��ת��������=============================================%

x=(r2^2-r1^2+95^2-50^2)/90
y=50-sqrt(r1^2-(x-95)^2)

%==================ת��iteration.m��ʼ��������=============================%

