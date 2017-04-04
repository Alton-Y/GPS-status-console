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

function [info, data] = updateSNR(raw)


try
% remove Check sum which always appears in the last cell
cs = strsplit(raw,'*','CollapseDelimiters',0);
C = strsplit(cs{1}, ',','CollapseDelimiters',0);

matC = str2double(C(2:end));



info = matC(1:3); % info = [message#, message count, numsat]

data = reshape(matC(4:end),4,[])'; %each row is a different PRN


% do data sort and storage outside of this function in the main loop



catch
    disp('Error');
    raw
    
end








end



















