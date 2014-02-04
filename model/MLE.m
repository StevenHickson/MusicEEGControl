%Data must be loaded first
kill

conf_7 = zeros(2,2);
conf_50 = zeros(2,2);
conf_cross = zeros(2,2);

for i=1:NUM_RUNS
conf_7 = conf_7 + classify_random(sober,drunk,10,'MLE');
conf_50 = conf_50 + classify_random(sober,drunk,50,'MLE');
conf_cross = conf_cross + classify_kfold(sober,drunk,10,'MLE');
end
conf_7 = conf_7 / NUM_RUNS;
conf_50 = conf_50 / NUM_RUNS;
conf_cross = conf_cross / NUM_RUNS;

DisplayAccuracy(conf_7);
DisplayAccuracy(conf_50);
DisplayAccuracy(conf_cross);

conf2_7 = ShowConf(conf_7);
conf2_50 = ShowConf(conf_50);
conf2_cross = ShowConf(conf_cross);