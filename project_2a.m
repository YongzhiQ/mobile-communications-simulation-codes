clear
clc
%simulation parameter setting
N = 64;
nFrame=10000;
EbN0 = 0:10;
B = zeros(length(EbN0),nFrame);
%run simulation loop
for eitr = 1:length(EbN0)
    for itr=1:nFrame
        a = randi([0,1],1,N);%sourse bit generation
        d = 1 - 2 * a;%BPSK modulation
        s = ifft(d);%transmit signal
        %through channel
%         noise_var = 1*frs/(2*10^(0.1*EbN0(eitr)));
%         white_noise = (rand(1,n)-0.5)*sqrt(12*noise_var);
%         r = s + white_noise;
        r = awgn(s,EbN0(eitr),'measured');% add noise to the signal
      
        %receiver
        ss = fft(r);
        b = real(ss)<0;
        B(eitr,itr) = sum(b ~= a);
    end
end
BER = sum(B')/(nFrame*N);
semilogy(EbN0,BER,'-*')
grid on
hold on
reference_curves(EbN0)
legend('BPSK','theoretical bound')
title('OFDM BER performance curves simualtion')