function [ B ] = WhitenData( A, means, stds )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% [L, N] = size(A);
% N = N - 1;
% B = A;
% for i=1:N
%     B(:,i) = (A(:,i) - mean(A(:,i))) / std(A(:,i));
% end
[~, N] = size(A);
B = A;
for i=1:N
    B(:,i) = (A(:,i) - means(i)) / stds(i);
end
end

