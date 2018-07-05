clear
clc
%simulation parameter setting
A = 1;
f0 = 2;
fs = 32;
rs = 1;
n = 32;
frs = fs/rs;
nFrame=10000;
EbN0 = 0:1:10;
B = zeros(length(EbN0),nFrame);
ii = 0:n-1;
timeOffset = 0;
%run simulation loop
for eitr = 1:length(EbN0)
    for itr=1:nFrame
        a=rand>0.5;%sourse bit generation
        d = 1-2*a;%BPSK modulation
        rd = ones(1,32)*d;%resample
        md = A*cos(2*pi*(ii + timeOffset)*f0/fs);
        s = rd.*md;%transmit signal
        %through channel
        noise_var = 0.25*frs/(10^(0.1*EbN0(eitr)));
        white_noise = (rand(1,n)-0.5)*sqrt(12*noise_var);
        r = s + white_noise;
%         r = awgn(s,EbN0(eitr));%need modefied later here
      
        %receiver
        ss = fft(r);
        b = real(ss(3))<0;
        if a~=b
            B(eitr,itr) = 1;
        end
    end
end
BER = sum(B')/nFrame;
semilogy(EbN0,BER)
grid on
