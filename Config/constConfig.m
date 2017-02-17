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
% May need adjuting based on refresh we seem to have.

const.reps=10;

%960 trials
const.numtrials=(const.primetypes*const.primeval*const.targem*const.targmorphstrength*length(const.SOAs)*const.reps);

const.ITI=2;

%% Stimulus parameters
const.background_color=[128 128 128];

const.element_sizeVal=4;
const.element_size=vaDeg2pix(const.element_sizeVal,scr);
const.stimctr=scr.mid;
const.asp=1.33
const.framewidth=100;

const.stimbot=scr.scr_sizeY;
const.stimright=scr.scr_sizeX;

const.selectRect=[0 0 10 40];
const.slidebar_xsize=const.stimright/2;
const.slidebar_ysize=10;

const.bar_xPosition=const.stimctr(1)-const.slidebar_xsize;
const.bar_yPosition=const.stimbot*0.85;


% Mask;
const.maskdur=0.2;

end
