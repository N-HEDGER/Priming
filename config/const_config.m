
%Constants

const.primetypes=2;
% IAPS and faces.

const.primeval=2;
% Positive and negative.

const.targem=2;
% Happy, Angry

const.targmorphstrength =2
% Low, High.

const.SOAs=[13 26 40 80 500 1000];

const.reps=10;

%960 trials
const.numtrials=(const.primetypes*const.primeval*const.targem*const.targmorphstrength*length(const.SOAs)*const.reps);

trialmat=nchoosek([1,2,1,2,1,2,1,2],4);
trialmat = unique(x, 'rows');

Table = [];
for i=1:length(const.SOAs)
Table=[Table; trialmat];
end

                    
const.trialmat=GenerateEventTable(conds,const.reps,isfixed)

