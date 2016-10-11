function signal = Receive(Noise_signal_input,Q,N_data,L_pr)
    
    c = 1;
    Sum = [];
    mode = 0;
    flag = 0;
    count = 0;
    Point = [];
    start_data = 0;
    flag_count = 0;
    
    % ������� �������������� ����� �������
    Compare_signal = Comparator(Noise_signal_input,0);
    signal = zeros(size(Compare_signal,1),size(Compare_signal,2));
    for i = 1:size(Compare_signal,1)
        Sum(i) = 2*sum(Compare_signal(i,:))/size(Compare_signal,2);
        if Sum(i) >= 0.7
            Point(c) = i;
            c = c + 1;
        end
    end
    c = size(Point,2);
    Data_signal = Comparator(Compare_signal(Point,:),1);
    
    % ����� �������
    for i = 1 : size(Compare_signal,1)*size(Compare_signal,2)
        if flag == 1% ��������� ����� Q �������� ����� ����������� ��������
            if i == strt + Q
                signal(i) = Compare_signal(i);
                count = count + 1;
            else if i == strt + Q + 1
                    signal(i) = Compare_signal(i);
                    flag = 0;
                    count = count + 1;
                    flag_count = flag_count + 1;
                end
            end
        else if flag == 0
                % ��������� �� 3 ������� ���� �� ����� 1 ������� (flag = 0)
                if count < 3
                    signal(i) = Compare_signal(i);
                    count = count + 1;
                else % ���������� ������ 4 ������ � ��������� �������� 3
                    count = 0;
                    signal(i) = 0;
                    [strt, flag, ~] = Search_Impuls(signal, i, mode, 0);
                end
            end
        end
        if (i > size(Compare_signal,1)*size(Compare_signal,2) - Q*N_data)&&(flag_count > L_pr)&&...
            (strt > size(Compare_signal,1)*size(Compare_signal,2) - Q*N_data-Q)
            % ������� ��������� ������ ������

            if (strt > size(Compare_signal,1)*size(Compare_signal,2)-Q*N_data)
                factor = strt - size(Compare_signal,1)*size(Compare_signal,2)+Q*N_data;
                factor = round(factor/Q);
                start_data = start_data + round((strt - start_data)/Q)*Q-factor*Q+1;
            else
                factor = size(Compare_signal,1)*size(Compare_signal,2)-Q*N_data - strt;
                factor = round((factor-1)/Q);
                start_data = start_data + round((strt - start_data)/Q)*Q+factor*Q+1;
            end
            signal(Point(1):Point(c),size(Compare_signal,2)-N_data+1:end) = ...
                Receive_Data(Compare_signal(Point(1):Point(c),size(Compare_signal,2)-N_data+1:end),...
                start_data-size(Compare_signal,1)*size(Compare_signal,2)+Q*N_data);%,Q);
            break;
        end
    end
end