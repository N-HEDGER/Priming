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
trial.Model=Trialevents.trialmat(i,7);
trial.morph=Trialevents.morph(i);
% Print the condition details to the external file.
log_txt=sprintf(text.formatSpecTrial,trial.trialnum,text.primetypelabel{trial.primetype},text.primevallabel{trial.primeval},text.targemlabel{trial.targem},text.targmorphstrengthlabel{trial.targmorphstrength});
fprintf(const.log_text_fid,'%s\n',log_txt);
trial
const.trialsdone=trial.trialnum;

%% Drawings
    HideCursor;
    % Fixation dot;
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[],[const.maskrect]);
    Screen('DrawDots',scr.main,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
    Screen('DrawDots',scr.main,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
    Fixonset=Screen('Flip',scr.main,[],[1]);
    
    %  First mask
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Masktex{1,randi(100)},[],[const.maskrect]);
    M1onset=Screen('Flip',scr.main,[Fixonset+const.fixdur],[1]);
    % Prime Stim 
    Screen('DrawTexture',scr.main,const.tex.IAPSsctex{randi(2),randi(10)},[],[const.maskrect]);
    
    if trial.primetype==1
    Screen('DrawTexture',scr.main,const.tex.FACEStex{trial.primeval,trial.Model},[],[const.stimrect]);
    else
    Screen('DrawTexture',scr.main,const.tex.IAPStex{trial.primeval,trial.Model},[],[const.maskrect]);
    end
    primeonset=Screen('Flip',scr.main,[M1onset+const.maskdur]);  
    %  Second mask
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Masktex{2,randi(100)},[],[const.maskrect]);
    M2onset=Screen('Flip',scr.main,[primeonset+(trial.SOA-(0.011/2))]);
   
    for r=1:10
          Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Masktex{randi(2),randi(100)},[],[const.maskrect]);
    M3onset=Screen('Flip',scr.main,[]);
    end
    
    Trialevents.elapsed{i}=M2onset-primeonset;
   
    % 2AFC target face judgement
     Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
     Screen('DrawTexture',scr.main,const.tex.Greytex,[],[const.maskrect]);
    Screen('DrawTexture',scr.main,const.tex.TARGETtex{trial.morph,randi(20)},[],[const.stimrect]);
    targonset=Screen('Flip',scr.main,[M2onset+const.maskdur]);
    
    t1=GetSecs;
    [KeyIsDown,secs,keyCode]=KbCheck;
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[],[const.maskrect]);
    DrawFormattedText(scr.main, text.AFC, scr.y_mid, const.stimbot*0.5, WhiteIndex(scr.main),[],[]);
    Screen('Flip',scr.main,[targonset+const.targdur]);
    while keyCode(my_key.angry)==0 && keyCode(my_key.happy)==0 && keyCode(my_key.escape)==0
        [KeyisDown,secs,keyCode]=KbCheck;
    end
    
    if keyCode(my_key.angry)==1;
        Trialevents.AFCresp{i}=1;
    elseif keyCode(my_key.happy)==1;
        Trialevents.AFCresp{i}=2;
    elseif keyCode(my_key.escape)==1
        const.trialsdone=trial.trialnum;
        config.scr = scr; config.const = rmfield(const,'tex'); config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;
        log_txt=sprintf(text.formatSpecQuit,num2str(clock));
        fprintf(const.log_text_fid,'%s\n',log_txt);
        save(const.filename,'config');
        ShowCursor(1);
        Screen('CloseAll')
    end
    

    
    Trialevents.AFCTRT{i}=secs-t1;
    
    % 2AFC prime judgement
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[],[const.maskrect]);
    DrawFormattedText(scr.main, text.AFC2, scr.y_mid-150, const.stimbot*0.5, WhiteIndex(scr.main),[],[]);
    WaitSecs(0.5);
    Screen('Flip',scr.main,[]);
    
    [KeyIsDown,secs,keyCode]=KbCheck;
    while keyCode(my_key.angry)==0 && keyCode(my_key.happy)==0
        [KeyisDown,secs,keyCode]=KbCheck;
    end
    
    if keyCode(my_key.angry)==1;
        Trialevents.AFCresp2{i}=1;
    elseif keyCode(my_key.happy)==1;
        Trialevents.AFCresp2{i}=2;
    end
    % 2AFC face/IAPS judgement.
    
    
    % PAS response.
    %     Set Mouse to initial location.
    ShowCursor;
    SetMouse(const.awrect(1), const.awrect(2), scr.main);
    
    %     Define response range and rescale this to the 1-4 range.
    
    range=const.awrect(3)-const.awrect(1);
    rescaled=linspace(1,4,range);
    
    
    while 1
        %         Draw tickmarks
    vect=round(linspace(const.awrect(1),const.awrect(3),4));
    for tick=vect
        tick_offset = OffsetRect(const.tick, tick, const.awrect(2)-2);
        Screen('FillRect', scr.main, const.rectColor, tick_offset);
    end
    
    %     Draw PAS labels and numbers.
    for txt=1:4
        DrawFormattedText(scr.main, text.PASlabel{txt},vect(txt)-(0.3*(vect(2)-vect(1))), const.awrect(2)-150, WhiteIndex(scr.main),[],[]);
        DrawFormattedText(scr.main, num2str(txt),vect(txt), const.awrect(2)+40, WhiteIndex(scr.main),[],[]);
    end
    
    %    Draw the response bar
    Screen('FillRect', scr.main, const.rectColor, const.awrect);
    
    %     Get mouse position and determine whether or not it is in the bar.
    [mx, my, buttons] = GetMouse(scr.main);
    inside_bar = IsInRect(mx, my+1, const.awrect);
    resprect = CenterRectOnPointd(const.selectRect, mx, const.awrect(2)+1);
   
    %    Draw slider at new location
    Screen('FillRect', scr.main, const.blue, resprect);
    
    %    Mouse must be clicked, spacebar must be pressed and slider must be
    %    within response bar range.
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
    HideCursor;
    const.trialsdone=trial.trialnum;
    progvec=round(linspace(1,1280,length(Trialevents.trialmat)));
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    Screen('DrawTexture',scr.main,const.tex.Greytex,[],[const.maskrect]);
    Screen('FillRect', scr.main, const.rectColor, const.progrect);
    progbar=[0 7 progvec(str2num(const.trialsdone)) 17];
    %    Draw slider at new location
    Screen('FillRect', scr.main, const.blue, progbar);
    
    Screen('Flip', scr.main);
    
end