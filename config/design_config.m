trialmat=nchoosek([1,2,1,2,1,2,1,2],4);
trialmat = unique(x, 'rows');

Table = [];
for i=1:length(const.SOAs)
Table=[Table; trialmat];
end

                    
const.trialmat=GenerateEventTable(conds,const.reps,isfixed)