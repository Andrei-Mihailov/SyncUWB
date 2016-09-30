function sig = Comparator (s)
% преобразователь зашумленного сигнала
%     sig0 = (s - 1/2);
%     sig = (sign(sign(sig0)+0.5)+1)/2;
    sig = (sign(sign(s)+0.5)+1)/2;
%     sig0 = (s - 3);
%     sig = (sign(sign(sig0)+0.5)+1)/2;
end