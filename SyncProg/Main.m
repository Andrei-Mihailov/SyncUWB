clear
close all
clc

load Mseq % = (mseq(2,5,2,2)+1)/2;

Q = 10;
N0 = 2;
N_SNR = 15;
N_Data = 10^3;
SNR_arr = [0 : 1 : 15];
count_prob = zeros(1,size(SNR_arr,2));
N_Average = 10000;
start_data_prob = 0;
Error_Prob = zeros(1,size(SNR_arr,2));
X_32 = [1 -1 1 -1 1 -1 1 -1 ...
        1 -1 1 -1 1 -1 1 -1 ...
        1 -1 1 -1 1 -1 1 -1 ...
        1 -1 1 -1 1 -1 1 -1];

% Sequense_Barker = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];

for SNR = SNR_arr
    for i_Average = 1 : N_Average
        Data = unidrnd(2, 1, N_Data)-1;%массив рандомных данных
        Signal = SignalForming(Data, N_Data, Q, N0, M_seq, X_32);

        Noise_signal = awgn(Signal,SNR-10*log10(Q)+10*log10(N0)+10*log10(32/2),'measured');
%         Data_rec = Comparator(Noise_signal(1:2,size(Noise_signal,1)-size(Data,1)+1:end),1);%только для данных
%         Data_rec = Comparator(Noise_signal(1:2,:),-1);%fm2
        

        % синхронизация и прием сигнала
        
%         Receive_Sig = Receive(Noise_signal, Q,N_Data,L_preamble);
%         Receive_Data = Receive_Sig(:,2001:end);

        [Receive_Data, start_data, count_pack] = ReceiveByChar(Noise_signal, Q, N_Data, M_seq, X_32);
       
        if sum(sum(Receive_Data,2)) ~= 0
            Data_rec_med = Comparator(Receive_Data(1:2,:),1);
            Data_rec = Decoding(Data_rec_med, N_Data, X_32);
        

%         Data_rec_tmp = Receive_Sig(((N_zeros + L_preamble)*Q + 1) : (N_zeros + L_preamble)*Q + N_Data*Q);%выбор данных из 10к элементов
%         Data_rec_tmp2 = reshape(Data_rec_tmp, Q, N_Data);%перестройка массива к виду 10 к 1000
%         Data_rec = Data_rec_tmp2(1, :);%запись первой строки

            [~, Error_Prob_tmp] = biterr(Data,  Data_rec);
            Error_Prob(SNR == SNR_arr) = Error_Prob(SNR == SNR_arr) + Error_Prob_tmp;
    %         start_data_prob = start_data_prob + start_data;
            count_prob(SNR == SNR_arr) = count_prob(SNR == SNR_arr) + count_pack;
        end
    end
    Error_Prob(SNR == SNR_arr) = Error_Prob(SNR == SNR_arr)/count_prob(SNR == SNR_arr);% помехоустойчивость
end
% start_data_prob = start_data_prob/N_Average/16;
count_prob = 1 - count_prob/N_Average;% количество пропущенных пакетов
% Error_Prob = Error_Prob/N_Average;
save data

% load data
figure

% subplot(3,1,1);
semilogy(SNR_arr, Error_Prob, '-k'); ylabel('Error_Prob');xlabel('SNR');
hold on
semilogy(SNR_arr, count_prob, '-b');
hold off
grid on
% subplot(3,1,2);semilogy(1:15, Error_Prob(2, :), '-b'); ylabel('L=100');
% subplot(3,1,3);semilogy(1:15, Error_Prob(3, :), '-c'); ylabel('L=1000');
