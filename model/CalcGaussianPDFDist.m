function [ m, s ] = CalcGaussianPDFDist( A, m0, s0 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    L = size(A,1);
    L_inv = 1 / L;
    mn = mean(A);
    %sn = cov(A);
    sn = SpecialCov(A,mn,1);
    m = s0*pinv(s0 + L_inv*sn)*mn' + L_inv*sn*pinv(s0 + L_inv*sn)*m0';
    m = m';
    s = s0*pinv(s0 + L_inv*sn)*L_inv*sn;
    s = s';
end

