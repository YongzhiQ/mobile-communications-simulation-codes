clear
clc
%compute theoretical boundary
x=0:0.1:8;
ber = qfunc(sqrt(2*10.^(0.1*x)));
semilogy(x,ber);
grid on
