function [ conf ] = classify_kfold( sober, drunk, k, flag )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
len = size(sober,1);
index_sober = crossvalind('Kfold',len,k);
len = size(drunk,1);
index_drunk = crossvalind('Kfold',len,k);
conf = zeros(2,2);
for i = 1:10
    test = (index_sober == i); train = ~test;
    sober_train = sober(train,:);
    sober_test = sober(test,:);
    test = (index_drunk == i); train = ~test;
    drunk_train = drunk(train,:);
    drunk_test = drunk(test,:);
    conf = conf + classify(sober_train,sober_test,drunk_train,drunk_test, flag);
end
conf = conf / 10;
end

