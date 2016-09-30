function [strt, flag_in, flag_impuls] = Search_Impuls(Receive_buf, x, mode_search, flag_impuls)
% осуществляет поиск информационных импульсов в принятой пачке бит (Receive_buf)
% и выставляет флаг (flag) и стартовую позицию информационных импульсов (strt)
    find_impuls_count = 0;
    strt = 0;
    Start_position = x - 3;
    flag_in = 0;
    
    if mode_search == 0%поиск импульсов преамбулы
        % нашли обе 1
        if Receive_buf(Start_position) == 1% нашли первую 1
            if Receive_buf(Start_position+1) == 1% нашли вторую 1
                if Receive_buf(Start_position+2) == 0% последний символ 0
                    flag_in = 1;% поставили флаг
                    strt = Start_position;% полагаем что импульс начинается отсюда
                end
            end
        else if  Receive_buf(Start_position) == 0% первый символ 0
                if Receive_buf(Start_position+1) == 1% нашли первую 1
                    if Receive_buf(Start_position+2) == 1% нашли вторую 1
                        flag_in = 1;% поставили флаг
                        strt = Start_position+1;% полагаем что импульс начинается отсюда
                    end
                end
            end
            if find_impuls_count < 5
                find_impuls_count = find_impuls_count + 1;
            end
        end
        % нашли одну 1
        if Receive_buf(Start_position) == 0% первый символ 0
            if Receive_buf(Start_position+1) == 0% второй символ 0
                if Receive_buf(Start_position+2) == 1% нашли первую 1
                    flag_in = 1;% поставили флаг
                    strt = Start_position+2;% полагаем что импульс начинается отсюда
                end
            end
        else if Receive_buf(Start_position) == 1% нашли вторую 1
                 if Receive_buf(Start_position+1) == 0% второй символ 0
                     if Receive_buf(Start_position+2) == 0% последний символ 0
                         flag_in = 1;% поставили флаг
                         strt = Start_position-1;% полагаем что импульс начинается отсюда
                     end
                 end
             end
        end
        % нашли две "1" более 3 раз
%         if find_impuls_count > 3
%             if strt1 == 0
%                 strt1 = strt;
%                 find_impuls_count = 0;
%             else if strt1 ~= 0
%                     strt2 = strt;
%                 end
%             end
%         end
    else if mode_search == 1%поиск импульсов данных
            if flag_impuls == 0
                if Receive_buf(x) == 1%нашли первую 1
                   flag_impuls = 1;%установили флаг 
                end
            else if flag_impuls == 1
                    if Receive_buf(x) == 1%нашли вторую 1
                        flag_in = 1;%установили флаг обозначающий нахождение импульса
                        strt = x - 1;
                        flag_impuls = 0;%сбросили флаг
                    end
                end
            end
        else if mode_search == 2%поиск импульсов данных после обработки
                if flag_impuls == 0
                   
                else if flag_impuls == 1
                        
                    end
                end
            end
        end
    end
end

