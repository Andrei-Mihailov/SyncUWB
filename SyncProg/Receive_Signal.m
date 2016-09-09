function s = Receive_Signal(Signal)
    count = 0;
    if flag == 0
        for x = 1:size(Signal, 2)
            if count == 3
                count=0;
                s(x) = 0;
                Search_Impuls(s, x);
            else if count < 3
                   count=count+1;
                   s(x) = Signal(x); 
                end
            end
        end
    else if flag == 1
             if x == strt+T*count_T
                s(x) = Signal(x); 
             else if x == strt+T*count_T + 1
                    s(x) = Signal(x);
                    flag = 0;
                 end
             end
        end
    end
end



