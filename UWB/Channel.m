Signal = Signal + sqrt(0.5*Fd*Eb/(10^(SNR/10)))*randn(size(Signal, 1), size(Signal, 2));
% Signal = Signal + sqrt(Fd*Eb/(10^(SNR/10)))*randn(size(Signal, 1), size(Signal, 2));
% Signal = awgn(Signal, SNR + 3, 'measured');