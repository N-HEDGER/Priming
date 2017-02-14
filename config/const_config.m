%Constants

const.primetypes=2;
% IAPS and faces.

const.primeval=2;
% Positive and negative.

const.targem=2;
% Happy, Angry

const.targmorphstrength =2;
% Low, High.

const.SOAs=[13 26 40 80 500 1000];

const.reps=10;

%960 trials
const.numtrials=(const.primetypes*const.primeval*const.targem*const.targmorphstrength*length(const.SOAs)*const.reps);



