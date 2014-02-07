function [ means, stds ] = GetMeansStds( A )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[~, N] = size(A);
means = zeros(N);
stds = zeros(N);
for i=1:N
    means(i) = mean(A(:,i));
    stds(i) = std(A(:,i));
end

end

