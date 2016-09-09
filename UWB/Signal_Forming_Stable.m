% Генерируем информационные биты (столбец)
Bit_arr_1 = unidrnd(2, N_bits, 1) - 1;
Bit_arr_2 = unidrnd(2, N_bits, 1) - 1;
Bit_arr_3 = unidrnd(2, N_bits, 1) - 1;
Bit_arr_4 = unidrnd(2, N_bits, 1) - 1;

% Кодирование
Coded_Bit_arr_1_tmp = zeros(N_bits, L_PSP);
Coded_Bit_arr_2_tmp = zeros(N_bits, L_PSP);
Coded_Bit_arr_3_tmp = zeros(N_bits, L_PSP);
Coded_Bit_arr_4_tmp = zeros(N_bits, L_PSP);

ind_1 = find((Bit_arr_1*2 - 1) > 0);
ind_2 = find((Bit_arr_1*2 - 1) < 0);
Coded_Bit_arr_1_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_1;
Coded_Bit_arr_1_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_1*(-1);

ind_1 = find((Bit_arr_2*2 - 1) > 0);
ind_2 = find((Bit_arr_2*2 - 1) < 0);
Coded_Bit_arr_2_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_2;
Coded_Bit_arr_2_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_2*(-1);

ind_1 = find((Bit_arr_3*2 - 1) > 0);
ind_2 = find((Bit_arr_3*2 - 1) < 0);
Coded_Bit_arr_3_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_3;
Coded_Bit_arr_3_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_3*(-1);

ind_1 = find((Bit_arr_4*2 - 1) > 0);
ind_2 = find((Bit_arr_4*2 - 1) < 0);
Coded_Bit_arr_4_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_4;
Coded_Bit_arr_4_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_4*(-1);

ind_1 = find((Preamble_arr*2 - 1) > 0);
ind_2 = find((Preamble_arr*2 - 1) < 0);
Coded_Preamble_arr_1_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_1;
Coded_Preamble_arr_1_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_1*(-1);
Coded_Preamble_arr_2_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_2;
Coded_Preamble_arr_2_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_2*(-1);
Coded_Preamble_arr_3_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_3;
Coded_Preamble_arr_3_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_3*(-1);
Coded_Preamble_arr_4_tmp(ind_1, :) = ones(length(ind_1), 1)*PSP_4;
Coded_Preamble_arr_4_tmp(ind_2, :) = ones(length(ind_2), 1)*PSP_4*(-1);

Coded_Bit_arr_1 = [reshape(Coded_Preamble_arr_1_tmp', 1, L_Preamble*L_PSP)';...
                   reshape(Coded_Bit_arr_1_tmp', 1, N_bits*L_PSP)'];
Coded_Bit_arr_2 = [reshape(Coded_Preamble_arr_2_tmp', 1, L_Preamble*L_PSP)';...
                   reshape(Coded_Bit_arr_2_tmp', 1, N_bits*L_PSP)'];
Coded_Bit_arr_3 = [reshape(Coded_Preamble_arr_3_tmp', 1, L_Preamble*L_PSP)';...
                   reshape(Coded_Bit_arr_3_tmp', 1, N_bits*L_PSP)'];
Coded_Bit_arr_4 = [reshape(Coded_Preamble_arr_4_tmp', 1, L_Preamble*L_PSP)';...
                   reshape(Coded_Bit_arr_4_tmp', 1, N_bits*L_PSP)'];

Signal_tmp_1 = zeros((L_Preamble + N_bits)*L_PSP, length(Chip));
Signal_tmp_2 = zeros((L_Preamble + N_bits)*L_PSP, length(Chip));
Signal_tmp_3 = zeros((L_Preamble + N_bits)*L_PSP, length(Chip));
Signal_tmp_4 = zeros((L_Preamble + N_bits)*L_PSP, length(Chip));

ind_3 = find(Coded_Bit_arr_1 > 0);
Signal_tmp_1(ind_3, :) = ones(length(ind_3), 1)*Chip;
ind_3 = find(Coded_Bit_arr_2 > 0);
Signal_tmp_2(ind_3, :) = ones(length(ind_3), 1)*Chip;
ind_3 = find(Coded_Bit_arr_3 > 0);
Signal_tmp_3(ind_3, :) = ones(length(ind_3), 1)*Chip;
ind_3 = find(Coded_Bit_arr_4 > 0);
Signal_tmp_4(ind_3, :) = ones(length(ind_3), 1)*Chip;

Signal = 0;
Signal = Signal + reshape(Signal_tmp_1', 1, (L_Preamble + N_bits)*L_PSP*length(Chip));
Signal = Signal + reshape(Signal_tmp_2', 1, (L_Preamble + N_bits)*L_PSP*length(Chip));
Signal = Signal + reshape(Signal_tmp_3', 1, (L_Preamble + N_bits)*L_PSP*length(Chip));
Signal = Signal + reshape(Signal_tmp_4', 1, (L_Preamble + N_bits)*L_PSP*length(Chip));

tmp_arr = ones(N_Bit_Synchro, 1);
Signal_tmp = reshape(tmp_arr*Chip, 1, N_Bit_Synchro*length(Chip));

Signal = [zeros(1, 1000) Signal_tmp Signal];