%   $GPGSV,2,1,08,01,40,083,46,02,17,308,41,12,07,344,39,14,22,228,45*75
%
% Where:
%0       $GPGSV
%1       2            Number of sentences for full data
%2       1            sentence 1 of 2
%3       08           Number of satellites in view
%4       01           Satellite PRN number
%5       40           Elevation, degrees
%6       083          Azimuth, degrees
%7       46           SNR - higher is better
%8-11, 12-15, 16-19   for up to 4 satellites per sentence
%       *75          the checksum data, always begins with *

function [info, PRN, elev, azi, SNR] = updateSNR(raw, elev, azi, SNR)


try
% remove Check sum which always appears in the last cell
cs = strsplit(raw,'*','CollapseDelimiters',0);
C = strsplit(cs{1}, ',','CollapseDelimiters',0);

matC = str2double(C(2:end));

% sometimes NaN may appear, this will get rid of it
% matC = matC(~isnan(matC))

% numSat = matC(3);

info = matC(1:3); % info = [message#, message count, numsat]

data = reshape(matC(4:end),4,[])'; %each row is a different PRN


PRN = data(:,1);

elev(PRN(~isnan(data(:,2)))) = data(~isnan(data(:,2)),2);
azi(PRN(~isnan(data(:,3)))) = data(~isnan(data(:,3)),3);
SNR(PRN(~isnan(data(:,4)))) = data(~isnan(data(:,4)),4);

SNR(PRN(isnan(data(:,4)))) = 0;

% ZERO the data when sat no longer appear in PRN list
% PRNlist = 1:length(elev);
% elev(PRN(~isnan(data(:,2)))) = data(~isnan(data(:,2)),2);


catch
    disp('Error');
    raw
    
end








end



















