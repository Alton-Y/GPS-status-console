function [ C ] = splitSentance( raw )
%SPLITSENTANCE Summary of this function goes here
%   Detailed explanation goes here
cs = strsplit(raw,'*','CollapseDelimiters',0);
C = strsplit(cs{1}, ',','CollapseDelimiters',0);
C = C(2:end);
end

