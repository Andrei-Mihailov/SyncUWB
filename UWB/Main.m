clear
close all
clc

start_time = tic;

% Загрузка переменных и таблиц
Consts_and_Tables;
% Формирование формы импульса и слота
Chip_Forming;

for i_Average = 1 : N_Average_Error_Prob
    disp(['i_Average = ' num2str(i_Average) ' / ' num2str(N_Average_Error_Prob)]);
    %Формирование сигнала
    Signal_Forming;
    % Показать сигнал
    % Show_BigSignal;
    % Канал передачи
    SNR = 1000;
    Channel;
    % Приём
    Signal_Receiver;
end