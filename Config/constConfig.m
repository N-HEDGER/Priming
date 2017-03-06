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

const.SOAs=[11.11 22.22 33.33 77.77 500 1000];
% May need adjuting based on refresh we seem to have.

const.reps=10;

%960 trials
const.numtrials=(const.primetypes*const.primeval*const.targem*const.targmorphstrength*length(const.SOAs)*const.reps);

const.ITI=2;

%% Stimulus parameters
const.background_color=[128 128 128];
const.element_con=1;
const.element_lum=1;
const.element_sizeVal=10;
const.element_size=round(vaDeg2pix(const.element_sizeVal,scr));
const.stimctr=scr.mid;
const.asp=1.33;
const.faceasp=0.69;
const.framewidth=100;

const.stimbot=scr.scr_sizeY;
const.stimright=scr.scr_sizeX;

const.selectRect=[0 0 10 40];
const.slidebar_xsize=const.stimright/2;
const.slidebar_ysize=10;

const.progbar_xsize=const.stimright;
const.progbar_ysize=10;

const.slidebar_xPosition=const.stimctr(1)-const.slidebar_xsize;
const.slidebar_yPosition=const.stimbot*0.85;
const.baseBar =[0 0  const.slidebar_xsize  const.slidebar_ysize];
const.progBar =[0 0  const.progbar_xsize  const.progbar_ysize];

const.tick = [0 0 4 10];
const.rectColor=[200 200 200];
const.selectRect = [0 0 10 40];
const.blue=[0 0 200];

const.bigfixsizeval=0.5;
const.bigfixsize=round(vaDeg2pix(const.bigfixsizeval,scr));
const.smallfixsizeval=0.25;
const.smallfixsize=round(vaDeg2pix(const.smallfixsizeval,scr));
const.bigfixcol=[0 0 0];
const.smallfixcol=[70 70 70];

% Mask;
const.maskdur=0.2;
const.fixdur=1;
const.targdur=0.5;

end
