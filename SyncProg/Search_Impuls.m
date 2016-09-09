function strt = Search_Impuls(Receive_buf, x)
Start_position = x - 3;
    %нашли обе 1
    if Receive_buf(Start_position) == 1%нашли первую 1
        if Receive_buf(Start_position+1) == 1%нашли вторую 1
          flag = 1;%поставили флаг
          strt = Start_position;%и указатель на первую 1
        end
    end
    %нашли одну 1
    if x > 2
        if Receive_buf(Start_position) == 0
            if Receive_buf(Start_position+1) == 1%нашли первую 1
              if Receive_buf(Start_position+2) == 0%и не нашли вторую 1
                  flag = 1;%поставили флаг
                  strt = Start_position+1;%полагаем что импульс начинается отсюда
              end
            end
        end
    end
end