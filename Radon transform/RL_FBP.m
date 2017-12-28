function  [rec_RL] = RL_FBP(theta_num,N,R1,delta, fh_RL,deg)
% R-L filtered back projection function
% ------------------------------
% ������� ��
% theta_num    �� ͶӰ�Ƕȸ���
% N        �� ͼ���С��̽����ͨ������
% R1       :  ͶӰ���ݾ���
% delta    :  �Ƕȵ�λ
% fh_RL    :  R-L �˲�����
% ������� ��
% rec_RL  :  ��ͶӰ�ؽ�����
rec_RL = zeros(N);
for m = 1:theta_num
    pm = R1(:,m); %ĳһ�Ƕȵ�ͶӰ����
    pm_RL = conv(fh_RL, pm, 'same');    % �����
    Cm = (N/2)*(1-cos(deg(m)*delta)-sin(deg(m)*delta));
    tx = floor(N/100*(50-40.733651335197870));
    ty = floor(N/100*(50-43.727107987934176));%��ת����ƽ������
        for k1 = 1-ty:N-ty
            for k2 = tx+1:N+tx
                %�������������㣬ע���������nȡֵ��ΧΪ1~N-1
                Xrm = (Cm+(k2-1)*cos(deg(m)*delta)+(k1-1)*sin(deg(m)*delta)-N/2)/sqrt(2)+N/2;
                n = floor(Xrm); % ������ţ��������֣�
                t = Xrm-floor(Xrm); % С������
                n = max(1,n); n = min(n,N-1); % �޶�n��ΧΪ1~N-1
                p_RL =((1-t)*(pm_RL(2*n-1)+pm_RL(2*n))+t*(pm_RL(2*n+1)+pm_RL(2*n+2)))*delta; % �����ڲ壬�ɴ������ڲ������˴˴���ֻ������N/2�ľ����ؽ�
                rec_RL(N+1-k1-ty,k2-tx) = rec_RL(N+1-k1-ty,k2-tx)+p_RL; % ��ͶӰ
            end
        end
end
end