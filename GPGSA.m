function [GPS] = GPGSA(raw, GPS)


% raw = '$GPGSA,A,3,03,19,17,12,24,02,06,28,,,,,1.28,0.99,0.81*06';
%
% eg2. $GPGSA,A,3,19,28,14,18,27,22,31,39,,,,,1.7,1.0,1.3*35
% 1    = Mode:
%        M=Manual, forced to operate in 2D or 3D
%        A=Automatic, 3D/2D
% 2    = Mode:
%        1=Fix not available
%        2=2D
%        3=3D
% 3-14 = IDs of SVs used in position fix (null for unused fields)
% 15   = PDOP
% 16   = HDOP
% 17   = VDOP

if checkType( raw, '$GPGSA' ) == 1
    
    C = splitSentance(raw);
    
    
    GPS.GPGSA.Mode = C{1};
    
    FixMode = str2double(C{2});
    
    if FixMode == 1
        GPS.GPGSA.FixMode = 'Fix not available';
    elseif FixMode == 2
        GPS.GPGSA.FixMode = '2D';
    elseif FixMode == 3
        GPS.GPGSA.FixMode = '3D';
    else
        GPS.GPGSA.FixMode = NaN;
    end
    
    SV = str2double(C(3:14));
    GPS.GPGSA.SV = sort(SV(~isnan(SV)));
    
    
    GPS.GPGSA.PDOP = str2double(C{15});
    GPS.GPGSA.HDOP = str2double(C{16});
    GPS.GPGSA.VDOP = str2double(C{17});
    
else
    disp('Type Mismatch')
end





















