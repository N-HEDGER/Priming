%% General experimenter launcher %%
%  =============================  %

% Sequence:
% Block 1= Neutral, stimulus.
% Block 2= Fear, fixation.
% Block 3= Neutral, fixation.
% Block 4= Fear, stimulus.
% Block 5= Neutral, stimulus.
% Block 6= Fear, fixation
% Block 7= Neutral, fixation
% Block 8= Fear, stimulus.


% 4*30
% 4*42
% 6*30
% +14
% 482;


% By :      Nicholas Hedger
% Project :  pRF_threat experiment
% With :    TOMAS KNAPEN
% Version:  1.0

% Version description
% ===================

% To do
% ======
% 1) Fix start position/ asymetry
% 2) Fix speed.
% 3) Fix image artefacts.
% 4) Fix fixation task timings


% First settings
% --------------
clear all;clear mex;clear functions;close all;home;ListenChar(1);
%fprintf(1,'\n\tExpLauncher line 9:Don''t forget to put it back before testing !!!\n');

% General settings
% ----------------
const.expName       = 'pRF_threat';         % experiment name.
const.expStart      = 1;                    % Start of a recording exp                          0 = NO   , 1 = YES
const.checkTrial    = 1;                    % Print trial conditions (for debugging)            0 = NO   , 1 = YES
const.checkFRPS     = 0;                    % Check frame rate per second (to test screen)      0 = NO   , 1 = YES
const.practice      = 0;                    % Run practice trials                               0 = NO   , 1 = YES

% External controls
% -----------------
const.scanner       = 1;                    % run with MRI scanner record                       0 = NO   , 1 = YES
const.scannerTest   = 0;                    % run with T returned at TR time                    0 = NO   , 1 = YES

% Desired screen settings
% -----------------------
const.desiredFD     = 120;                  % Desired refresh rate
const.desiredRes    = [1920,1080];          % Desired resolution

% Path
% ----
dir = (which('expLauncher'));cd(dir(1:end-18));

% Add Matlab path
% ---------------
addpath('config','main','conversion','instructions','trials','stim','stats');

% Block definition
% ----------------
if ~const.expStart
    num_run_block_colMatch          = 1;    % 1 block = 2 min in 7T scanner
    const.num_tot_block_colMatch    = 1;    % 2 min in total in 7T scanner
    num_run_block_pRF               = 1;    % 1 block = 8 min in 7T scanner
    const.num_tot_block_pRF         = 1;    % 8 min in total in 7T scanner
else
    num_run_block_colMatch          = 1;    % 1 block = 2 min in 7T scanner
    const.num_tot_block_colMatch    = 1;    % 2 min in total in 7T scanner
    num_run_block_pRF               = 1;    % 1 block = 8 min in 7T scanner
    const.num_tot_block_pRF         = 8;    % 4 repetitions x 2 fix positions => 8 x 8 min = 64 min (~1h) in total in 7T scanner
end


% Subject configuration
% ---------------------
[const] = sbjConfig(const);

% Main run:
% ---------


const.taskName = 'pRF_exp';
 toBlock_pRF = (const.fromBlock+num_run_block_pRF-1);
 if toBlock_pRF > const.num_tot_block_pRF;toBlock_pRF = const.num_tot_block_pRF;end
for block = const.fromBlock:toBlock_pRF
     const.fromBlock = block;
     main(const);clear expDes
%     plot_pRF_results(const.sjct,toBlock_pRF,const.tracker);
end
