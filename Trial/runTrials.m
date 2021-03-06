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
Masks=load('MasksS.mat');
Masks=Masks.noiseim;
Masks2=cell(1,length(Masks));
for t=1:length(Masks)
    Masks2{t}=imresize(im2uint8(Masks{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.Masktex{1,t}=Screen('MakeTexture', scr.main,imadjust(Masks2{t},stretchlim(Masks2{t})));
    const.tex.Masktex{2,t}=Screen('MakeTexture', scr.main,imcomplement(imadjust(Masks2{t},stretchlim(Masks2{t}))));
end


IAPS=load('IAPS.mat');
IAPS=IAPS.IAPS2;
IAPS2=cell(2,10);
IAPSsc=load('IAPSsc.mat');
IAPSsc=IAPSsc.IAPS3;
IAPSsc2=cell(2,10);

for t=1:10
 
    IAPS2{1,t}=imresize(im2uint8(IAPS{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.IAPStex{1,t}=Screen('MakeTexture', scr.main,coladjust(IAPS2{1,t},const.element_lum,const.element_con));
    
    IAPSsc2{1,t}=imresize(im2uint8(IAPSsc{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.IAPSsctex{1,t}=Screen('MakeTexture', scr.main,coladjust(IAPSsc2{1,t},const.element_lum,const.element_con));
    
end
for t=11:20
    IAPS2{2,t-10}=imresize(im2uint8(IAPS{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.IAPStex{2,t-10}=Screen('MakeTexture', scr.main,coladjust(IAPS2{2,t-10},const.element_lum,const.element_con));
    
    IAPSsc2{2,t-10}=imresize(im2uint8(IAPSsc{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.IAPSsctex{2,t-10}=Screen('MakeTexture', scr.main,coladjust(IAPSsc2{2,t-10},const.element_lum,const.element_con));
    
end


PRIMES=load('PRIMES.mat');
PRIMES=PRIMES.images;
IMMASK=imread('AlphaMask.jpg');

for t=1:10
    FACES2{1,t}=coladjust(imresize(im2uint8(PRIMES{1,t}),[const.element_size round(const.element_size*const.faceasp)]),const.element_lum,const.element_con);
    FACES2{1,t}(:,:,4)=imresize(IMMASK,[const.element_size round(const.element_size*const.faceasp)]);
    const.tex.FACEStex{1,t}=Screen('MakeTexture', scr.main,FACES2{1,t});
    FACES2{2,t}=coladjust(imresize(im2uint8(PRIMES{2,t}),[const.element_size round(const.element_size*const.faceasp)]),const.element_lum,const.element_con);
    FACES2{2,t}(:,:,4)=imresize(IMMASK,[const.element_size round(const.element_size*const.faceasp)]);
    const.tex.FACEStex{2,t}=Screen('MakeTexture', scr.main,FACES2{2,t});
end


TARGETS=load('Targets.mat');
TARGETS=TARGETS.images;

for t=1:20
    for m=1:4
        TARGETS2{m,t}=imresize(im2uint8(TARGETS{m,t}),[const.element_size round(const.element_size*const.faceasp)]);
        TARGETS2{m,t}(:,:,4)=imresize(IMMASK,[const.element_size round(const.element_size*const.faceasp)]);
        const.tex.TARGETtex{m,t}=Screen('MakeTexture', scr.main,TARGETS2{m,t});
    end
end


% Frame
  Frametex=im2uint8(randn(const.element_size+const.framewidth,round(const.element_size*const.asp)+const.framewidth));
  const.tex.Frametex=Screen('MakeTexture', scr.main,Frametex);
  const.tex.Greytex=Screen('MakeTexture', scr.main, im2uint8(repmat(0.5,const.element_size,const.element_size*round(const.asp))));
  const.awrect=CenterRect(const.baseBar, scr.rect);
  const.progrect=CenterRect(const.progBar, scr.rect)-[0 500 0 500];
% Define Rects
[const.framerect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp)+const.framewidth const.element_size+const.framewidth], scr.rect);
[const.maskrect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp) const.element_size], scr.rect);
[const.stimrect,dh,dv] = CenterRect([0 0 round(const.element_size*const.faceasp) round(const.element_size)], scr.rect);



%% Experimental loop
if const.oldsub==0
log_txt=sprintf(text.formatSpecStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
Trialevents.elapsed=cell(1,length(Trialevents.trialmat));
Trialevents.awResp=zeros(1,length(Trialevents.trialmat));
Trialevents.AFCresp=cell(1,length(Trialevents.trialmat));
Trialevents.AFCresp2=cell(1,length(Trialevents.trialmat));
Trialevents.morph=zeros(1,length(Trialevents.trialmat));

for t=1:length(Trialevents.morph)
if Trialevents.trialmat(t,4)==1 && Trialevents.trialmat(t,5)==1
    Trialevents.morph(t)=1;
elseif Trialevents.trialmat(t,4)==1 && Trialevents.trialmat(t,5)==2
    Trialevents.morph(t)=2;
elseif Trialevents.trialmat(t,4)==2 && Trialevents.trialmat(t,5)==1
    Trialevents.morph(t)=3;
elseif Trialevents.trialmat(t,4)==2 && Trialevents.trialmat(t,5)==2
    Trialevents.morph(t)=4;
end
end
else
    
log_txt=sprintf(text.formatSpecReStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
    
end

DrawFormattedText(scr.main, 'PRESS ANY KEY TO BEGIN', 'justifytomax', 100, WhiteIndex(scr.main),[],[]);
Screen('Flip', scr.main);
KbWait;

 for i = const.starttrial:length(Trialevents.trialmat);

    % Run single trial
   [Trialevents] = runSingleTrial(scr,const,Trialevents,my_key,text,i);

    WaitSecs(const.ITI);
    
config.scr = scr; config.const = rmfield(const,'tex'); config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;
save(const.filename,'config');
    
    
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