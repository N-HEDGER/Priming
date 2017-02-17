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
    const.tex.Masktex{t}=Screen('MakeTexture', scr.main, im2uint8(Masks{t}));
end

% Frame
  const.tex.Frametex=Screen('MakeTexture', scr.main, im2uint8(randn(1000,1000)));

% Define Rects
[const.framerect,dh,dv] = CenterRect([0 0 (const.element_size*const.asp)+const.framewidth const.element_size+const.framewidth], scr.rect)
[const.maskrect,dh,dv] = CenterRect([0 0 const.element_size*const.asp const.element_size], scr.rect)


%% Experimental loop

log_txt=sprintf(text.formatSpecStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
Trialevents.elapsed=cell(1,length(Trialevents.trialmat));

 for i = 1:10;

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