%LoadALLBrainwaveData
%clear
kill
NUM_RUNS = 100;
file1 = tdfread('good_music_parsed.txt',',');
%split into classes
sober = [ file1.M, file1.A, file1.D, file1.T, file1.LA, file1.HA, file1.LB, file1.HB, file1.LG, file1.MG, file1.PS ];
file2 = tdfread('bad_music_parsed.txt',',');
%split into classes
drunk = [ file2.M, file2.A, file2.D, file2.T, file2.LA, file2.HA, file2.LB, file2.HB, file2.LG, file2.MG, file2.PS ];

%get rid of bad data
%sober = WhitenData(sober);
%drunk = WhitenData(drunk);
sober = sober(sober(:,11) == 0, :);
drunk = drunk(drunk(:,11) == 0, :);
sober = sober(:,1:10);
drunk = drunk(:,1:10);

file1 = tdfread('good_music.txt',',');
%split into classes
sober2 = [ file1.M, file1.A, file1.D, file1.T, file1.LA, file1.HA, file1.LB, file1.HB, file1.LG, file1.MG ];
file2 = tdfread('bad_music.txt',',');
%split into classes
drunk2 = [ file2.M, file2.A, file2.D, file2.T, file2.LA, file2.HA, file2.LB, file2.HB, file2.LG, file2.MG ];

sober = [sober ; sober2];
drunk = [drunk ; drunk2];
all = [sober; drunk];
[means, stds] = GetMeansStds(all);
sober = WhitenData(sober,means,stds);
drunk = WhitenData(drunk,means,stds);