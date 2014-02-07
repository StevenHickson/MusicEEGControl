function [ B ] = ConvertToFFT( A )
%Convert to fft
length = size(A,1);
%length = length - 10;
B = A;
for i=10:length
   B(i-9:i,:) = fft(A(i-9:i,:)); 
end
B = B(1:length,:);
end