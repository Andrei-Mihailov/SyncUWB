function [strt, flag_in, flag_impuls] = Search_Impuls(Receive_buf, x, Q, mode_search, flag_impuls, strt_old)
% осуществляет поиск информационных импульсов в принятой пачке бит (Receive_buf)
% и выставляет флаг (flag) и стартовую позицию информационных импульсов (strt)
    strt = 0;
    max_el = 0;
    flag_in = 0;
    Sum = zeros(1,Q);
    % поиск отсчетов преамбулы
    if mode_search == 0
        for Start_position = x - Q + 1 : x-2
            % нашли обе 1
            if Receive_buf(Start_position) == 1% нашли первую 1
                if Receive_buf(Start_position+1) == 1% нашли вторую 1
                    if Receive_buf(Start_position+2) == 0% последний символ 0
                        flag_in = 1;% поставили флаг
                        strt = Start_position;% полагаем что импульс начинается отсюда
                        break;
                    end
                end
            else if  Receive_buf(Start_position) == 0% первый символ 0
                    if Receive_buf(Start_position+1) == 1% нашли первую 1
                        if Receive_buf(Start_position+2) == 1% нашли вторую 1
                            flag_in = 1;% поставили флаг
                            strt = Start_position+1;% полагаем что импульс начинается отсюда
                            break;
                        end
                    end
                end
            end
            % нашли одну 1
            if Start_position - Q == strt_old
                if Receive_buf(Start_position) == 0% первый символ 0
                    if Receive_buf(Start_position+1) == 0% второй символ 0
                        if Receive_buf(Start_position+2) == 1% нашли первую 1
                            flag_in = 1;% поставили флаг
                            strt = Start_position+2;% полагаем что импульс начинается отсюда
                            break;
                        end
                    end
                else if Receive_buf(Start_position) == 1% нашли вторую 1
                         if Receive_buf(Start_position+1) == 0% второй символ 0
                             if Receive_buf(Start_position+2) == 0% последний символ 0
                                 flag_in = 1;% поставили флаг
                                 strt = Start_position-1;% полагаем что импульс начинается отсюда
                                 break;
                             end
                         end
                     end
                end
            end
        end
    end
    % синхронизация
    if mode_search == 1 % считаем сумму в каждом отсчете через Q
        for c = 0 : (x - strt_old+Q)/Q % проверяем несколько бит
            for shift = 0 : Q - 1
                if strt_old + Q*c + shift <= x
                    Sum(shift + 1) = Sum(shift + 1) + Receive_buf(strt_old + Q*c + shift);
                end
            end
        end
        if max(Sum) > 1
            for i = 1:2
                if max_el == 0;
                    max_el = 1;
                    for shift = 1 : Q
                        if Sum(max_el)<Sum(shift)
                            max_el = shift; % нашли первый отсчет максимальной суммы, т.е. это информационный отсчет
                        end
                    end
                    Sum(max_el) = 0;
                    strt = strt_old + max_el - 1;% записали указатель на него
                else
                    max_el = 1;
                    for shift = 1 : Q
                        if Sum(max_el)<Sum(shift)
                            max_el = shift;% нашли второй информ. отсчет
                        end
                    end
                    if (strt - 1 == strt_old + max_el - 1)&&(Sum(max_el) > 1)
                        strt = strt_old + max_el - 1;% переписываем указатель, если данный отсчет находится перед предыдущим
                    end
                end
            end
        else
            strt = strt_old;
        end
    end
end

