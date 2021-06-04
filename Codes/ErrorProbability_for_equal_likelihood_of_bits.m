% 
%Author: Ömer Faruk Ayd?n ID:171024002 
%
clc
clear variables
Eb = 1 %Average energy per bit is chosen 1 Joule
% 10*log10(1/N0) = [0 1 ...15]
N0 = zeros(1,16)
bit_number = 10^7 %10 million bits are sent.
for i= 0:15
 N0(i+1) = 1/(10^(i/10))
end
produced_bits = randi([0,1],1,bit_number) 
%For P(1) = P(0) = 0.5:
%Eb = 3*(A^2)*T/4 => (A^2)*T = 4/3
%Gamma = (A^2)*T/4 = 1/3
%a1 = 3*(A^2)*T/2, a2 = -(A^2)*T => a1 = 2, a2 = -4/3
%Ed = 5*(A^2)*T/2 => Ed = 10/3
%Also variance = 5*(A^2)*T*N0/4 => variance = 5*N0/3
gamma0 = 1/3
Ed = 10/3
a = zeros(1,bit_number)
index = find(produced_bits == 1) 
a(index) = 2 %a1 = 2 if bit = "1"
index = find(produced_bits == 0)
a(index) = -4/3 %a2 = -4/3 if bit = "0"
for i = 1:16
 n0 = sqrt(5.*N0(i)/3) .* randn(1,bit_number) %Desired variance achieved.
 z = a + n0
 s = zeros(1,bit_number)
 idx = z > gamma0 %Find all indexes that z > gamma0
 s(idx) = 1 
 total_error = ne(s,produced_bits) %Inequality defined if bits are different returns 1
 Pb_experimental(i) = sum(total_error) / bit_number %Probability Error Calculation
end
Pb_Analytical = qfunc(sqrt(Ed./(2*N0)))
SNR = [0:15]
semilogy(SNR,Pb_Analytical)
hold
semilogy(SNR,Pb_experimental, 'bo')
xlabel('SNR(dB)')
ylabel('Probability Error')

