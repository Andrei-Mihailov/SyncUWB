function [data, start_data, count_pack] = ReceiveByChar(Noise_signal_input, Q, N_data, M_seq, Zero)
    
    i = 0;
    fac = 1;
    flag = 0;
    strt = 0;
    data = 0;
    count = 0;
    point_data = size(Noise_signal_input,2)*10 - 9999;
    count_pack = 0;
    start_data = 0;
    Flag_seq = 0;
    signal = [];
    Compare_signal = [];
    % прием сигнала
    while Flag_seq == 0
        i = i + 1;
        if i == size(Noise_signal_input,1)*size(Noise_signal_input,2)-N_data*Q*size(Zero,2)+1;
            break;
        end
        if flag == 1% принимаем через Q отсчетов после предыдущего импульса
            if i == strt + Q*fac;
                Compare_signal(i) = Comparator(Noise_signal_input(i),0);
                signal(i) = Compare_signal(i);
            else if i == strt + Q*fac + 1
                    Compare_signal(i) = Comparator(Noise_signal_input(i),0);
                    signal(i) = Compare_signal(i);
                    count = count + 1;%считаем кол-во единичных отсчетов
                    fac = fac + 1;
                    if count > 6
                        [strt, ~, ~] = Search_Impuls(signal, i, Q, 1, 0, strt);
                        if count > 32
                            for Seq = 0 : size(M_seq,2)-1
                                if ((signal(i-Q*Seq)*2-1 + signal(i-Q*Seq-1)*2-1))/2 == M_seq(size(M_seq,2)-Seq)
                                    Flag_seq = 1;
                                else if signal(i-Q*Seq)*2-1 == M_seq(size(M_seq,2)-Seq)
                                        Flag_seq = 1;
                                    else if signal(i-Q*Seq-1)*2-1 == M_seq(size(M_seq,2)-Seq)
                                        Flag_seq = 1;
                                    else
                                        Flag_seq = 0;
                                        break;
                                        end
                                    end
                                end
                            end
                        end
                        if Flag_seq == 1
%                             if count < 900
%                                 Flag_seq = 0;
%                             else
                                % решить проблему неправильного обнаружения
                                % позиции strt_Barker
                                strt_seq = i-Q*Seq-1;
%                             end
                        end
                    elseif count < 6
                        fac = 1;
                        flag = 0;
                    else
                        for c = 0:count
                            if signal(i-Q*c) + signal(i-Q*c-1) == 0%сбрасываем флаг, если не все из 5 принятых отсчетов = 1
                                fac = 1;
                                flag = 0;
                                count = 0;
                                break;
                            end
                        end
                    end
                end
            end
        else if flag == 0
                Compare_signal(i) = Comparator(Noise_signal_input(i),0);
                signal(i) = Compare_signal(i);
                if mod(i,Q) == 0
                    [strt, flag, ~] = Search_Impuls(signal, i, Q, 0, 0,strt);
                end
            end
        end
    end
    if Flag_seq == 1
        % указатель начала данных
        start_data = strt_seq + size(M_seq,2) * Q;
%         strt = strt + Q*(fac-1);
%         if (strt > size(Compare_signal,1)*size(Compare_signal,2)-Q*N_data)
%             factor = strt - size(Compare_signal,1)*size(Compare_signal,2)+Q*N_data;
%             factor = round(factor/Q);
%             start_data = start_data + round((strt - start_data)/Q)*Q-factor*Q+1;
%         else
%             factor = size(Compare_signal,1)*size(Compare_signal,2)-Q*N_data - strt;
%             factor = round((factor-1)/Q);
%             start_data = start_data + round((strt - start_data)/Q)*Q+factor*Q+1;
%         end

        % прием данных
        data = zeros(2,N_data*size(Zero,2));
        if start_data <= size(Noise_signal_input,1)*size(Noise_signal_input,2) - N_data*Q*size(Zero,2) + 1
            for data_count = 0:N_data*size(Zero,2)-1
                Compare_signal(1,start_data + data_count*Q : start_data + data_count*Q + 1) = ...
                    Comparator(Noise_signal_input(start_data + data_count*Q : start_data + data_count*Q + 1),0);
                data(1,data_count+1) = Compare_signal(start_data + data_count*Q);
                data(2,data_count+1) = Compare_signal(start_data + data_count*Q + 1);
            end
            count_pack = 1;
        end
    end
end