clear
close all
clc

N_bit = 10^3;
% Количество единичных отсчётов на обном бите
N1 = 2;
% Количество нулевых отсчётов на одном бите
N0 = 8;
% Отношение сигнал-шум
SNR_arr = [0:10];

N_Average = 100;
Error_Prob_arr = zeros(1, length(SNR_arr));
for SNR = SNR_arr
    for i_Average = 1 : N_Average
        Bit_arr = unidrnd(2, 1, N_bit) - 1;
        Mod_arr = Bit_arr*2 - 1;

        Signal_TX = [];
        for ii = 1 : N1
            Signal_TX = [Signal_TX; Mod_arr];
        end
        for ii = 1 : N0
            Signal_TX = [Signal_TX; Mod_arr*0];
        end

        % Всего отсчётов (N0 + N1)
        % из них отсчётов, что переносят информацию - N1
        Signal_awgn = awgn(Signal_TX, SNR - 10*log10(N0 + N1) + 10*log10(N1), 'measured');

        Rec_Bit_arr = (sign(sign(sum(Signal_awgn(1:2, :))) + 0.5) + 1)/2;

        [~, Error_Prob_tmp] = biterr(Bit_arr, Rec_Bit_arr);
        Error_Prob_arr(SNR == SNR_arr) = Error_Prob_arr(SNR == SNR_arr) + Error_Prob_tmp;
    end
end

Error_Prob_arr = Error_Prob_arr/N_Average;

figure
semilogy(SNR_arr, Error_Prob_arr, 'ob');
hold on;
semilogy(SNR_arr, berawgn(SNR_arr + 3,'fsk', 2, 'coherent'), '-r');
hold off;
grid on;