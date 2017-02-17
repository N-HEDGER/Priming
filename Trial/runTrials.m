function runTrials(scr,const,expDes,my_key)
% ----------------------------------------------------------------------
% runTrials(scr,const,expDes,my_key)
% ----------------------------------------------------------------------
% Goal of the function :
% Launch each trial, instructions and connection with eyelink
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% expDes : struct containg experimental design
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

% Main Loop
% ---------

for t = 1:size(expDes.expMat,1);

    % Run single trial
    [Trialevents] = runSingleTrial(scr,const,Trialevents,my_key,text,t);
     
%     log_txt = sprintf('trial %i stopped at %f',t-1,GetSecs);
%     fprintf(const.log_text_fid,'%s\n',log_txt);
    
end


config.scr = scr; config.const = const; config.Trialevents = expDes; config.my_key = my_key;
save(const.exp_file_mat,'config');

% End messages
% ------------
if const.fromBlock == const.num_tot_block_pRF;instructionsIm(scr,const,my_key,'End',1,0);
else instructionsIm(scr,const,my_key,'End_block',1,0);
end

end