%LoadBrainwaveData
clear
kill
NUM_RUNS = 100;
file1 = tdfread('good_music.txt',',');
%split into classes
sober = [ file1.M, file1.A, file1.D, file1.T, file1.LA, file1.HA, file1.LB, file1.HB, file1.LG, file1.MG ];
file2 = tdfread('bad_music.txt',',');
%split into classes
drunk = [ file2.M, file2.A, file2.D, file2.T, file2.LA, file2.HA, file2.LB, file2.HB, file2.LG, file2.MG ];

%get rid of bad data
%sober = WhitenData(sober);
%drunk = WhitenData(drunk);