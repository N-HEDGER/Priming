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
text.formatSpecReStart=('Subject restarted at: %s');
instruct='On each trial in this experiment you will firstly be presented with an image\n between masks (brightly colored patterns)\n\n You will then required to make 3 responses\n\n 1) Firstly you will need to indicate whether a subsequent face stimulus is happy or angry as\n quicky and accurately as possible.\n\n 2) Next you will be required to make a decision about whether\n the preceding stimulus (i.e. between the masks)\n was a face, or an image of animal/animals \n\n 3) Lastly, you will be required to rate your perception of the preceding stimulus (between the masks) on a 4 point scale\n Below is a detailed description of how to use the scale:'
text.instruct=sprintf(instruct);
text.primevallabel={'negative','positive'};
text.primetypelabel={'face','IAPS'};
text.targemlabel={'anger','happy'};
text.targmorphstrengthlabel={'low','high'};
text.formatSpecTrial=('Trial %s Primetype: %s Prime valence: %s Target emotion: %s Target morph strength: %s');
text.AFC='Angry (Left) or Happy (Right)?';
text.AFC2='Preceding image of Animal(s) (Left) or Face (Right)?';
text.PASlabel={sprintf('No\n experience'),sprintf('Weak\n experience'),sprintf('Almost\n clear\n experience'),sprintf('Clear\n experience')};

end

