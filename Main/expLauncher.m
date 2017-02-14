%% General experimenter launcher %%
%  =============================  %
% By :      Nicholas Hedger
% Project :  Priming
% With :    Adams/Graf
% Version:  1.0

% First settings
% --------------
clear all;clear mex;clear functions;close all;home;ListenChar(1);

% Desired screen settings
% -----------------------
const.desiredFD     = 90;                  % Desired refresh rate
const.desiredRes    = [1280,1024];          % Desired resolution

% Path
% ----
dir = (which('expLauncher'));cd(dir(1:end-18));

% Add Matlab path
% ---------------
addpath('Config','Main','Stim','Trial','Data','Conversion','Misc');

% Subject configuration
% ---------------------
[const] = sbjConfig(const);

% Main run:
% ---------
main(const);

