load Mseq_data

% load data
figure

% subplot(3,1,1);
semilogy(SNR_arr, Error_Prob, '-k'); ylabel('Error_Prob');xlabel('SNR');
hold on
semilogy(SNR_arr, count_prob, '-b');
hold off
grid on
