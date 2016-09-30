function [S1, S2, S3] = Signal_forming(N, T)
% формирование сигнала из 1000 нулей и преамбулы длиной 1000
    zeros_s = zeros(1,10000);
    data = ones(1,1000*T);
    preamble1 = zeros(1,10*T);
     preamble2 = zeros(1,100*T);
      preamble3 = zeros(1,1000*T);
    start_pos = 0; Stop_pos = 0;
     start_pos1 = 9; Stop_pos1 = 10;
      start_pos2 = 8; Stop_pos2 = 9;
       start_pos3 = 7; Stop_pos3 = 8;
        start_pos4 = 6; Stop_pos4 = 7;
         start_pos5 = 5; Stop_pos5 = 6;
    if N == 1 
       start_pos = start_pos1; Stop_pos = Stop_pos1;
    else if N == 2 
            start_pos = start_pos2; Stop_pos = Stop_pos2;
       else if N == 3;
               start_pos = start_pos3; Stop_pos = Stop_pos3;
          else if N == 4;
                  start_pos = start_pos4; Stop_pos = Stop_pos4;
             else if N == 5;
                     start_pos = start_pos5; Stop_pos = Stop_pos5;
                 end
               end
            end
        end
    end
    % Forming Preamble
    c1 = 0;
    for x = 1:size(preamble1, 2)
        if (x - (T*c1) >= start_pos) && (x - (T*c1) <= Stop_pos)
            preamble1(1,x) = 1;
        else if x - (T*c1) > Stop_pos;
                c1 = c1 + 1;
            end
        end
    end
    c2 = 0;
    for x = 1:size(preamble2, 2)
        if (x - (T*c2) >= start_pos) && (x - (T*c2) <= Stop_pos)
            preamble2(1,x) = 1;
        else if x - (T*c2) > Stop_pos;
                c2 = c2 + 1;
            end
        end
    end
    c3 = 0;
    for x = 1:size(preamble3, 2)
        if (x - (T*c3) >= start_pos) && (x - (T*c3) <= Stop_pos)
            preamble3(1,x) = 1;
        else if x - (T*c3) > Stop_pos;
                c3 = c3 + 1;
            end
        end
    end
    % Forming Data
    d = 0;
    for x = 1:size(data, 2)
        if (x - (T*d) >= start_pos) && (x - (T*d) <= Stop_pos)
            data(1,x) = 1;
        else if x - (T*d) > Stop_pos;
                d = d + 1;
            end
        end
    end
    % Signal 
    S1 = [zeros_s preamble1  data];
    S2 = [zeros_s preamble2  data];
    S3 = [zeros_s preamble3  data];
end
