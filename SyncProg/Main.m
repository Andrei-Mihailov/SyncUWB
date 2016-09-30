clear
close all
clc
% Формирование сигнала, длительностью импульса Т0 = 2 и периодом сигнала Т = 10
T = 10;
points = 10;% количество точек для графика
iterations = 1000;% количество измерений

[Signal1,Signal2,Signal3] = Signal_forming (5, T);

% линии вероятности ошибок
N = 3;% количество сигналов
Line = zeros(N,points);
Line1 = zeros(N,N);

SNR = zeros(1,points);% уровень шумов
for s = 1:points
    SNR(s) = s-1;
end

Noise_signal1 = zeros(1,size(Signal1,2));%Lпр = 10
Noise_signal2 = zeros(1,size(Signal2,2));%Lпр = 100
Noise_signal3 = zeros(1,size(Signal3,2));%Lпр = 1000

Receive_Sig1 = zeros(1,size(Signal1,2));%Lпр = 10
Receive_Sig2 = zeros(1,size(Signal2,2));%Lпр = 100
Receive_Sig3 = zeros(1,size(Signal3,2));%Lпр = 1000

res = 0;
for Line_n = 1:N
    for snr = 1:points
        if Line_n == 1
            Signal = Signal1;
            Receive_Sig = Receive_Sig1;
            Noise_signal = Noise_signal1;
        else if Line_n == 2
                Signal = Signal2;
                Receive_Sig = Receive_Sig2;
                Noise_signal = Noise_signal2;
            else if Line_n == 3
                    Signal = Signal3;
                    Receive_Sig = Receive_Sig3;
                    Noise_signal = Noise_signal3;
                end
            end
        end
        % формирование помех и прием зашумленного сигнала
        for count = 1:iterations%Lпр = 10
            Noise_signal(1,1:end) = awgn(Signal,SNR(snr),'measured');
            Receive_Sig(1,1:end) = Receive_Signal(Noise_signal(1,1:end), T, 0);
            % рассчет точек линий от шума при фиксированной длине преамбулы
            [~, res] = biterr(Signal(size(Signal,2)-10000:end), Receive_Sig(size(Receive_Sig,2)-10000:end));
            Line(Line_n,snr) = Line(Line_n,snr) + res;
            % рассчет точек линий от длины преамбулы при фиксированном шуме
            if snr == 1
                Line1(1,Line_n) = Line1(1,Line_n) + res;
            else if snr == 5
                    Line1(2,Line_n) = Line1(2,Line_n) + res;
                else if snr == 10
                        Line1(3,Line_n) = Line1(3,Line_n) + res;
                    end
                end
            end
        end
        
        Line(Line_n,snr) = Line(Line_n,snr)/count;
        res = 0;
    end
    if Line1(1,Line_n) ~= 0
        Line1(1,Line_n) = Line1(1,Line_n)/count;
    else if Line1(2,Line_n) ~= 0
            Line1(2,Line_n) = Line1(2,Line_n)/count;
        else if Line1(3,Line_n) ~= 0
                Line1(3,Line_n) = Line1(3,Line_n)/count;
            end
        end
    end
end
save Lines
%load Lines
% Noise_signal3(1,1:end,1) = awgn(Signal3,10,'measured');
% Receive_Sig3(1,1:end,1) = Receive_Signal(Noise_signal3(1,1:end,1), T);

% Рассчет среднего значения за Х измерений




% графики вероятности ошибки от SNR при фиксированных длинах преамбулы
figure

subplot(3,1,1);semilogy(0:9, Line(1, :), '-k'); ylabel('L=10');
subplot(3,1,2);semilogy(0:9, Line(2, :), '-b'); ylabel('L=100');
subplot(3,1,3);semilogy(0:9, Line(3, :), '-c'); ylabel('L=1000');

% subplot(3,1,1);plot(0:9, Line(1), '-k'); ylabel('L=10');
% subplot(3,1,2);plot(0:9, Line(2), '-b'); ylabel('L=100');
% subplot(3,1,3);plot(0:9, Line(3), '-c'); ylabel('L=1000');

% subplot(3,4,2);plot(Receive_Sig1, '-k'); xlabel(['Receive Signal 1 SNR=' num2str(SNR1)]);
% subplot(3,4,6);plot(Receive_Sig2, '-b'); xlabel('Receive Signal 2 SNR=0');
% subplot(3,4,10);plot(Receive_Sig3, '-c'); xlabel('Receive Signal 3 SNR=0');
% 
% subplot(3,4,3);plot(Receive_Sig1_2, '-k'); xlabel('Receive Signal 1 SNR=5');
% subplot(3,4,7);plot(Receive_Sig2_2, '-b'); xlabel('Receive Signal 2 SNR=5');
% subplot(3,4,11);plot(Receive_Sig3_2, '-c'); xlabel('Receive Signal 3 SNR=5');
% 
% subplot(3,4,4);plot(Receive_Sig1_3, '-k'); xlabel('Receive Signal 1 SNR=10');
% subplot(3,4,8);plot(Receive_Sig2_3, '-b'); xlabel('Receive Signal 2 SNR=10');
% subplot(3,4,12);plot(Receive_Sig3_3, '-c'); xlabel('Receive Signal 3 SNR=10');

hold on;

% графики вероятности ошибки от длины преамбулы при фиксированных SNR
% Line = zeros(N,N);
% for Line_n = 1:N
%     if Line_n == 1
%         Signal = Signal1;
%         Receive_Sig = Receive_Sig1;
%         SNR_i = 1;
%     else if Line_n == 2
%             Signal = Signal2;
%             Receive_Sig = Receive_Sig2;
%             SNR_i = 5;
%         else if Line_n == 3
%                 Signal = Signal3;
%                 Receive_Sig = Receive_Sig3;
%                 SNR_i = 9;
%             end
%         end
%     end
%     for Line_n1 = 1:N
%         for i = 1:iterations
%             [num, res(i)] = Probability(Signal, Receive_Sig, i,SNR_i);
%             Line(Line_n,Line_n1) = Line(Line_n,Line_n1) + res(i);
%         end
%         Line(Line_n,Line_n1) = Line(Line_n,Line_n1)/i;
%         res = 0;
%     end
% 
% end

figure 

subplot(3,1,1);semilogx([10 100 1000],Line1(1, :), '-k'); ylabel('SNR=0');
subplot(3,1,2);semilogx([10 100 1000],Line1(2, :), '-b'); ylabel('SNR=5');
subplot(3,1,3);semilogx([10 100 1000],Line1(3, :), '-c'); ylabel('SNR=9');

% subplot(3,4,2);plot(Receive_Sig1, '-k'); xlabel('Receive Signal 1 L=100');
% subplot(3,4,3);plot(Receive_Sig2, '-b'); xlabel('Receive Signal 2 L=1000');
% subplot(3,4,4);plot(Receive_Sig3, '-c'); xlabel('Receive Signal 3 L=10000');
% 
% subplot(3,4,6);plot(Receive_Sig1_2, '-k'); xlabel('Receive Signal 1 L=100');
% subplot(3,4,7);plot(Receive_Sig2_2, '-b'); xlabel('Receive Signal 2 L=1000');
% subplot(3,4,8);plot(Receive_Sig3_2, '-c'); xlabel('Receive Signal 3 L=10000');
% 
% subplot(3,4,10);plot(Receive_Sig1_3, '-k'); xlabel('Receive Signal 1 L=100');
% subplot(3,4,11);plot(Receive_Sig2_3, '-b'); xlabel('Receive Signal 2 L=1000');
% subplot(3,4,12);plot(Receive_Sig3_3, '-c'); xlabel('Receive Signal 3 L=10000');

