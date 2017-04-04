%   $GPGSV,2,1,08,01,40,083,46,02,17,308,41,12,07,344,39,14,22,228,45*75
%
% Where:
%       GSV          Satellites in view
%       2            Number of sentences for full data
%       1            sentence 1 of 2
%       08           Number of satellites in view
%
%       01           Satellite PRN number
%       40           Elevation, degrees
%       083          Azimuth, degrees
%       46           SNR - higher is better
%            for up to 4 satellites per sentence
%       *75          the checksum data, always begins with *

clc
clear


try
    fclose(instrfind)
    delete(instrfind)
end
s = serial('COM3');

fopen(s);
i = 1;

elev = [];
azi = [];
SNR = [];
allPRN = [];

%figure
figure(1)
clf(1)

pax = subplot(1,2,1,polaraxes);
pax.ThetaAxisUnits = 'degrees'
pax.ThetaDir = 'clockwise'
pax.ThetaZeroLocation = 'top'
pax.RDir = 'reverse'
pax.RLim = [0 90]
% hold on

str = subplot(1,2,2);
GPS = [];
hold on

while i>0
    if s.bytesavailable > 0
        raw = fgets(s);
        
        %if message id is GPRMC
        if strcmp(raw(1:6),'$GPRMC') == 1
            GPS = GPRMC(raw, GPS);
        end

        %if message id is GPGSA
        if strcmp(raw(1:6),'$GPGSA') == 1
            GPS = GPGSA(raw, GPS);
        end
        
        %if message id is GPGSV
        if strcmp(raw(1:6),'$GPGSV') == 1
            disp(raw)
            
            % info = [message#, message count, numsat]
            [info, PRN, elev, azi, SNR] = updateSNR(raw, elev, azi, SNR);
            allPRN = [allPRN;PRN];
            
            if info(1) == info(2) % if message id = total number of messages
                numsat = info(3)
                %                 sort(allPRN)
                
                % These PRN no longer appear to be seen
                resetIdx = ~ismember(1:length(elev),allPRN);
                %                 find(resetIdx)
                azi(resetIdx) = nan;
                elev(resetIdx) = nan;
                SNR(resetIdx) = nan;
                
                allPRN = []; % reset PRN counter
                
                Strength = [(1:length(SNR))' SNR']
                Positions = [(1:length(elev))' azi' elev']
                
                cla(pax)
                colr = hot(100);
%                 polarplot(pax,deg2rad(azi(~isnan(azi))),elev(~isnan(elev)),'o','MarkerEdgeColor','none',...
%                     'MarkerFaceColor',colr(SNR(~isnan(SNR))+1,:)','MarkerSize',14);
                polarplot(pax,deg2rad(azi(~isnan(azi))),elev(~isnan(elev)),'o','MarkerEdgeColor','none',...
                    'MarkerFaceColor','b','MarkerSize',14);
                pax.ThetaAxisUnits = 'degrees';
                pax.ThetaDir = 'clockwise';
                pax.ThetaZeroLocation = 'top';
                pax.RDir = 'reverse';
                pax.RLim = [0 90];
                
                text(pax,deg2rad(azi),elev,num2cell([1:length(azi)]),...
                    'HorizontalAlignment','center',...
                    'VerticalAlignment','middle','Color','white')
                
%                 drawnow
                
                cla(str);
                bar(str,SNR);
                ylim([0 50]);
                grid on
                drawnow
                
                try
                    GPS.GPRMC
                    GPS.GPGSA
                end
                
                
            end
            
            
        end
        
        
        %         subplot(1,2,1)
        %         bar(SNR);
        %         ylim([0 50]);
        %         grid on
        %         drawnow
        %
        %         subplot(1,2,2)

        
        %         i = 0
    end
end






















