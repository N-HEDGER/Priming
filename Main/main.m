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
[text] = textConfig;

% Experimental constant
% ---------------------
[const] = constConfig(scr,const);

% Experimental design
% -------------------
[Trialevents] = designConfig(const);

% Open screen window

% ------------------

Screen('Preference', 'SkipSyncTests', 1); 
[scr.main,scr.rect] = Screen('OpenWindow',scr.scr_num,const.background_color,[], scr.clr_depth,2);
Screen('BlendFunction', scr.main, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
priorityLevel = MaxPriority(scr.main);Priority(priorityLevel);

DrawFormattedText(scr.main, text.instruct, scr.x_mid, scr.y_mid, WhiteIndex(scr.main),[],[]);

% Update the display to show the instruction text:
Screen('Flip', scr.main);
KbWait
Screen('CloseAll')

% % Trial runner
% % ------------
% ListenChar(2);
% runTrials(scr,const,expDes,my_key);
% 
% % End
% % ---
% overDone(const);

end