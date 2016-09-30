function data_signal = Receive_Data (Receive_buf, start_data, T)
%прием данных
start_data=1;
    data_signal = zeros(1,10000);
    before_data = size(Receive_buf, 2) - 10000-1000;
    end_data = start_data + 1;
    for counter = 0:999
% %         end_data+T*counter < size(Receive_buf, 2) + 1
% %         if (start_data+T*counter-not_data>0)&&(end_data+T*counter-not_data<size(data_signal,2))
            data_signal(start_data+T*counter) = Receive_buf(start_data+T*counter+before_data);
            data_signal(end_data+T*counter) = Receive_buf(end_data+T*counter+before_data);

%             if Receive_buf(start_data+T*counter+not_data) == 1
%                 if Receive_buf(end_data+T*counter) == 0
%                     data_signal(end_data+T*counter) = 1;
%                 end
%             else if Receive_buf(start_data+T*counter+not_data) == 0
%                     if Receive_buf(end_data+T*counter) == 1
%                         data_signal(start_data+T*counter) = 1;
%                     end
%                 end
%             end
% %         end
    end
end