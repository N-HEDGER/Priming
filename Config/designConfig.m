function [Trialevents]=designConfig(const)
% ----------------------------------------------------------------------
% [const]=designConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Create trialevents and store in matrix;
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% Trialevents: struct containing trialevents
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Prming
% Version :     1.0
% ----------------------------------------------------------------------

% Define all possible combnations of the variables with 2 levels
% (primetypes,primevalence,targem,targmorphstrength)


trialmat=nchoosek([1,2,1,2,1,2,1,2],4);
trialmat = unique(trialmat, 'rows');

Table = [];
for i=1:length(const.SOAs)
Table=[Table; shoveonend(trialmat,const.SOAs(i))];
end

                    
Trialevents.trialmat=GenerateEventTable(Table,const.reps,const.isfixed);