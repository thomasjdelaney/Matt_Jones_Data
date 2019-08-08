function [mu,covmat,S] = basicstats(datastruct,cellids);
% Extract vector of mean firing rates, covariance matrix, and binary matrix
% from Matt Jones' data.

timebin = 20; % ms

FelixData = {};
F_preSleep={};
F_maze={};
F_sleep={};

% number of neurons
NumNeurons=25;

% the start and end time for the pre_sleep
tPreSleep_start = 566*(1000/timebin); % seconds
tPreSleep_end = 3262*(1000/timebin); % seconds
nt_presleep = (tPreSleep_end-tPreSleep_start);

% the start and end time for the maze
tMaze_start = 3427*(1000/timebin); % seconds
tMaze_end = 5298*(1000/timebin); % seconds
nt_maze = (tMaze_end-tMaze_start);

% the start and end time for the sleep
tSleep_start = 5593*(1000/timebin); % seconds
tSleep_end = 8358*(1000/timebin); % seconds
nt_sleep = (tSleep_end-tSleep_start);


%================

matrix_pSleep = zeros(NumNeurons,nt_presleep);
matrix_running = zeros(NumNeurons,nt_maze);
matrix_sleep = zeros(NumNeurons,nt_sleep);

mu = zeros(NumNeurons,3);

for i=1:NumNeurons
    
    FelixData{i}=round(Fcells(i+16).tspk*(1000/timebin));
    
    ind1=find(FelixData{i}>=tPreSleep_start & FelixData{i}<=tPreSleep_end);
    ind2=find(FelixData{i}>=tMaze_start & FelixData{i}<=tMaze_end);
    ind3=find(FelixData{i}>=tSleep_start & FelixData{i}<=tSleep_end);
    F_preSleep{i}=unique(FelixData{i}(ind1));
    F_maze{i}=unique(FelixData{i}(ind2));
    F_sleep{i}=unique(FelixData{i}(ind3));
    
    mu(i,1) = length(F_preSleep{i})/nt_presleep;
    mu(i,2) = length(F_maze{i})/nt_maze;
    mu(i,3) = length(F_sleep{i})/nt_sleep;
    
    matrix_pSleep(i,F_preSleep{i}-tPreSleep_start+1)=1;
    matrix_running(i,F_maze{i}-tMaze_start+1)=1;
    matrix_sleep(i,F_sleep{i}-tSleep_start+1)=1;
    
end

cov_pSleep = cov(matrix_pSleep');
cov_awake = cov(matrix_running');
cov_sleep = cov(matrix_sleep');