function [Trialevents]=runSingleTrial(scr,const,Trialevents,my_key,text,i)
% ----------------------------------------------------------------------
% [expDes]=runSingleTrial(scr,const,expDes,my_key,t)
% ----------------------------------------------------------------------
% Goal of the function :
% Draw stimuli of each indivual trial and waiting for inputs
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% my_key : structure containing keyboard configurations
% Trialevents: structure containing trial events
% text: structure containing text config.
% i: the trial number
% ----------------------------------------------------------------------
% Output(s):
% Trialevents : struct containing all the variable design configurations
% with data appended.
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     priming

%% Prepare stimuli
%  ---------------

trial.trialnum=num2str(Trialevents.trialmat(i,1));  
trial.primetype=Trialevents.trialmat(i,2);    
trial.primeval=Trialevents.trialmat(i,3);          
trial.targem =Trialevents.trialmat(i,4);           
trial.targmorphstrength=Trialevents.trialmat(i,5); 
trial.SOA=Trialevents.trialmat(i,6)/1000; 


log_txt=sprintf(text.formatSpecTrial,trial.trialnum,text.primetypelabel{trial.primetype},text.primevallabel{trial.primeval},text.targemlabel{trial.targem},text.targmorphstrengthlabel{trial.targmorphstrength});
fprintf(const.log_text_fid,'%s\n',log_txt);


%% Main clock
    %  ----------
    %% Drawings
    %  --------
   Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
   Screen('DrawTexture',scr.main,const.tex.Masktex{randi(100)},[const.maskrect]);
   M1onset=Screen('Flip',scr.main);
    Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
   Screen('DrawTexture',scr.main,const.tex.Masktex{randi(100)},[const.maskrect]);
   M2onset=Screen('Flip',scr.main,[M1onset+trial.SOA]);
   Trialevents.elapsed{i}=M2onset-M1onset;
   Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
   Screen('Flip',scr.main,[M2onset+const.maskdur]);
    
end