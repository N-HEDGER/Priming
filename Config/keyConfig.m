function [my_key]=keyConfig
% ----------------------------------------------------------------------
% [my_key]=keyConfig
% ----------------------------------------------------------------------
% Goal of the function :
% Unify key names and define structure containing each key names
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% my_key : structure containing keyboard configurations
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 27 / 11 / 2016
% Project :     pRF_threat
% Version :     1.0
% ----------------------------------------------------------------------
KbName('UnifyKeyNames');
my_key.tVal     =   't';
my_key.eVal     =   'e';
my_key.spaceVal =   ' ';
my_key.escape   =   KbName('ESCAPE');
my_key.space    =   KbName('Space');
my_key.t        =   KbName('t');            % TR
my_key.e        =   KbName('e');            % top left button in scanner

end