%% INITIALIZE
clearvars
close all
clc



%% COMPUTE GW

% --------------------------------------
% Define parameters
m1             = 36;                % Mass 1 (sum masses)
m2             = 29;                % Mass 2 (sum masses)
DMpc           = 420;               % Distance (Mpc)
fs             = 4096*4;            % Sampling frequency (Hz)
iota           = 60*(pi/180);       % Angle iota [-pi,pi] (rad)
cfg            = gwpol_constants(); % Get constants

% --------------------------------------
% Compute for GW in PN order
PNorder        = 0.0;               % (0,1,1.5,2,2.5,3,3.5)
prm            = gwpol_parameterspostnewtonian(cfg,m1,m2,DMpc,PNorder,iota);
GW             = gwpol_templatetimedomainpostnewtonian_v2(cfg,prm,fs,PNorder,0);

% --------------------------------------
% Clear garbage
clear ans m1 m2 DMpc iota PNorder fs

% --------------------------------------
% Save figures
DoSave         = 0;

% --------------------------------------
% Define filename
DefineFilename

% --------------------------------------
% Define Colors for plots
DefineColors



%% PLOT GW PHASE, FREQUENCY AND AMPLITUDE

% % --------------------------------------
% % Plot frequency, phase and amplitude
% figure, clf, hold on
% subplot(3,1,1), plot(GW.t,GW.phit,'-','MarkerSize',4,'LineWidth',4), ylabel('\phi(t)'), box on, grid on, set(gca,'FontSize',12,'XLim',[min(GW.t) max(GW.t)]), title(['PN order: ' num2str(prm.PNorder)])
% subplot(3,1,2), plot(GW.t,GW.ft  ,'-','MarkerSize',4,'LineWidth',4), ylabel('f(t)')   , box on, grid on, set(gca,'FontSize',12,'XLim',[min(GW.t) max(GW.t)]), 
% subplot(3,1,3), plot(GW.t,GW.At  ,'-','MarkerSize',4,'LineWidth',4), ylabel('A(t)')   , box on, grid on, set(gca,'FontSize',12,'XLim',[min(GW.t) max(GW.t)]), 
% xlabel('Time (s)')
% if DoSave==1
%     fn4all_3 = [prm.PNorderSTR '_masas' prm.m1STR 'y' prm.m2STR '_Dis' prm.DMpcSTR 'Mpc'];
%     filename = ['PhaFreAmp_' fn4all_3];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end



%% PLOT GW POLARIZATIONS

% --------------------------------------
% Define YLim
num     = max(abs([GW.hp; GW.hc; GW.hx; GW.hy; GW.hb; GW.hl; GW.hp_bd; GW.hc_bd ; GW.hb_bd]));
E       = floor(log10( num ));
M       = num/(10^E);
YLimPol = 4e-21; %YLimPol = (ceil(M)+0) * 10^E;


% % --------------------------------------
% % Plot GW: h+(t) and hx(t)
% figure, clf, hold on
% plot(GW.t,GW.hp,'-','MarkerSize',4,'LineWidth',2)
% plot(GW.t,GW.hc,'-','MarkerSize',4,'LineWidth',2)
% legend('$h_+$','$h_{\times}$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
% ylabel('$h_{+,\times}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% % title(['PN: ' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°'])
% box on, grid on
% set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimPol) 
% if DoSave==1
%     filename = ['Polarizations_Ten_' fn4all];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end

% --------------------------------------
% Plot GW: h+(t), hx(t), hx(t), hy(t), hb(t), hl(t)
figure, clf, hold on
plot(GW.t,GW.hp,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hc,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hx,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hy,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hb,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hl,'-','MarkerSize',4,'LineWidth',2)
legend('$h_+$','$h_{\times}$','$h_x$','$h_y$','$h_b$','$h_l$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
ylabel('$h_{+,\times,x,y,b,l}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN: ' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
set(gca,'YLim',[-1 1]*YLimPol) 
set(gca,'YTick',[-4 -2 0 2 4]*1e-21) 

if DoSave==1
    filename = ['Polarizations_TenAndNonTen_' fn4all];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end

% --------------------------------------
% Plot GW Brans-Dicke: h+(t), hx(t), and h(b)

num2  = max(abs([GW.hb_bd]));
E2    = floor(log10( num2 ));
M2    = num2/(10^E2);
if M<=M2
    YLim2 = (ceil(M)+0) * 10^(E2+1);
else
    YLim2 = (ceil(M)+0) * 10^(E2+0);
end

figure, clf, hold on
plot(GW.t,GW.hp_bd,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hc_bd,'-','MarkerSize',4,'LineWidth',2)
% plot(GW.t,GW.hb_bd,'-','MarkerSize',4,'LineWidth',2)
ylabel('$h_{+,\times}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN: ' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
set(gca,'YLim',[-1 1]*YLimPol) 
set(gca,'YTick',[-4 -2 0 2 4]*1e-21) 

yyaxis right
set(gca,'YColor',c(5,:))
plot(GW.t,GW.hb_bd ,'-','MarkerSize',4,'LineWidth',2,'Color',c(5,:))
ylabel('$h_{b}$','Interpreter','Latex','FontSize',18)
set(gca,'YLim',[-1 1]*YLim2)

legend('$h_+$','$h_{\times}$','$h_b$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
if DoSave==1
    filename = ['Polarizations_BransDicke_' fn4all];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end









% --------------------------------------
% Define YLim
% YLimPol = [-2 2]*1e-21;

% --------------------------------------
% Plot GW ROSEN: h+(t), hx(t), hx(t), hy(t), hb(t), hl(t)
figure, clf, hold on
plot(GW.t,GW.hp_rosen,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hc_rosen,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hx_rosen,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hy_rosen,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hb_rosen,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hl_rosen,'-','MarkerSize',4,'LineWidth',2)
legend('$h_+$','$h_{\times}$','$h_x$','$h_y$','$h_b$','$h_l$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
ylabel('$h_{+,\times,x,y,b,l}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN: ' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
set(gca,'YLim',[-1 1]*YLimPol) 
set(gca,'YTick',[-4 -2 0 2 4]*1e-21) 

% set(gca,'YLim',YLimPol) 
if DoSave==1
    filename = ['Polarizations_Rosen_' fn4all];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end



% --------------------------------------
% Define YLim
YLimPol = [-6 4]*1e-21;%YLimPol = [-5 2]*1e-21;

% --------------------------------------
% Plot GW Lightman-Lee: h+(t), hx(t), hx(t), hy(t), hb(t), hl(t)
figure, clf, hold on
plot(GW.t,GW.hp_lightman,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hc_lightman,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hx_lightman,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hy_lightman,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hb_lightman,'-','MarkerSize',4,'LineWidth',2)
plot(GW.t,GW.hl_lightman,'-','MarkerSize',4,'LineWidth',2)
legend('$h_+$','$h_{\times}$','$h_x$','$h_y$','$h_b$','$h_l$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
ylabel('$h_{+,\times,x,y,b,l}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN: ' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimPol) 
set(gca,'YLim',YLimPol) 
set(gca,'YTick',[-4 -2 0 2 4]*1e-21) 

if DoSave==1
    filename = ['Polarizations_LightmanLee_' fn4all];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end

% return

%% COMPUTE STRAIN -> h(t)=Fp*hp+Fc*hc+Fx*hx+Fy*hy+Fb*hb+Fl*hl

% --------------------------------------
% Define orientation
% theta -> ranges from 0 to pi
% phi   -> ranges from 0 to 2pi
% Psi   -> ranges from 0 to pi

% --------------------------------------
% Select angles
ORI = 4;
if     ORI==1
    % Perpendicular al plano x-y (GW en direccion z)
    thetadegree =  0;                theta = thetadegree * pi/180;
    phidegree   =  0;                phi   = phidegree   * pi/180;
    
elseif ORI==2
    % Perpendicular al plano y-z (GW en direccion x)
    thetadegree = 90;                theta = thetadegree * pi/180;
    phidegree   =  0;                phi   = phidegree   * pi/180;
    
elseif ORI==3
    % Perpendicular al plano x-z (GW en direccion y)
    thetadegree = 90;                theta = thetadegree * pi/180;
    phidegree   = 90;                phi   = phidegree   * pi/180;
    
elseif ORI==4
    % GW150914
    thetadegree =  80;               theta = thetadegree * pi/180;
    phidegree   = 120;               phi   = phidegree   * pi/180;    
    
elseif ORI==5
    % NS-NS
    thetadegree = 197;               theta = thetadegree * pi/180;
    phidegree   =  23;               phi   = phidegree   * pi/180;
    
end
Psidegree   = prm.iotadegree;    
Psi         = prm.iota;

% --------------------------------------
% Filename
fn4all_4 = [fn4all '_Theta' num2str(thetadegree) '_Phi' num2str(phidegree)];

% --------------------------------------
% Compute antenna pattern
[Fp, Fc, Fx, Fy, Fb, Fl] = gwpol_anntenapatterncompute(theta,phi,Psi);

% --------------------------------------
% Compute induced strain
GW.strain_Ten      = Fp*GW.hp          + Fc*GW.hc;
GW.strain_TyN      = Fp*GW.hp          + Fc*GW.hc          + Fx*GW.hx          + Fy*GW.hy          + Fb*GW.hb          + Fl*GW.hl;
GW.strain_Bra      = Fp*GW.hp_bd       + Fc*GW.hc_bd                                               + Fb*GW.hb_bd;
GW.strain_Ros      = Fp*GW.hp_rosen    + Fc*GW.hc_rosen    + Fx*GW.hx_rosen    + Fy*GW.hy_rosen    + Fb*GW.hb_rosen    + Fl*GW.hl_rosen;
GW.strain_Lig      = Fp*GW.hp_lightman + Fc*GW.hc_lightman + Fx*GW.hx_lightman + Fy*GW.hy_lightman + Fb*GW.hb_lightman + Fl*GW.hl_lightman ;

% --------------------------------------
% Compute strain accoring to equation 4.23
% TanPhsi            = (Fc/Fp) * (cos(prm.iota)/(prm.cosiota2));
% Phsi               = atan(TanPhsi);
% 
% At                 = GW.At*prm.D;
% Deff               = prm.D * ( (Fp^2).*prm.cosiota2^2 + (Fc^2).*prm.cosiota1^2 )^(-1/2);
% GW.strain_Ten_v2   = (At/Deff) .* cos(GW.phit-Phsi);
% 
% figure, hold on
% plot(GW.t,GW.strain_Ten    ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
% plot(GW.t,GW.strain_Ten_v2 ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
% box on
% grid on
% legend('19','20')
% 
% 
% return
% q=1;


% % --------------------------------------
% % Compute strain accoring to equation 4.23
% Phsi = -150*pi/180;
% 
% B    = Fp*( (1+(cos(prm.iota))^2)/2 ) + Fx*(sin(2*prm.iota)/2) + ( (Fb/2)+(Fl/sqrt(2)) )*(sin(prm.iota)^2);
% C    = Fc*cos(prm.iota) + Fy*sin(prm.iota);
% 
% GW.strain_TyN_v2 = GW.At .* sqrt(B^2+C^2) .* cos(GW.phit-Phsi);
%  
% 
% figure, hold on
% plot(GW.t,GW.strain_TyN ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
% plot(GW.t,GW.strain_TyN_v2 ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
% box on
% grid on
% legend('4.21','4.23')
% 
% % return
% q=1;


%% PLOT: POLARIZATIONS AND STRAIN

% % --------------------------------------
% % Plot polarizations and strain tensorial: h+(t), hx(t)
% figure, clf, hold on
% php=plot(GW.t,GW.hp,'-','MarkerSize',4,'LineWidth',2); php.Color(4) = 0.25;
% phc=plot(GW.t,GW.hc,'-','MarkerSize',4,'LineWidth',2); phc.Color(4) = 0.25;
% plot(GW.t,GW.strain_Ten,'-','MarkerSize',4,'LineWidth',3,'Color',[0.15,0.15,0.15])
% legend('$h_+$','$h_{\times}$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
% ylabel('$h_{+,\times}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% box on, grid on
% set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimPol) 
% if DoSave==1
%     filename = ['Strain_Ten_' fn4all_4];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end
% 
% % --------------------------------------
% % Plot polarizations and strain tensorial and non-tensorial: h+(t), hx(t), hx(t), hy(t), hb(t), hl(t)
% figure, clf, hold on
% php=plot(GW.t,GW.hp,'-','MarkerSize',4,'LineWidth',2); php.Color(4) = 0.25;
% phc=plot(GW.t,GW.hc,'-','MarkerSize',4,'LineWidth',2); phc.Color(4) = 0.25;
% phx=plot(GW.t,GW.hx,'-','MarkerSize',4,'LineWidth',2); phx.Color(4) = 0.25;
% phy=plot(GW.t,GW.hy,'-','MarkerSize',4,'LineWidth',2); phy.Color(4) = 0.25;
% phb=plot(GW.t,GW.hb,'-','MarkerSize',4,'LineWidth',2); phb.Color(4) = 0.25;
% phl=plot(GW.t,GW.hl,'-','MarkerSize',4,'LineWidth',2); phl.Color(4) = 0.25;
% plot(GW.t,GW.strain_TyN,'-','MarkerSize',4,'LineWidth',3,'Color',[0.15,0.15,0.15])
% legend('$h_+$','$h_{\times}$','$h_x$','$h_y$','$h_b$','$h_l$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
% ylabel('$h_{+,\times,x,y,b,l}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% box on, grid on
% set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimPol) 
% if DoSave==1
%     filename = ['Strain_TenAndNonTen_' fn4all];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end
% 
% % --------------------------------------
% % Plot polarizations and strain from Brans-Dicke: h+_b(t), hx_b(t), and hb_b(t)
% figure, clf, hold on
% php=plot(GW.t,GW.hp_bd,'-','MarkerSize',4,'LineWidth',2);                php.Color(4) = 0.25;
% phc=plot(GW.t,GW.hc_bd,'-','MarkerSize',4,'LineWidth',2);                phc.Color(4) = 0.25;
% phc=plot(GW.t,GW.hb_bd,'-','MarkerSize',4,'LineWidth',2,'Color',c(5,:)); phc.Color(4) = 0.25;
% plot(GW.t,GW.strain_Bra,'-','MarkerSize',4,'LineWidth',3,'Color',[0.15,0.15,0.15])
% legend('$h_+$','$h_{\times}$','$h_b$','Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Horizontal')
% ylabel('$h_{+,\times,b}$','Interpreter','Latex','FontSize',18), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% box on, grid on
% set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimPol) 
% if DoSave==1
%     filename = ['Strain_BransDicke_' fn4all];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end



%% PLOT: COMPARE STRAIN

% --------------------------------------
% Define YLim
num  = max(abs([GW.strain_Ten ; GW.strain_TyN ; GW.strain_Bra]));
E    = floor(log10( num ));
M    = num/(10^E);
YLimS= 2e-21; %YLimS= (ceil(M)+1) * 10^E;

% --------------------------------------
% Plot both strain from tensorial (plus,cross) and from tensorial and non-tensorial (plus, cross, x, y, b, l)
figure, clf, hold on
plot(GW.t,GW.strain_Ten ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
plot(GW.t,GW.strain_TyN ,':'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
% plot(GW.t,GW.strain_Bra ,'--' ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
legend('Tensorial','Tensorial + Nontensorial','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
ylabel('Strain'), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
set(gca,'YLim',[-1 1]*YLimS) 
set(gca,'YTick',[-2 -1 0 1 2]*1e-21) 
if DoSave==1
    filename = ['CompareStrain_TenVsTenWithNonten_' fn4all_4];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end

% --------------------------------------
% Plot both strain from tensorial (plus,cross) and from tensorial and non-tensorial (plus, cross, x, y, b, l)
figure, clf, hold on
plot(GW.t,GW.strain_Ten ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
% plot(GW.t,GW.strain_TyN ,':'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
plot(GW.t,GW.strain_Bra ,'--' ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
legend('Tensorial','Brans-Dicke','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
ylabel('Strain'), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
set(gca,'YLim',[-1 1]*YLimS)
set(gca,'YTick',[-2 -1 0 1 2]*1e-21) 

% Plot difference betwent strain tensorial and strain brand-dicke
DoPlotDiff = 1;
if DoPlotDiff == 1    
    
    % Compute strain difference
    hdiff      = GW.strain_Ten-GW.strain_Bra;
    
    % YLim for the right axes
    num_YLimS  = YLimS;
    E_YLimS    = floor(log10( num_YLimS ));
    M_YLimS    = num_YLimS/(10^E_YLimS);
    
    % Compute YLim for the left axes
    num2       = max(abs(hdiff));
    E2         = floor(log10( num2 ));
    M2         = num2/(10^E2);
    YLimLeft   = M_YLimS * 10^(E2+1);
    
    yyaxis right
    set(gca,'YColor',[0.25 0.25 0.25])
    plot(GW.t,hdiff ,'-','MarkerSize',4,'LineWidth',2,'Color',[0.25 0.25 0.25])
    ylabel('Difference','FontSize',18)
    set(gca,'YLim',[-1 1]*YLimLeft)
    set(gca,'YTick',[-2 -1 0 1 2]*1e-26) 
    
    legend('Tensorial','Brans-Dicke','Difference','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
end
if DoSave==1
    filename = ['CompareStrain_TenVsBD_' fn4all_4];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end

% % --------------------------------------
% % Plot both strain from tensorial (plus,cross) and from tensorial and non-tensorial (plus, cross, x, y, b, l)
% figure, clf, hold on
% plot(GW.t,GW.strain_Ten ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
% plot(GW.t,GW.strain_TyN ,':'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
% plot(GW.t,GW.strain_Bra ,'--' ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
% legend('Tensorial','Tensorial + Nontensorial','Brans-Dicke','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
% ylabel('Strain'), xlabel('Time (s)')
% % title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% box on, grid on
% set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimS) 
% if DoSave==1
%     filename = ['CompareStrain_TenVsTenWithNontenVsBD_' fn4all_4];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end









% --------------------------------------
% Define YLim
% num  = max(abs([GW.strain_TyN ; GW.strain_Ros ; GW.strain_Lig]));
% E    = floor(log10( num ));
% M    = num/(10^E);
% YLimS= (ceil(M)+1) * 10^E;
YLimS = [-2 2]*1e-21; %YLimS = [-1 2]*1e-21;



% --------------------------------------
% ROSEN: Plot both strain from tensorial (plus,cross) and from Rosen (plus, cross, x, y, b, l)
figure, clf, hold on
plot(GW.t,GW.strain_Ten ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
plot(GW.t,GW.strain_TyN ,':'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
plot(GW.t,GW.strain_Ros ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
% plot(GW.t,GW.strain_Bra ,'--' ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
legend('Tensorial','Tensorial + Nontensorial','Rosen','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
ylabel('Strain'), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
%set(gca,'YLim',[-1 1]*YLimS) 
set(gca,'YLim',YLimS) 
set(gca,'YTick',[-2 -1 0 1 2]*1e-21) 
if DoSave==1
    filename = ['CompareStrain_TenWithNontenVsRosen_' fn4all_4];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end


% --------------------------------------
% LightmanLee: Plot both strain from tensorial (plus,cross) and from LightmanLee (plus, cross, x, y, b, l)
figure, clf, hold on
plot(GW.t,GW.strain_Ten ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(1,:))
plot(GW.t,GW.strain_TyN ,':'  ,'MarkerSize',4,'LineWidth',3,'Color',c(2,:))
plot(GW.t,GW.strain_Lig ,'-'  ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
% plot(GW.t,GW.strain_Bra ,'--' ,'MarkerSize',4,'LineWidth',3,'Color',c(3,:))
legend('Tensorial','Tensorial + Nontensorial','LightmanLee','Location','NorthWest','EdgeColor','None','Color','None','FontSize',12,'Orientation','Vertical')
ylabel('Strain'), xlabel('Time (s)')
% title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
box on, grid on
set(gca,'FontSize',14,'XLim',[min(GW.t) max(GW.t)])
% set(gca,'YLim',[-1 1]*YLimS)
set(gca,'YLim',YLimS) 
set(gca,'YTick',[-2 -1 0 1 2]*1e-21) 
if DoSave==1
    filename = ['CompareStrain_TenWithNontenVsLightmanLee_' fn4all_4];
    saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
    %saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
end








%% SAVE DATAFILES

% % --------------------------------------
% % Save datafiles
% Data      = [GW.t-GW.t(1) , GW.hp , GW.hc , GW.hx , GW.hy , GW.hb , GW.hl , GW.hp_bd , GW.hc_bd , GW.hb_bd];
% filename  = ['S001_CBCSignals_Polari_' fn4all];
% writematrix(Data,[filename '.txt'],'delimiter',' ')
% 
% Data      = [GW.t-GW.t(1) , GW.strain_Ten , GW.strain_TyN , GW.strain_Bra];
% filename  = ['S001_CBCSignals_Strain_' fn4all];
% writematrix(Data,[filename '.txt'],'delimiter',' ')



%% COMPUTE CHARACTERISTIC STRAIN

% % --------------------------------------
% [~,GW.hchar_hp    ] = gwpol_hchar(GW.hp        ,GW.ts);
% [~,GW.hchar_hc    ] = gwpol_hchar(GW.hc        ,GW.ts);
% [~,GW.hchar_hx    ] = gwpol_hchar(GW.hx        ,GW.ts);
% [~,GW.hchar_hy    ] = gwpol_hchar(GW.hy        ,GW.ts);
% [~,GW.hchar_hb    ] = gwpol_hchar(GW.hb        ,GW.ts);
% [~,GW.hchar_hl    ] = gwpol_hchar(GW.hl        ,GW.ts);
% 
% % --------------------------------------
% [~,GW.hchar_hp_bd ] = gwpol_hchar(GW.hp_bd     ,GW.ts);
% [~,GW.hchar_hc_bd ] = gwpol_hchar(GW.hc_bd     ,GW.ts);
% [~,GW.hchar_hb_bd ] = gwpol_hchar(GW.hb_bd     ,GW.ts);
% 
% % --------------------------------------
% [~,GW.hchar_Ten ]   = gwpol_hchar(GW.strain_Ten ,GW.ts);
% [~,GW.hchar_TyN ]   = gwpol_hchar(GW.strain_TyN ,GW.ts);
% [f,GW.hchar_Bra ]   = gwpol_hchar(GW.strain_Bra ,GW.ts);
% 
% % --------------------------------------
% % Load H1 and L1 sensitivities
% x    = importdata('GW150914/L1-GDS-CALIB_STRAIN.txt');
% O1L1 = x.data;
% 
% x    = importdata('GW150914/H1-GDS-CALIB_STRAIN.txt');
% O1H1 = x.data;
% 
% % Clear garbage
% clear ans x



%% PLOT CHARACTERISTIC STRAIN

% % --------------------------------------
% % Plot hchar para las polarizaciones tensoriales y notensoriales
% figure, clf, hold on
%          plot(O1L1(:,1) ,O1L1(:,2)      ,'-'  ,'LineWidth',2,'Color',[0.50 0.50 0.50]);
%          plot(O1H1(:,1) ,O1H1(:,2)      ,'-'  ,'LineWidth',2,'Color',[0.75 0.75 0.75]);
% 
% php    = plot(f         ,GW.hchar_hp    ,'-'  ,'LineWidth',3,'Color',c(1,:));
% phc    = plot(f         ,GW.hchar_hc    ,'-'  ,'LineWidth',3,'Color',c(2,:));
% phx    = plot(f         ,GW.hchar_hx    ,'-'  ,'LineWidth',3,'Color',c(3,:));
% phy    = plot(f         ,GW.hchar_hy    ,'-'  ,'LineWidth',3,'Color',c(4,:));
% phb    = plot(f         ,GW.hchar_hb    ,'-'  ,'LineWidth',3,'Color',c(5,:));
% phl    = plot(f         ,GW.hchar_hl    ,'-'  ,'LineWidth',3,'Color',c(6,:));
% 
% phb_bd = plot(f,GW.hchar_hb_bd ,'-.'  ,'LineWidth',3,'Color',c(5,:));
% 
% % title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% set(gca,'XScale','Log','YScale','Log')
% ylabel('ASD'), xlabel('Frequency (Hz)')
% box on, grid on
% set(gca,'FontSize',14)
% set(gca,'YLim',[1*10^(-29) 1*10^(-20)])
% set(gca,'XLim',[20 4000])
% 
% line([30 50],[1e-24 1e-24],'LineWidth',2,'Color',[0.50 0.50 0.50]); text(52,1.2e-24,'O1-L1','FontSize',12)
% line([30 50],[3e-25 3e-25],'LineWidth',2,'Color',[0.75 0.75 0.75]); text(52,3.2e-25,'O1-H1','FontSize',12)
% 
% p = legend([php phc phx phy phb phl phb_bd],{...
%     '$h_+$','$h_{\times}$',...
%     '$h_x$','$h_y$','$h_b$','$h_l$',...
%     '$h_b$ Brans-Dicke'},'Location','SouthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Vertical');
% set(p,'Position',[0.5726    0.2730    0.2781    0.3367])
% 
% if DoSave==1
%     filename = ['hcharPolarizaciones_TenAndNontenAndBD_' fn4all_4];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end
% 
% % --------------------------------------
% % Plot hchar para el strain tensoriales, notensoriales y brans-dicke
% figure(14), clf, hold on
%          plot(O1L1(:,1) ,O1L1(:,2)      ,'-'  ,'LineWidth',2,'Color',[0.50 0.50 0.50]);
%          plot(O1H1(:,1) ,O1H1(:,2)      ,'-'  ,'LineWidth',2,'Color',[0.75 0.75 0.75]);
% 
% pT     = plot(f,GW.hchar_Ten            ,'-'  ,'LineWidth',3,'Color',c(1,:));
% pN     = plot(f,GW.hchar_TyN            ,':'  ,'LineWidth',3,'Color',c(2,:));
% pB     = plot(f,GW.hchar_Bra            ,'--' ,'LineWidth',3,'Color',c(3,:));
% % title(['PN=' num2str(prm.PNorder) '  |  \iota=' num2str(prm.iotadegree) '°' '  |  (\theta,\phi)=(' num2str(thetadegree) ',' num2str(phidegree) ')°'])
% set(gca,'XScale','Log','YScale','Log')
% ylabel('ASD'), xlabel('Frequency (Hz)')
% box on, grid on
% set(gca,'FontSize',14)
% set(gca,'YLim',[1*10^(-24) 1*10^(-20)])
% set(gca,'XLim',[20 4000])
% 
% line([100 150],[4e-21 4e-21],'LineWidth',2,'Color',[0.50 0.50 0.50]); text(160,4.2e-21,'O1-L1','FontSize',12)
% line([100 150],[2e-21 2e-21],'LineWidth',2,'Color',[0.75 0.75 0.75]); text(160,2.2e-21,'O1-H1','FontSize',12)
% 
% p = legend([pT pN pB],{'Tensorial','Tensorial + Nontensorial','Brans-Dicke'},'Location','NorthWest','Interpreter','Latex','EdgeColor','None','Color','None','FontSize',14,'Orientation','Vertical');
% set(p,'Position',[0.4334    0.1604    0.3500    0.1333])
% 
% if DoSave==0
%     filename = ['hcharStrain_TenAndTenWithNontenAndBD_' fn4all_4];
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'png')
%     saveas(gcf,['Figures/S001_CBCSignals/' filename],'eps')
% end
% 
% 
% 
% 
