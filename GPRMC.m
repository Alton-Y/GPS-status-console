function [GPS] = GPRMC(raw, GPS)

% Recommended minimum specific GPS/Transit data
% eg3. $GPRMC,220516,A,5133.82,N,00042.24,W,173.8,231.8,130694,004.2,W*70
%               1    2    3    4    5     6    7    8      9     10  11 12
% 1   220516     Time Stamp
% 2   A          validity - A-ok, V-invalid
% 3   5133.82    current Latitude
% 4   N          North/South
% 5   00042.24   current Longitude
% 6   W          East/West
% 7   173.8      Speed in knots
% 8   231.8      True course
% 9   130694     Date Stamp
% 10  004.2      Variation
% 11  W          East/West
% 12  *70        checksum

% raw = '$GPRMC,024834.000,A,4339.5158,N,07922.6673,W,0.50,40.08,040417,,,A*44'

if checkType( raw, '$GPRMC' ) == 1
    
    C = splitSentance(raw);
    
    
    GPS.GPRMC.TimeStamp = str2double(C(1));
    
    if strcmp(C{2},'A') == 1
        GPS.GPRMC.Validity = 'OK';
    elseif strcmp(C{2},'V') == 1
        GPS.GPRMC.Validity = 'Invalid';
    else
        GPS.GPRMC.Validity = C{2};
    end
    
    
    
    if strcmp(C{4},'N') == 1
        NS = 1;
    else
        NS = -1;
    end
    if strcmp(C{6},'E') == 1
        EW = 1;
    else
        EW = -1;
    end
    
    GPS.GPRMC.Latitude = NS*(floor(str2double(C{3})/100)+rem(str2double(C{3}),100)/60);
    GPS.GPRMC.Longitude = EW*(floor(str2double(C{5})/100)+rem(str2double(C{5}),100)/60);
    
    
    GPS.GPRMC.SpeedInKnots = str2double(C(7));
    GPS.GPRMC.TrueCourse = str2double(C(8));
    GPS.GPRMC.DateStamp = str2double(C(9));
    
    if strcmp(C{11},'E') == 1
        VarEW = 1;
    else
        VarEW = -1;
    end
    
    GPS.GPRMC.Variation = VarEW*(str2double(C(10)));
    

    
    
else
    disp('Type Mismatch')
end







