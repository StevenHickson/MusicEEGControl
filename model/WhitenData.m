function [ B ] = WhitenData( A )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[L, N] = size(A);
N = N - 1;
B = A;
for i=1:N
    B(:,i) = (A(:,i) - mean(A(:,i))) / std(A(:,i));
end
end

