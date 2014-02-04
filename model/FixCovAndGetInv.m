function [ cov_fixed, cov_inv ] = FixCovAndGetInv( cov )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
epsilon = 0.0001;
[e,lam]=eig(cov);
lam = diag(diag(lam) + epsilon);
cov_fixed = e*lam*e;
cov_inv = e*diag(1./diag(lam))*e';

end

