function s = Receive_Signal(Noise_signal_input, T, N)
% ������������ ����� ������� (Signal) � ������� ��� (s)
% ����� �������, �� �� �������� ���������, � �������������, ��� ��������� 
% � Search_Impuls

    flag = 0;
    Compare_signal = Comparator(Noise_signal_input);
    preamble_length = size(Compare_signal,2) - 20000 - N;
    count_impuls = 1;
    start_data = 0;
    arr_strt_impuls = zeros(1,10);
    count = 0;
    mode = 0;
    Flag_count = 0;
    size_of_signal = size(Noise_signal_input, 2);
    s = zeros(1, size_of_signal);
    
    start_data = 20000;
    s(size(Compare_signal, 2)+1 - 10000 - N:end-1000) = Receive_Data(Compare_signal,start_data,T);%������ ������
    
    
%     for x = 1:size(Compare_signal, 2)-10000
%         if (flag == 0)&&(Flag_count <= preamble_length/20)
%             if count < 3
%                 count=count+1;
%                 s(x) = Compare_signal(x);
%             else if count == 3% ���������� ������ 4 ��� � ��������� �������� 3
%                     count=0;
%                     s(x) = 0;
%                     [strt, flag, flag_impuls] = Search_Impuls(s, x, mode, 0);
%                 end
%             end
%         else if (flag == 0)&&(Flag_count >  preamble_length/20) %����������� ���������
%                 mode = 1;
%                 s(x) = Compare_signal(x);
%                 [strt, flag, flag_impuls] = Search_Impuls(s, x, mode, flag_impuls);
%                 if start_data == 0%�������� ���������� ��������� � ����� ���������
%                     for count_impuls = 4:10
%                         if (arr_strt_impuls(count_impuls)-arr_strt_impuls(count_impuls - 1)) == 2*T
%                             if (arr_strt_impuls(count_impuls - 1)-arr_strt_impuls(count_impuls - 2)) == 2*T
%                                 if (arr_strt_impuls(count_impuls - 2)-arr_strt_impuls(count_impuls - 3)) == 2*T
%                                     start_data = arr_strt_impuls(count_impuls);
%                                     break;
%                                 end
%                             end
%                         end
%                     end
%                 end
%                 if (strt > size(Compare_signal, 2) - 10010 - N)&&(strt < size(Compare_signal, 2) - 10000 - N)%������� ������ ������
%                     if mod((strt - start_data),T) == 0
%                         start_data = strt+10;
%                     else if mod(round((strt - start_data)/T)*T,T) == 0
%                             start_data = start_data + round((strt - start_data)/T)*T+10;
%                         end
%                     end
%                     s(size(Compare_signal, 2)+1 - 10000 - N:end-1000) = Receive_Data(Compare_signal,start_data,T);%������ ������
%                     break;
%                 end
%            %��������� �������� � ��������
%             else if flag == 1% ����� �������
%                      if x == strt + T% ���� ������� ������� �� ������� � ������ �������� �
%                         s(x) = Compare_signal(x); 
%                      else if x == strt + T + 1
%                              s(x) = Compare_signal(x);
%                              Flag_count = Flag_count + 1;
%                              flag = 0;
%                              if (Flag_count >  preamble_length/20-10)&&(Flag_count <=  preamble_length/20)
%                                  arr_strt_impuls(count_impuls) = x-1;
%                                  count_impuls = count_impuls + 1;
%                              end
%                          end
%                      end
%                      if mode == 1
%                          flag = 0;
%                      end
%                 end
%             end
%         end
%     end



%     subplot(3,1,1);plot(Noise_signal_input, '-c'); xlabel('Noise_signal');
%     subplot(3,1,2);plot(Compare_signal, '-b'); xlabel('Signal');
%     subplot(3,1,3);plot(s, '-k'); xlabel('s');
end



