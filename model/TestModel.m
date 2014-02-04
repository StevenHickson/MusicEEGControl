function [ conf, sober_results, drunk_results ] = TestModel( sober_test, drunk_test, m1, m2, s1, s2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
epsilon = 0.000001;
%faster and techincally better but somehow gives me worse results I think
% [s1, s1_inv] = FixCovAndGetInv(s1);
% [s2, s2_inv] = FixCovAndGetInv(s2);
s1_inv = pinv(s1);
s2_inv = pinv(s2);

lndet_sober = log(det(s1) + epsilon);
lndet_drunk = log(det(s2) + epsilon);
conf = zeros(2,2);
length = size(sober_test,1);
sober_results = zeros(1,length);
for i=1:length
    tmp = sober_test(i,:) - m1;
    g1 = -0.5 * (tmp * s1_inv * tmp') + log(0.5) + -3*log(2*3.14159256) - 0.5 * lndet_sober;
    tmp = sober_test(i,:) - m2;
    g2 = -0.5 * (tmp * s2_inv * tmp') + log(0.5) + -3*log(2*3.14159256) - 0.5 * lndet_drunk;
    decision = g1 - g2;
    if(decision > 0)
        conf(1,1) = conf(1,1) + 1;
        sober_results(i) = 1;
    else
        conf(1,2) = conf(1,2) + 1;
        sober_results(i) = 2;
    end
end

length = size(drunk_test,1);
drunk_results = zeros(1,length);
for i=1:length
    tmp = drunk_test(i,:) - m1;
    g1 = -0.5 * (tmp * s1_inv * tmp') + log(0.5) + -3*log(2*3.14159256) - 0.5 * lndet_sober;
    tmp = drunk_test(i,:) - m2;
    g2 = -0.5 * (tmp * s2_inv * tmp') + log(0.5) + -3*log(2*3.14159256) - 0.5 * lndet_drunk;
    decision = g1 - g2;
    if(decision > 0)
        conf(2,1) = conf(2,1) + 1;
        drunk_results(i) = 2;
    else
        conf(2,2) = conf(2,2) + 1;
        drunk_results(i) = 1;
    end
end

end

