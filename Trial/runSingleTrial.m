function [Trialevents]=runSingleTrial(scr,const,Trialevents,my_key,text,i)
% ----------------------------------------------------------------------
% [expDes]=runSingleTrial(scr,const,Trialevents,my_key,text,i)
% ----------------------------------------------------------------------
% Goal of the function :
% Draw stimuli of each indivual trial and collect inputs
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

% Trial-level variables;
trial.trialnum=num2str(Trialevents.trialmat(i,1));  
trial.primetype=Trialevents.trialmat(i,2);    
trial.primeval=Trialevents.trialmat(i,3);          
trial.targem =Trialevents.trialmat(i,4);           
trial.targmorphstrength=Trialevents.trialmat(i,5); 
trial.SOA=Trialevents.trialmat(i,6)/1000; 


log_txt=sprintf(text.formatSpecTrial,trial.trialnum,text.primetypelabel{trial.primetype},text.primevallabel{trial.primeval},text.targemlabel{trial.targem},text.targmorphstrengthlabel{trial.targmorphstrength});
fprintf(const.log_text_fid,'%s\n',log_txt);

    %% Drawings
    %  First mask
    Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Masktex{randi(100)},[const.maskrect]);
    M1onset=Screen('Flip',scr.main);
    % Prime Stim     
    
    %  Second mask
    Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Masktex{randi(100)},[const.maskrect]);
    M2onset=Screen('Flip',scr.main,[M1onset+trial.SOA]);
    Trialevents.elapsed{i}=M2onset-M1onset;
   
    % 2AFC target face judgement
    Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[const.maskrect]);
    DrawFormattedText(scr.main, text.AFC, scr.y_mid, scr.y_mid, WhiteIndex(scr.main),[],[]);
    Screen('Flip',scr.main,[M2onset+const.maskdur]);
    
    t1=GetSecs;
    [KeyIsDown,secs,keyCode]=KbCheck;
    while keyCode(my_key.angry)==0 && keyCode(my_key.happy)==0 && keyCode(my_key.escape)==0
        [KeyisDown,secs,keyCode]=KbCheck;
    end
    
    if keyCode(my_key.angry)==1;
        Trialevents.AFCresp{i}=1;
    elseif keyCode(my_key.happy)==1;
        Trialevents.AFCresp{i}=2;
    end
    
    Trialevents.AFCTRT{i}=secs-t1;
    SetMouse(const.awrect(1), const.awrect(2), scr.main);
    
    range=const.awrect(3)-const.awrect(1);
    rescaled=linspace(1,4,range);
    
    while 1
    %Perceptual awareness scale and slidebar elements;
    vect=round(linspace(const.awrect(1),const.awrect(3),4));
    for tick=vect
        
        tick_offset = OffsetRect(const.tick, tick, const.awrect(2)-2);
        Screen('FillRect', scr.main, const.rectColor, tick_offset);
    end
    
   for txt=1:4 
   DrawFormattedText(scr.main, text.PASlabel{txt},vect(txt)-(0.3*(vect(2)-vect(1))), const.awrect(2)-150, WhiteIndex(scr.main),[],[]);
   DrawFormattedText(scr.main, num2str(txt),vect(txt), const.awrect(2)+40, WhiteIndex(scr.main),[],[]);
   end
   
    Screen('FillRect', scr.main, const.rectColor, const.awrect);
    
    
    [mx, my, buttons] = GetMouse(scr.main);
    inside_bar = IsInRect(mx, my+1, const.awrect);
    resprect = CenterRectOnPointd(const.selectRect, mx, const.awrect(2)+1);
   
   
   Screen('FillRect', scr.main, const.blue, resprect);
   
   [KeyIsDown, endrt, KeyCode]=KbCheck;
   if KeyCode(my_key.space) && ismember(round(mx),const.awrect(1):const.awrect(3)) && sum(buttons) > 0
    Trialevents.awResp(i) = rescaled(round(mx)-const.awrect(1));
       break;
   end
   
   Screen('Flip', scr.main);
   
           if sum(buttons) <= 0
                offsetSet = 0;
           end
    end
    
    Screen('DrawTexture',scr.main,const.tex.Frametex,[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[const.maskrect]);
    Screen('Flip', scr.main);
end