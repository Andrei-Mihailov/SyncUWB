function [mun, ratio] = Probability(Transmit, Receive)
% считает вероятность ошибки приема сигнала

    Data_length = 9999;
    Receive_signal = Receive(size(Receive, 2) - Data_length : end);
    Transmit_signal = Transmit(size(Transmit, 2) - Data_length : end);
%     for i = 1:Data_length
%         res(i) = Transmit_signal(Transmit_signal_start + i) - Receive_signal(Receive_signal_start + i) ;
%     end

    [mun, ratio] = biterr(Transmit_signal,Receive_signal);
end
