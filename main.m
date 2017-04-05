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

% elev = [];
% azi = [];
% SNR = [];
GPGSV = [];

%figure
figure(1)
clf(1)

c = hsv(250);
c = c(1:100,:);

pax = subplot(1,2,1,polaraxes);
pax.ThetaAxisUnits = 'degrees'
pax.ThetaDir = 'clockwise'
pax.ThetaZeroLocation = 'top'
pax.RDir = 'reverse'
pax.RLim = [0 90]
hold on



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
            [info, data] = updateSNR(raw);
            GPGSV = [GPGSV;data];
            
            if info(1) == info(2) % if message id = total number of messages
                numsat = info(3)
                %                 sort(allPRN)
                
                % Get sat PNR which are used to calculate the solution
                SV = GPS.GPGSA.SV;
                
                % in GPGSV, turn nans in col4 (SNR) to zero
                GPGSV(isnan(GPGSV(:,4)),4) = 0;
                
                % sort GPGSV by col1 for easy plotting
                GPGSV = sortrows(GPGSV,1);
                
                % empty azi, elev, SNR, (write all nans)
                maxPRN = max(GPGSV(:,1));
                elev = nan(1,maxPRN);
                azi = nan(1,maxPRN);
                SNR = zeros(1,maxPRN); %zero SNR
                
                % Write GPGSV data to azi, elev, SNR
                elev(GPGSV(:,1)) = GPGSV(:,2);
                azi(GPGSV(:,1)) = GPGSV(:,3);
                SNR(GPGSV(:,1)) = GPGSV(:,4);
                
                
                
                [(1:maxPRN);elev;azi;SNR]'
                                
                %plotting                
                cla(pax)
                                
                polarscatter(pax,deg2rad(azi(SV)),elev(SV),200,'k'...
                    ,'MarkerFaceAlpha',0);
                
                polarscatter(pax,deg2rad(azi),elev,200,c(SNR+1,:),...
                    'filled','MarkerFaceAlpha',.7);
                
                pax.ThetaAxisUnits = 'degrees';
                pax.ThetaDir = 'clockwise';
                pax.ThetaZeroLocation = 'top';
                pax.RDir = 'reverse';
                pax.RLim = [0 90];
                hold off
                text(pax,deg2rad(azi),elev,num2cell([1:length(azi)]),...
                    'HorizontalAlignment','center',...
                    'VerticalAlignment','middle','Color','black')
                
                %                 drawnow
                
                cla(str);
%                 bar(str,SNR);
                bar(str,GPGSV(:,4))
                set(str,'XTick',1:length(GPGSV(:,1)),'XTickLabel', string(GPGSV(:,1)));
                ylim([0 75]);
                grid on
                drawnow
                
                GPGSV = []; % reset GPGSV data holder
                
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






















