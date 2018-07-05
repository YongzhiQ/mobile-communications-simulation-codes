function reference_curves(EbN0)
%compute theoretical boundary
x=0:0.1:EbN0(end);
ber = qfunc(sqrt(2*10.^(0.1*x)));
semilogy(x,ber);
grid on
