function strt = Search_Impuls(Receive_buf, x)
Start_position = x - 3;
    %����� ��� 1
    if Receive_buf(Start_position) == 1%����� ������ 1
        if Receive_buf(Start_position+1) == 1%����� ������ 1
          flag = 1;%��������� ����
          strt = Start_position;%� ��������� �� ������ 1
        end
    end
    %����� ���� 1
    if x > 2
        if Receive_buf(Start_position) == 0
            if Receive_buf(Start_position+1) == 1%����� ������ 1
              if Receive_buf(Start_position+2) == 0%� �� ����� ������ 1
                  flag = 1;%��������� ����
                  strt = Start_position+1;%�������� ��� ������� ���������� ������
              end
            end
        end
    end
end