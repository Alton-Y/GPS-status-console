function [ cbitMat ] = cbitDecode( CBIT )
%CBITDECODE Summary of this function goes here
%   Detailed explanation goes here

hex = split(CBIT,'');
cbitHex = hex(:,2:end-1);
cbitCount = length(cbitHex(1,:));
cbitDec = uint8(reshape(hex2dec(cbitHex),[],cbitCount));
cbitCell = arrayfun(@(x) bitget(x,4:-1:1,'uint8'), cbitDec, 'UniformOutput',false);
cbitMat = reshape(cell2mat(cbitCell),[],4,cbitCount);


end

