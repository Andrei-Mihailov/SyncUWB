clear
close all
clc

start_time = tic;

% �������� ���������� � ������
Consts_and_Tables;
% ������������ ����� �������� � �����
Chip_Forming;

for i_Average = 1 : N_Average_Error_Prob
    disp(['i_Average = ' num2str(i_Average) ' / ' num2str(N_Average_Error_Prob)]);
    %������������ �������
    Signal_Forming;
    % �������� ������
    % Show_BigSignal;
    % ����� ��������
    SNR = 1000;
    Channel;
    % ����
    Signal_Receiver;
end