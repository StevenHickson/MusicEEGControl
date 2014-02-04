function [ conf, sober_results, drunk_results ] = classify( sober_train, sober_test, drunk_train, drunk_test, flag )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global m1;
global m2;
global s1;
global s2;
if (strcmp(flag,'MLE'))
    %calc mu
    m1 = mean(sober_train);
    m2 = mean(drunk_train);
    %calc Sigma
    % s1 = cov(sober_train);
    % s2 = cov(drunk_train);
    %slower but better results because unbiased
    s1 = SpecialCov(sober_train,m1,0);
    s2 = SpecialCov(drunk_train,m2,0);
elseif (strcmp(flag,'BE'))
    tot = [sober_train; drunk_train];
    m0 = mean(tot);
    s0 = SpecialCov(tot,m0,1);
    [m1, s1] = CalcGaussianPDFDist(sober_train,m0,s0);
    [m2, s2] = CalcGaussianPDFDist(drunk_train,m0,s0);
else
    fprintf('ERROR, invalid flag\n');
    return;
end

[ conf, sober_results, drunk_results ] = TestModel(sober_test,drunk_test,m1,m2,s1,s2);

end

