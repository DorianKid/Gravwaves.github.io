%% A) INITIALIZE

% Clear workspace
close all; clear all; clc;

% Select an interferometer (H1 or L1)
IFO        = 'L1';

% Select a data block file ID
ifile      = 4;



%% B) DETECTION

% Read ligo data
ligo             = gw_readligo('S5',IFO,ifile);

% Data segment: s(t) and s(f)
data             = gw_computegetdata(ligo);

% Compute noise power spectral density: Pww(f)
noise            = gw_computenoise(ligo);

% Compute template (D=1Mpc): h(f)
template         = gw_computetemplatepostnewtonian(ligo.injection.M1,ligo.injection.M2,ligo.injection.D,ligo.injection.PNorder,ligo.fs,ligo.NFFT);

% Compute matched filter in the frequency domain
MFfreq           = gw_computematchedfilterfreq(data,template,noise);



%% C) PLOT RESULTS

figure(1), clf

subplot(2,1,1), hold on
plot(data.t,data.st,'b')
plot(template.t+ligo.injection.GPS-template.t(end),10000*template.st,'r')
line([ligo.injection.GPS ligo.injection.GPS],[-1.2*max(abs(data.st)) 1.2*max(abs(data.st))],'Color',[1 0 0])
xlabel('Time (gps)'), ylabel('s(t)'), title('Data segment,Template and t_c'), box on,
set(gca,'Xlim',[data.t(1) data.t(end)]), set(gca,'Ylim',[-1.2*max(abs(data.st)) 1.2*max(abs(data.st))]), %set(gca,'Ylim',[-1e-15 1e-15])

subplot(2,1,2), hold on
plot(data.t,MFfreq.rho,'b'), plot(MFfreq.gpscoal,MFfreq.SNRpre,'om')
xlabel('Time (gps)'), ylabel('\rho(t)'), box on,
title('Matched filter output')
if MFfreq.detection==0
    text(MFfreq.gpscoal+2,MFfreq.SNRpre/1,'! NO DETECTION ¡','Color',[1 0 0])
elseif MFfreq.detection==1
    text(MFfreq.gpscoal+2,MFfreq.SNRpre/1,'! DETECTION ¡','Color',[0 0 1])
end
set(gca,'Xlim',[data.t(1) data.t(end)],'Ylim',[0 1.2*MFfreq.SNRpre])

