function [const]=const_config(scr,const)
% ----------------------------------------------------------------------
% [scr]=scrConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define configuration relative to the screen
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% const: struct containing constant configurations
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Priming
% Version :     1.0
% ----------------------------------------------------------------------


%% Design parameters

const.primetypes=2;
% IAPS and faces.

const.primeval=2;
% Positive and negative.

const.targem=2;
% Happy, Angry

const.targmorphstrength =2;
% Low, High.

const.SOAs=[13 26 40 80 500 1000];

const.reps=10;

%960 trials
const.numtrials=(const.primetypes*const.primeval*const.targem*const.targmorphstrength*length(const.SOAs)*const.reps);




%% Stimulus parameters
const.element_sizeVal=4;
const.element_size=vaDeg2pix(const.element_sizeVal,scr);
const.stimctr=scr.mid;

end
