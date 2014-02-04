function [ conf, sober_results, drunk_results ] = classify_random( sober, drunk, num, flag )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%split into test and training
len = size(sober,1);
[trainInd, ~, testInd] = dividerand(len,num/len,0,(len-num)/len);
sober_train = sober(trainInd,:);
sober_test = sober(testInd,:);
len = size(drunk,1);
[trainInd, ~, testInd] = dividerand(len,num/len,0,(len-num)/len);
drunk_train = drunk(trainInd,:);
drunk_test = drunk(testInd,:);

[conf, sober_results, drunk_results] = classify(sober_train,sober_test,drunk_train,drunk_test, flag);

end


