function sig = Comparator (s,data)
% преобразователь зашумленного сигнала
    sig0 = (s - 1/2);
    if data == 1
        sig = (sign(sign(sum(sig0(1:size(s,1),:)))+0.5)+1)/2;
    else
        sig = (sign(sign(sig0)+0.5)+1)/2;
    end
% FM -2
% sig = (sign(sign(sum(s(1:2,:)))+0.5)+1)/2;

end