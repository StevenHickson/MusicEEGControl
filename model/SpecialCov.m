function [ sigma ] = SpecialCov( A, mean, flag)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  [L, n] = size(A);
  %sigma = 1 / L * (A - mu) * (A - mu)'; 
  
  %this is slower than the method below and they are almost exactly the
  %same, but for some reason, the slight floating point variation in this
  %method always gives a better estimate with MLE but the same with BE. Who knows why?
  if ( flag == 0)
      sigma = zeros(n,n);
      for i=1:L
         tmp = A(i,:) - mean;
         sigma = sigma + (tmp'*tmp);  
      end
      sigma = sigma / (L - 1);
  else
      tmp = zeros(L,n);
      for i=1:n
        tmp(:,i) = A(:,i) - mean(i);
      end
      sigma = (tmp'*tmp) / (L - 1);
  end
end

