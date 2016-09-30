clear
close all
clc

N_zeros = 10^3;
L_preamble = 10^3;
N_Data = 10^3;
Q = 10;
N0 = 2;
N_SNR = 15;
Zeros_arr  = zeros(1, N_zeros);
Preamble_arr  = ones(1, L_preamble);
N_Average = 1000;
Error_Prob = zeros(1,N_SNR);
Noise_signal = zeros(1,31000);
Receive_Sig = zeros(1,31000);
c1 = 0;

for SNR = 1 : N_SNR
    for i_Average = 1 : N_Average
        Data_sum = 0;
        Data_rec_sum = 0;
        Data = unidrnd(2, 1, N_Data)-1;%массив рандомных данных
        Packet_tmp = [Zeros_arr Preamble_arr Data];%полный пакет

        Packet = [Packet_tmp; Packet_tmp];%2 строки
        Packet1 = [Packet; zeros(Q - N0, size(Packet, 2))];% +8 строк нулей

        Signal = reshape(Packet1, 1, size(Packet1, 1)*size(Packet1, 2));% перевод в строку
        Signal1 = [Signal zeros(1, 1000)];%+1к нулей
        Signal1(~Signal1) = -1;
        
        A =10*log10(N0);
        Noise_signal = zeros(1,size(Signal1,2));
        Noise_signal(1,1:end) = awgn(Signal1,SNR - 10,'measured');
        
        Receive_Sig = zeros(1,size(Noise_signal,2));
        Receive_Sig(1,1:end) = Receive_Signal(Noise_signal(1,1:end), Q, 1000);
        
% subplot(3,1,1);plot(Noise_signal, '-c'); xlabel('Noise_signal');
% subplot(3,1,2);plot(Receive_Sig, '-b'); xlabel('Signal');
% subplot(3,1,3);plot(Signal1, '-k'); xlabel('s');

        Data_rec_tmp = Receive_Sig(((N_zeros + L_preamble)*Q + 1) : (N_zeros + L_preamble)*Q + N_Data*Q);%выбор данных из 10к элементов
        Data_rec_tmp2 = reshape(Data_rec_tmp, Q, N_Data);%перестройка массива к виду 10 к 1000
        Data_rec = Data_rec_tmp2(1, :);%запись первой строки

        [~, Error_Prob_tmp] = biterr(Data,  Data_rec);

        Error_Prob(1,SNR) = Error_Prob(1,SNR) + Error_Prob_tmp;
    end
    Error_Prob(1,SNR) = Error_Prob(1,SNR)/N_Average;
end
save data

% load data
figure

% subplot(3,1,1);
semilogy(1:15, Error_Prob(1, :), '-k'); ylabel('Error_Prob');xlabel('SNR');
grid on
% subplot(3,1,2);semilogy(1:15, Error_Prob(2, :), '-b'); ylabel('L=100');
% subplot(3,1,3);semilogy(1:15, Error_Prob(3, :), '-c'); ylabel('L=1000');
