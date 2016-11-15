function data_signal = Receive_Data (Receive_buf, start_data)%, Q)
%прием данных
    data_signal = zeros(size(Receive_buf, 1),size(Receive_buf, 2));
    Data_TX = Comparator(Receive_buf(1:size(Receive_buf, 1),:),1);
    
    for i = 1:size(Receive_buf, 1)
        data_signal(i,:) = Data_TX(start_data:end);
    end
    
%     end_data = start_data + 1;
    
%     for counter = 0:999
% %         data_signal(start_data+Q*counter) = Receive_buf(start_data+Q*counter+before_data);
% %         data_signal(end_data+Q*counter) = Receive_buf(end_data+Q*counter+before_data);
% % 
% %         if Receive_buf(start_data+Q*counter+before_data) == 1
% %             if Receive_buf(end_data+Q*counter) == 0
% %                 data_signal(end_data+Q*counter) = 1;
% %             end
% %         else if Receive_buf(start_data+Q*counter+before_data) == 0
% %                 if Receive_buf(end_data+Q*counter) == 1
% %                     data_signal(start_data+Q*counter) = 1;
% %                 end
% %             end
% %         end
% 
%         data_signal(start_data+counter) = Data_TX(start_data+counter);
%         data_signal(end_data+counter) = Data_TX(end_data+counter);
% 
%         if Data_TX(start_data+counter) == 1
%             if Data_TX(end_data+counter) == 0
%                 data_signal(end_data+counter) = 1;
%             end
%         else if Data_TX(start_data+counter) == 0
%                 if Data_TX(end_data+counter) == 1
%                     data_signal(start_data+counter) = 1;
%                 end
%             end
%         end
%     end
end