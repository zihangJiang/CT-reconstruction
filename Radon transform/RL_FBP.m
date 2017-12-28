function  [rec_RL] = RL_FBP(theta_num,N,R1,delta, fh_RL,deg)
% R-L filtered back projection function
% ------------------------------
% 输入参数 ：
% theta_num    ： 投影角度个数
% N        ： 图像大小、探测器通道个数
% R1       :  投影数据矩阵
% delta    :  角度单位
% fh_RL    :  R-L 滤波函数
% 输出参数 ：
% rec_RL  :  反投影重建矩阵
rec_RL = zeros(N);
for m = 1:theta_num
    pm = R1(:,m); %某一角度的投影数据
    pm_RL = conv(fh_RL, pm, 'same');    % 做卷积
    Cm = (N/2)*(1-cos(deg(m)*delta)-sin(deg(m)*delta));
    tx = floor(N/100*(50-40.733651335197870));
    ty = floor(N/100*(50-43.727107987934176));%旋转中心平移像素
        for k1 = 1-ty:N-ty
            for k2 = tx+1:N+tx
                %以下是射束计算，注意射束编号n取值范围为1~N-1
                Xrm = (Cm+(k2-1)*cos(deg(m)*delta)+(k1-1)*sin(deg(m)*delta)-N/2)/sqrt(2)+N/2;
                n = floor(Xrm); % 射束编号（整数部分）
                t = Xrm-floor(Xrm); % 小数部分
                n = max(1,n); n = min(n,N-1); % 限定n范围为1~N-1
                p_RL =((1-t)*(pm_RL(2*n-1)+pm_RL(2*n))+t*(pm_RL(2*n+1)+pm_RL(2*n+2)))*delta; % 线性内插，由此线性内插限制了此代码只能用于N/2的矩阵重建
                rec_RL(N+1-k1-ty,k2-tx) = rec_RL(N+1-k1-ty,k2-tx)+p_RL; % 反投影
            end
        end
end
end