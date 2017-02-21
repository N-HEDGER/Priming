function runTrials(scr,const,Trialevents,my_key,text)
% ----------------------------------------------------------------------
% runTrials(scr,const,Trialevents,my_key,text)
% ----------------------------------------------------------------------
% Goal of the function :
% Launch each trial, instructions and connection with eyelink
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% my_key : structure containing keyboard configurations
% Trialevents: structure containing trial events
% text: structure containing text config.
% ----------------------------------------------------------------------
% Output(s):
% none
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : priming

% ----------------------------------------------------------------------

% Save all config at start of the block
% -------------------------------------
% config.scr = scr; config.const = const; config.Trialevents = Trialevents; config.my_key = my_key;
% save(const.exp_file_mat,'config');
%% Make all textures
% Masks
Masks=load('masks.mat');
Masks=Masks.noiseim;
for t=1:length(Masks)
    Masks2{t}=imresize(im2uint8(Masks{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.Masktex{t}=Screen('MakeTexture', scr.main,Masks2{t});
end

% Frame
  Frametex=im2uint8(randn(const.element_size+const.framewidth,round(const.element_size*const.asp)+const.framewidth));
  const.tex.Frametex=Screen('MakeTexture', scr.main,Frametex);
  const.tex.Greytex=Screen('MakeTexture', scr.main, im2uint8(repmat(0.5,const.element_size,const.element_size*round(const.asp))));
  const.awrect=CenterRect(const.baseBar, scr.rect);
% Define Rects
[const.framerect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp)+const.framewidth const.element_size+const.framewidth], scr.rect)
[const.maskrect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp) const.element_size], scr.rect)


%% Experimental loop

log_txt=sprintf(text.formatSpecStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
Trialevents.elapsed=cell(1,length(Trialevents.trialmat));
Trialevents.awResp=zeros(1,length(Trialevents.trialmat));
Trialevents.AFCresp=cell(1,length(Trialevents.trialmat));

 for i = 1:4;

    % Run single trial
   [Trialevents] = runSingleTrial(scr,const,Trialevents,my_key,text,i);

    WaitSecs(const.ITI);
%     log_txt = sprintf('trial %i stopped at %f',t-1,GetSecs);
%     fprintf(const.log_text_fid,'%s\n',log_txt);
    
end

Screen('CloseAll');

% Dont save any textures.
const.tex=[];
config.scr = scr; config.const = const; config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;
save(const.filename,'config');

% End messages
% ------------

end