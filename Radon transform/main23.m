AS2=xlsread('A题附件.xls','附件3');
AS3=xlsread('A题附件.xls','附件4');
AS4=xlsread('A题附件.xls','附件5');
%================ 仿真参数设置 ============================================%
N = 256; % 重建图像大小，探测器采样点数也设为N
delta = pi/180; % 角度增量(弧度)
theta = degree+90; % 所有投影角度
theta_num = length(theta); 
d = 1; % 平移步长
%============ 产生滤波函数 ================================================%
fh_RL=Rlfilter(512,d); 
%==============滤波反投影重建（利用卷积）===================================%
rec_RL = RL_FBP(theta_num, N, AS2, delta, fh_RL,theta); 
rec_RL2 = RL_FBP(theta_num, N, AS4, delta, fh_RL,theta); % R-L函数滤波反投影重建
%===============结果显示===================================================%
imshow(rec_RL,[])
%surf(rec_RL)
%=====第三问=======找出10个点对应的吸收率======================================%
Points=AS3;
answer=zeros(10,3);
for k=1:10
    p=Points(k,:);
    temp=2.56*[p(1),100-p(2)];
    answer(k,:)=[p,interp2(rec_RL2,temp(1),temp(2))];
end
surf(rec_RL2)