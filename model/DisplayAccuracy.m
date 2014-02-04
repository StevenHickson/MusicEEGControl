function DisplayAccuracy( conf )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
accuracy = (conf(1,1) + conf(2,2)) / sum(conf(:));
display(accuracy);
end

