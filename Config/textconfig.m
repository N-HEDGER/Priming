function [text]=textConfig
% ----------------------------------------------------------------------
% [text]=textconfig
% ----------------------------------------------------------------------
% Goal of the function :
% Unify key names and define structure containing each key names
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% text : structure containing textformats
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     priming
% Version :     1.0
% ----------------------------------------------------------------------
text.formatSpecStart=('Subject started at: %s');
text.formatSpecTrial=('Trial %s Stimulus: %s');
text.formatSpecTexture=('Textures drawn at: %f');
text.formatSpecFlip=('Textures flipped at: %f');
text.formatSpecResponse=('Response made at: %f');
text.formatSpecQuit=('Subject quitted at: %s');
end