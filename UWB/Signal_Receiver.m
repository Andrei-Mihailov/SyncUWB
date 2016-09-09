% Приём

% Сначала сигнал идет на аналоговый коррелятор и пороговое устройство
% На выходе - последовательность +1 и -1
% (можно 1 и 0, но потом всё равно надо переводить в +1 и -1)
Rec_Signal_After_Analog_Correlation_And_Porog = zeros(Limit, 1);
for kk = 1 : length(Signal) - 100
    tmp = sign(sign(sum(Signal(kk : kk + length(Chip) - 1).*Chip) - Porog) + 0.5);
    Rec_Signal_After_Analog_Correlation_And_Porog(kk) = tmp;
end