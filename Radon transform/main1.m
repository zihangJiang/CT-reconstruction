%==============初始化=====================================================%
%AS0=xlsread('A题附件.xls','附件1');
AS1=xlsread('A题附件.xls','附件2');
%AS2=xlsread('A题附件.xls','附件3');
%AS3=xlsread('A题附件.xls','附件4');
%AS4=xlsread('A题附件.xls','附件5');
Ellipse=zeros(180,3);
Circle=zeros(180,3);


%=====先去掉有圆的数据,拟合得到每列椭圆的方程sqrt(ax^2+bx+c),记录a,b,c=======%


for k=1:180
    [A,B]=unzip(k,AS1);
    A=A.^2;
    target=polyfit(B,A,2);
    Ellipse(k,1)=target(1);
    Ellipse(k,2)=target(2);
    Ellipse(k,3)=target(3);
end

%================去除椭圆的数据,留下圆的数据===============================%

Circle_sin=filling(AS1,Ellipse);

%================得到每列圆的方程sqrt(ax^2+bx+c),记录a,b,c=================%

for k=1:180
    [A,B]=unzip_circle(k,Circle_sin);
    A=A.^2;
    target=polyfit(B,A,2);
    Circle(k,1)=target(1);
    Circle(k,2)=target(2);
    Circle(k,3)=target(3);
end

%==============利用圆半径的不变性求探测器间距===============================%

diameter=0;
for k=1:180
    a=Circle(k,1);
    b=Circle(k,2);
    c=Circle(k,3);
    diameter=diameter+sqrt(b^2-4*a*c)/abs(a);
end
diameter=diameter/180;
R=8/diameter


%=============求出椭圆和圆的中心=======顺带求出两中心差=====================%
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

%===============求角度值===================================================%
degree=zeros(180,1);
for k=1:180
    degree(k)=180*asin(center_Distance(k)*R/45)/pi;
end
%=========================修正arcsin函数===================================%

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

%=================分别拟合出圆和椭圆的中心并拟合对应中心的正弦曲线===========%
f = fittype('a*sin(b*x+c)+d'); %   拟合函数的形式 
fit1 = fit(degree,center_Ellipse,f,'StartPoint',[48,0.01,0.8498,200]);
fit2 = fit(degree,center_Circle,f,'StartPoint',[200,0.01,0.4905,200]);

%=====利用两正弦曲线振幅求出两中心到旋转中心的距离,并求出旋转中心坐标=========%

%=================WARNING坐标原点为左上角==================================%

r1=fit2.a*R;%=====R为探测器间距============================================%
r2=fit1.a*R;

%=================旋转中心坐标=============================================%

x=(r2^2-r1^2+95^2-50^2)/90
y=50-sqrt(r1^2-(x-95)^2)

%==================转到iteration.m开始迭代操作=============================%

