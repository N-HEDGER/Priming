function main(const)
% ----------------------------------------------------------------------
% main(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Launch all functions of the experiment
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing a some constant configuration
% ----------------------------------------------------------------------
% Output(s):
% none
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     priming
% Version :     1.0
% ----------------------------------------------------------------------

% Screen configurations
% ---------------------
[scr] = scrConfig(const);

% Keyboard configurations
% -----------------------
[my_key] = keyConfig;

% Text configurations
% -----------------------
[text] = textconfig;

% Experimental constant
% ---------------------
[const] = constConfig(scr,const);

% Experimental design
% -------------------
[Trialevents] = designConfig(const);

const.log_text_fid=fopen(const.txtfilename,'a+');

% Open screen window

% ------------------
Screen('Preference', 'SkipSyncTests', 1); 
[scr.main,scr.rect] = Screen('OpenWindow',scr.scr_num,const.background_color,[], scr.clr_depth,2);
Screen('BlendFunction', scr.main, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
priorityLevel = MaxPriority(scr.main);Priority(priorityLevel);
DrawFormattedText(scr.main, text.instruct, 'justifytomax', 100, WhiteIndex(scr.main),[],[]);

% Update the display to show the instruction text:
Screen('Flip', scr.main);
KbWait

% % Trial runner
% % ------------
runTrials(scr,const,Trialevents,my_key,text);
% 
% % End
% % ---
% overDone(const);

end