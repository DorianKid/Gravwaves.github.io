%% INITIALIZE

% ----------------------------------------
% Clear all
clearvars
close all
clc

% ----------------------------------------
% Parameters
DataBlock        = 'LIGOO1_CBC01';
Tslice           = 1;  % {0.25|0.5|1|2|3|4|6|8};

% List of O1 data blocks with a GW event or injection
% O1 EVENTS:           % (GW150914_4096|LVT151012_4096|GW151226_4096)
% O1 INJECTIONS:       % (LIGOO1_CBC01|LIGOO1_CBC02|...|LIGOO1_CBC43)



%% PREPARE DATA

% ----------------------------------------
% Intialize timer
tic

% ----------------------------------------
% Load 4096s-block ligo data
ligoH1                     = gw_readligo(DataBlock,'H1',[],0);
ligoL1                     = gw_readligo(DataBlock,'L1',[],0);

% ----------------------------------------
% Initialize InfoBlok32 structure
InfoSeg32s                 = gw_getsegmentsinfoOVERLAP(4096,32,8,4096);

% ----------------------------------------
% Initialize OUT structure
OUT                        = [];

% ----------------------------------------
% Identify block with injection (Used for O1 data with HW injections)
if  isfield(ligoL1,'injection')
    ligoH1.segments        = InfoSeg32s;
    ligoL1.segments        = InfoSeg32s;
    
    tcoal                  = ligoH1.injection.GPS - ligoH1.gpsini;
    d                      = InfoSeg32s.Tint - tcoal;
    md                     = abs(d(:,1)+d(:,2));
    [~, seginj]            = min(md);
    ligoH1.segments.seginj = seginj;
    ligoL1.segments.seginj = seginj;
    clear ans seginj md d tcoal
    
    % Save injection info is the OUT strusture
    OUT.injection          = ligoH1.injection;
    OUT.FlagInj            = NaN(InfoSeg32s.Nseg,1);
else
    % Event GPS time
    if     strcmp(RUN,'GW150914_4096')
        ligoH1.segments.tcoal = 1126259462.00;
        ligoL1.segments.tcoal = 1126259462.00;
    elseif strcmp(RUN,'GW151226_4096')
        ligoH1.segments.tcoal = 1135136350.65;
        ligoL1.segments.tcoal = 1135136350.65;
    elseif strcmp(RUN,'LVT151012_4096')
        ligoH1.segments.tcoal = 1128678900.44;
        ligoL1.segments.tcoal = 1128678900.44;
    end
    % tcoal
    tcoal                  = ligoH1.segments.tcoal - ligoH1.gpsini;
    % Find segment with the event
    d                      = InfoSeg32s.Tint - tcoal;
    md                     = abs(d(:,1)+d(:,2));
    [~, segeve]            = min(md);
    % Save segment with the event
    ligoH1.segments.segeve = segeve;
    ligoL1.segments.segeve = segeve;
    clear ans segeve md d tcoal
    
end % if  isfield(ligoL1,'injection')

% ----------------------------------------
% Initialize variables to be saved
OUT.Nseg               = InfoSeg32s.Nseg;
OUT.FlagDet            = NaN(InfoSeg32s.Nseg,1);
OUT.lag                = NaN(InfoSeg32s.Nseg,1);
OUT.xcor               = NaN(InfoSeg32s.Nseg,1);

OUT.SegmentsWithDT     = [];

iswd                   = 1;



%% APPLY METHOD

% ----------------------------------------
% For each 32s-long ligo segment
for iseg = 1:InfoSeg32s.Nseg
    fprintf('Segment %d of %d \n',iseg,InfoSeg32s.Nseg)
    
    % ----------------------------------------
    % Get 32s-block ligo data
    ligoH1_32                 = ligoH1;
    ligoH1_32.path            = [];
    ligoH1_32.filename        = [];
    ligoH1_32.Tblock          = InfoSeg32s.Twin;
    ligoH1_32.strain          = ligoH1.strain(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoH1_32.timegps         = ligoH1.timegps(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoH1_32.timesec         = ligoH1.timesec(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoH1_32.gpsini          = ligoH1_32.timegps(1);
    ligoH1_32.gpsend          = ligoH1_32.timegps(end);
    ligoH1_32.Npoints         = length(ligoH1_32.strain);
    
    ligoL1_32                 = ligoL1;
    ligoL1_32.path            = [];
    ligoL1_32.filename        = [];
    ligoL1_32.Tblock          = InfoSeg32s.Twin;
    ligoL1_32.strain          = ligoL1.strain(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoL1_32.timegps         = ligoL1.timegps(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoL1_32.timesec         = ligoL1.timesec(InfoSeg32s.Sint(iseg,1):InfoSeg32s.Sint(iseg,2));
    ligoL1_32.gpsini          = ligoL1_32.timegps(1);
    ligoL1_32.gpsend          = ligoL1_32.timegps(end);
    ligoL1_32.Npoints         = length(ligoL1_32.strain);
    
    % ----------------------------------------
    % Compute data block
    dataH1_32                 = gw_computegetdataGW32(ligoH1_32,0);
    dataL1_32                 = gw_computegetdataGW32(ligoL1_32,0);
    
    % ----------------------------------------
    % Compute the whitening and band pass filtering data block
    dataH1_white              = gw_computewhitendata(dataH1_32,4,[20 400],4,0);
    dataL1_white              = gw_computewhitendata(dataL1_32,4,[20 400],4,0);
    
    % ----------------------------------------
    % Apply detection algorithm
    [DataSlicesWithDT,ResultsAllSlices] = gw_computexcorr_v2(dataH1_white,dataL1_white,Tslice,6,1);
    
    % ----------------------------------------
    % Save segment injection flag (SiInjection:Seg_FlagReal=1 | NoInjection:Seg_FlagReal=0)
    if  isfield(ligoL1,'injection')
        if iseg==ligoL1.segments.seginj
            OUT.FlagInj(iseg) = 1;
        else
            OUT.FlagInj(iseg) = 0;
        end % if ligoL1.segments.seginj
    end % if  isfield(ligoL1,'injection')
    
    % ----------------------------------------
    % Save segment detection flag, lag and xcorr
    if any(ResultsAllSlices.DetectionTrigger) % If there is a DT:
        % Save the FlagDet, lag and xcor
        OUT.FlagDet(iseg)                     = 1;
        OUT.lag(iseg)                         = DataSlicesWithDT.lag;
        OUT.xcor(iseg)                        = DataSlicesWithDT.xcor;
        
        % Save the Data and Results of this segment with DT
        OUT.DataSlicesWithDT{iseg}            = DataSlicesWithDT;
        OUT.ResultsAllSlices{iseg}            = ResultsAllSlices;
        
        % Save the iseg of this segment with DT
        OUT.SegmentsWithDT(iswd)              = iseg;
        iswd                                  = iswd + 1;
        
    else % If there is no a trigger:
        % Save the FlagDet, lag and xcor of this segment with no DT
        OUT.FlagDet(iseg)                     = 0;
        OUT.lag(iseg)                         = NaN;
        OUT.xcor(iseg)                        = NaN;
        
        % No Data and Results to save in this segment with no DT
        OUT.DataSlicesWithDT{iseg}            = [];
        OUT.ResultsAllSlices{iseg}            = [];
    end % if any(ResultsAllSlices.trigger)
    
end % for iseg=1:InfoSeg32s.Nseg

% ----------------------------------------
% Save elapsed time
OUT.TimeElapsed = toc;



%%  SAVE RESULTS

% ----------------------------------------
% Get strTslice
if     Tslice==0.25, strTslice='025';
elseif Tslice==0.50, strTslice='050';
elseif Tslice==1.00, strTslice='100';
elseif Tslice==2.00, strTslice='200';
elseif Tslice==3.00, strTslice='300';
elseif Tslice==4.00, strTslice='400';
elseif Tslice==6.00, strTslice='600';
elseif Tslice==8.00, strTslice='800';
else,  error('PILAS: unknown Tslice')
end


% ----------------------------------------
% Save results
if  isfield(ligoL1,'injection')
    save([ligoH1.path RUN(8:end) '_ResultsTslice' strTslice],'OUT')
else
    save([ligoH1.path 'XCORResultsTslice' strTslice],'OUT')
end % if  isfield(ligoL1,'injection')


% ----------------------------------------
% Clear garbage
clear ans iseg doplot isegwd Tslice RUN
clear ans ligoL1 ligoH1 ligoH1_32 ligoL1_32 dataL1_32 dataH1_32 
clear ans dataH1_white dataL1_white InfoSeg32s TimeElapsed strTslice
clear ans ResultsAllSlices DataSlicesWithDT iswd

