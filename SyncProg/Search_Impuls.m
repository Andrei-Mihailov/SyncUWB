function [strt, flag_in, flag_impuls] = Search_Impuls(Receive_buf, x, mode_search, flag_impuls)
% ������������ ����� �������������� ��������� � �������� ����� ��� (Receive_buf)
% � ���������� ���� (flag) � ��������� ������� �������������� ��������� (strt)
    find_impuls_count = 0;
    strt = 0;
    Start_position = x - 3;
    flag_in = 0;
    
    if mode_search == 0%����� ��������� ���������
        % ����� ��� 1
        if Receive_buf(Start_position) == 1% ����� ������ 1
            if Receive_buf(Start_position+1) == 1% ����� ������ 1
                if Receive_buf(Start_position+2) == 0% ��������� ������ 0
                    flag_in = 1;% ��������� ����
                    strt = Start_position;% �������� ��� ������� ���������� ������
                end
            end
        else if  Receive_buf(Start_position) == 0% ������ ������ 0
                if Receive_buf(Start_position+1) == 1% ����� ������ 1
                    if Receive_buf(Start_position+2) == 1% ����� ������ 1
                        flag_in = 1;% ��������� ����
                        strt = Start_position+1;% �������� ��� ������� ���������� ������
                    end
                end
            end
            if find_impuls_count < 5
                find_impuls_count = find_impuls_count + 1;
            end
        end
        % ����� ���� 1
        if Receive_buf(Start_position) == 0% ������ ������ 0
            if Receive_buf(Start_position+1) == 0% ������ ������ 0
                if Receive_buf(Start_position+2) == 1% ����� ������ 1
                    flag_in = 1;% ��������� ����
                    strt = Start_position+2;% �������� ��� ������� ���������� ������
                end
            end
        else if Receive_buf(Start_position) == 1% ����� ������ 1
                 if Receive_buf(Start_position+1) == 0% ������ ������ 0
                     if Receive_buf(Start_position+2) == 0% ��������� ������ 0
                         flag_in = 1;% ��������� ����
                         strt = Start_position-1;% �������� ��� ������� ���������� ������
                     end
                 end
             end
        end
        % ����� ��� "1" ����� 3 ���
%         if find_impuls_count > 3
%             if strt1 == 0
%                 strt1 = strt;
%                 find_impuls_count = 0;
%             else if strt1 ~= 0
%                     strt2 = strt;
%                 end
%             end
%         end
    else if mode_search == 1%����� ��������� ������
            if flag_impuls == 0
                if Receive_buf(x) == 1%����� ������ 1
                   flag_impuls = 1;%���������� ���� 
                end
            else if flag_impuls == 1
                    if Receive_buf(x) == 1%����� ������ 1
                        flag_in = 1;%���������� ���� ������������ ���������� ��������
                        strt = x - 1;
                        flag_impuls = 0;%�������� ����
                    end
                end
            end
        else if mode_search == 2%����� ��������� ������ ����� ���������
                if flag_impuls == 0
                   
                else if flag_impuls == 1
                        
                    end
                end
            end
        end
    end
end

