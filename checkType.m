function [ flag ] = checkType( raw, type )
%CHECKSENTANCE Summary of this function goes here
%   Detailed explanation goes here

C = strsplit(raw,',');

flag = strcmp(C{1},type);

end

