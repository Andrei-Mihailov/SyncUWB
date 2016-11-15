function Signal = Decoding(Input_sig, N_Data, Zero)
    Input_sig = Input_sig*2 - 1;
    Signal = zeros(1,N_Data);
    for i = 0 : N_Data - 1
        if sum((Input_sig(i*size(Zero,2) + 1 : i*size(Zero,2) + size(Zero,2))).*Zero) > 0
            Signal(i + 1) = 0;
        else 
            Signal(i + 1) = 1;
        end
    end
end