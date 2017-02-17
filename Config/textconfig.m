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
text.formatSpecTexture=('Textures drawn at: %f');
text.formatSpecFlip=('Textures flipped at: %f');
text.formatSpecResponse=('Response made at: %f');
text.formatSpecQuit=('Subject quitted at: %s');
text.instruct=sprintf('In this experiment you will be required to make 2 responses\n Firstly you will need to indicate whether face stimuli are happy or angry\n Next you will be required to rate your perception of any preceding stimuli on a 4 point scale\n');
text.primevallabel={'positive','negative'};
text.primetypelabel={'face','IAPS'};
text.targemlabel={'anger','happy'};
text.targmorphstrengthlabel={'low','high'};
text.formatSpecTrial=('Trial %s Primetype: %s Prime valence: %s Target emotion: %s Target morph strength: %s');



end

