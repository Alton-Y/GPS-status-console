function [ TIME, CBIT, CBIT2 ] = importCBIT( filename )
%LOADCBIT Summary of this function goes here
%   Detailed explanation goes here


% filename = 'C:\Users\GustAV\Google Drive\Ryerson UAV\Aventech Test\2017-04-13\04130411_cbit.out';
delimiter = ' ';
startRow = 59;
formatSpec = '%f%s%s%[^\n\r]';

fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'ReturnOnError', false);
fclose(fileID);

TIME = dataArray{:, 1};
CBIT = cellstr(dataArray{:, 2});
CBIT2 = cellstr(dataArray{:, 3});

clearvars filename delimiter startRow formatSpec fileID dataArray ans;




end

