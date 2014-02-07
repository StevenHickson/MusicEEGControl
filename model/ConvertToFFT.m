function [ B ] = ConvertToFFT( A )
%Convert to fft
length = size(A,1);
length = length - 10;
B = A;
for i=1:length
   B(i:i+10,:) = fft(A(i:i+10,:)); 
end
B = B(1:length,:);
end