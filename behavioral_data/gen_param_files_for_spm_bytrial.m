%Engine path for mac #engine.path = '/Applications/Octave-4.4.1.app/Contents/Resources/usr/Cellar/octave-octave-app_4.4.1_0/4.4.1/bin/octave'}
 
%#load all files with data
block_onsets = csvread('./processed/block_onset_time_exp.txt', 1, 0); % 1,0 sprcifies how many rows or columns to skip
%# break_onsets = csvread('./processed/break_onset_time_exp.txt' ,1,0);
block_onsets_i = csvread('./processed/block_onset_time_instr.txt', 1,0);
% #break_onsets_i = csvread('./processed/break_onset_time_instr.txt', 1, 0);
explicit_first =  csvread('./processed/explicit_first.txt', 1,1);
trial_onsets = csvread('./processed/trial_onset_time_exp.txt', 1, 0);
trial_onsets_i = csvread('./processed/trial_onset_time_instr.txt',1,0);

% #loop through each row/subject and save mat file with names, onsets and 
for i = 1:size(block_onsets, 1)

% # Explicit - Implicit orders are counterbalanced  

names{1} = 'task';
names{2} = 'explicit';
names{3} = 'implicit';

durations{1} = ones(1,24) * 20; % ; % #for trial version: ones(1,96 * 2 ) *2
durations{2} = ones(1,12) *20 ;
durations{3} = ones(1,12) *20 ;

if explicit_first(i)

  sess1 = block_onsets_i(i, 2:end);
  sess2 = block_onsets(i, 2:end);
  sess1t = trial_onsets_i(i, 1:end);
  sess2t = trial_onsets(i, 1:end);
else

  sess1 = block_onsets(i, 2:end);
  sess2 = block_onsets_i(i, 2:end);
  sess1t = trial_onsets(i, 1:end);
  sess2t = trial_onsets_i(i, 1:end);
  names{3} = 'explicit';
  names{2} = 'implicit';
end
  
  onsets{1} =  [sess1t (sess2t + (20 + sess1(end)))];    % #[sess1 (sess2 + (20 + sess1(end)))] ; 
  onsets{2} = sess1;
  onsets{3} = (sess2 + (20 + sess1(end)));
 

  
save(['param_files/',num2str(block_onsets(i,1)), '_', 'tr_model_par.mat'], 'names', 'durations', 'onsets', '-mat7-binary')

end

