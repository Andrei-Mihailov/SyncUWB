clear
close all
clc
% ������������ �������
Signal = Signal_forming (3);

%������������ �������� �0 = 2, ����� = 8, ������������ ����� ������ � = 10
T = 10;
% for i = 1:size(Signal, 2)
%     S = Signal(i);
%     if S == 0
%         Receive_Sig(i) = 0;
%     else if S == 1
%             Receive_Sig(i) = 1;
%         end
%     end
% end
y=1;
count=1;
Sum = 0;
flag = 0;
count_T = 1;
Receive_Sig = Receive_Signal(Signal, flag);
% arr = ones (1, 60);
for x = 1:size(Signal, 2)
    if flag == 1
        if x == Search_count+T*count_T
            Receive_Sig(x) = Signal(x); 
        else if x == Search_count+T*count_T + 1
                Receive_Sig(x) = Signal(x);
                 flag = 0;
            end
        end
    end
%    Search_count = Search_Impuls;
%      %����� ��� 1
%     if Receive_Sig(x) == 1%����� ������ 1
%         if Receive_Sig(x-1) == 1%����� ������ 1
%           flag = 1;%��������� ����
%           Search_count = x-1;%� ��������� �� ������ 1
%         end
%     end
%     %����� ���� 1
%     if x > 2
%         if Receive_Sig(x) == 0
%             if Receive_Sig(x-1) == 1%����� ������ 1
%               if Receive_Sig(x-2) == 0%� �� ����� ������ 1
%                   flag = 1;%��������� ����
%                   Search_count = x-2;%�������� ��� ������ ������� ���
%               end
%             end
%         end
%     end
end





