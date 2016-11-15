function [strt, flag_in, flag_impuls] = Search_Impuls(Receive_buf, x, Q, mode_search, flag_impuls, strt_old)
% ������������ ����� �������������� ��������� � �������� ����� ��� (Receive_buf)
% � ���������� ���� (flag) � ��������� ������� �������������� ��������� (strt)
    strt = 0;
    max_el = 0;
    flag_in = 0;
    Sum = zeros(1,Q);
    % ����� �������� ���������
    if mode_search == 0
        for Start_position = x - Q + 1 : x-2
            % ����� ��� 1
            if Receive_buf(Start_position) == 1% ����� ������ 1
                if Receive_buf(Start_position+1) == 1% ����� ������ 1
                    if Receive_buf(Start_position+2) == 0% ��������� ������ 0
                        flag_in = 1;% ��������� ����
                        strt = Start_position;% �������� ��� ������� ���������� ������
                        break;
                    end
                end
            else if  Receive_buf(Start_position) == 0% ������ ������ 0
                    if Receive_buf(Start_position+1) == 1% ����� ������ 1
                        if Receive_buf(Start_position+2) == 1% ����� ������ 1
                            flag_in = 1;% ��������� ����
                            strt = Start_position+1;% �������� ��� ������� ���������� ������
                            break;
                        end
                    end
                end
            end
            % ����� ���� 1
            if Start_position - Q == strt_old
                if Receive_buf(Start_position) == 0% ������ ������ 0
                    if Receive_buf(Start_position+1) == 0% ������ ������ 0
                        if Receive_buf(Start_position+2) == 1% ����� ������ 1
                            flag_in = 1;% ��������� ����
                            strt = Start_position+2;% �������� ��� ������� ���������� ������
                            break;
                        end
                    end
                else if Receive_buf(Start_position) == 1% ����� ������ 1
                         if Receive_buf(Start_position+1) == 0% ������ ������ 0
                             if Receive_buf(Start_position+2) == 0% ��������� ������ 0
                                 flag_in = 1;% ��������� ����
                                 strt = Start_position-1;% �������� ��� ������� ���������� ������
                                 break;
                             end
                         end
                     end
                end
            end
        end
    end
    % �������������
    if mode_search == 1 % ������� ����� � ������ ������� ����� Q
        for c = 0 : (x - strt_old+Q)/Q % ��������� ��������� ���
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
                            max_el = shift; % ����� ������ ������ ������������ �����, �.�. ��� �������������� ������
                        end
                    end
                    Sum(max_el) = 0;
                    strt = strt_old + max_el - 1;% �������� ��������� �� ����
                else
                    max_el = 1;
                    for shift = 1 : Q
                        if Sum(max_el)<Sum(shift)
                            max_el = shift;% ����� ������ ������. ������
                        end
                    end
                    if (strt - 1 == strt_old + max_el - 1)&&(Sum(max_el) > 1)
                        strt = strt_old + max_el - 1;% ������������ ���������, ���� ������ ������ ��������� ����� ����������
                    end
                end
            end
        else
            strt = strt_old;
        end
    end
end

