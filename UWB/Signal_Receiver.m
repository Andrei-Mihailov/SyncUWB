% ����

% ������� ������ ���� �� ���������� ���������� � ��������� ����������
% �� ������ - ������������������ +1 � -1
% (����� 1 � 0, �� ����� �� ����� ���� ���������� � +1 � -1)
Rec_Signal_After_Analog_Correlation_And_Porog = zeros(Limit, 1);
for kk = 1 : length(Signal) - 100
    tmp = sign(sign(sum(Signal(kk : kk + length(Chip) - 1).*Chip) - Porog) + 0.5);
    Rec_Signal_After_Analog_Correlation_And_Porog(kk) = tmp;
end