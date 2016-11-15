function Signal = SignalForming(Data, N_Data,Q, N0, M_seq, Zero)
    
    Data_sum = 0;
    Data_rec_sum = 0;
    L_preamble = 10^3;
    N_zeros = randi([500,1000]);
    Zeros_arr  = zeros(1, N_zeros);
    Preamble_arr  = ones(1, L_preamble);
    Data_Signal = zeros(1,size(Zero,2)*N_Data);
    
    for i = 0 : N_Data - 1
       if Data(i + 1) == 0
           Data_Signal(i*size(Zero,2) + 1 : i*size(Zero,2) + size(Zero,2)) = Zero;
       else
           Data_Signal(i*size(Zero,2) + 1 : i*size(Zero,2) + size(Zero,2)) = -1*Zero;
       end
    end
    
%         Data1 = Data*2 - 1;
%         Data2 = [Data; Data];
%         Data3 = [Data2; zeros(Q - N0, size(Data2, 2))];
    Packet_tmp = [Zeros_arr Preamble_arr M_seq Data_Signal];%полный пакет
    Packet = [Packet_tmp; Packet_tmp];%2 строки
    Signal = [Packet; zeros(Q - N0, size(Packet, 2))];% +8 строк нулей
end