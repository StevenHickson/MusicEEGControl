function [ conf2 ] = ShowConf( conf )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    figure;
    conf2 = [conf(1,:) / (conf(1,1) + conf(1,2)); conf(2,:) / (conf(2,1) + conf(2,2))];
    imshow(conf2, 'InitialMagnification',10000)
    colormap(jet)
end

