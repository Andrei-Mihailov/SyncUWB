% Теперь выполняем модуляцию
% Элемент +1 заменяем на СШП-сигнал
% Элемент -1 заменяем на отсутствие сигнала
Signal_tmp = zeros(L_Preamble, length(Slot));
ind_3 = find(Preamble_arr > 0);
ind_4 = find(Preamble_arr < 0);
Signal_tmp(ind_3, :) = ones(length(ind_3), 1)*Slot;
switch Mod_Regim
    case 0
        Signal_tmp(ind_4, :) = ones(length(ind_4), 1)*Slot*0;
    case 1
        Signal_tmp(ind_4, :) = ones(length(ind_4), 1)*Slot*(-1);
end
% Переводим всё в строку
Signal_tmp2 = reshape(Signal_tmp', 1, size(Signal_tmp, 1)*size(Signal_tmp, 2));

% Повторим сигнал через случайный промежуток времени
Signal_tmp3 = [Signal_tmp2 zeros(1, round(100000*rand + 10))...
               Signal_tmp2 zeros(1, round(100000*rand + 10))...
               Signal_tmp2];

% Для формирования сигнала
Limit = 4*(10^6);
Limit_tmp = Limit - length(Signal_tmp3);
% Делаем случайный сдвиг сигналов
N_zeros_1 = round(rand*(Limit_tmp/2)) + round(rand*1000) + 1000;
%     N_zeros_1 = 10000 + kk*round(Period/13);%
% Добиваем размерность массив до нужной
N_zeros_2 = Limit_tmp - N_zeros_1;

Signal = [zeros(1, N_zeros_1) Signal_tmp3 zeros(1, N_zeros_2)];
