% clc
% clear



% filename = 'C:\Users\GustAV\Google Drive\Ryerson UAV\Aventech Test\2017-04-13\04130411_cbit.out';
year = 2017;
month = 04;
day = 13;




% [ timeH, cbit1, cbit2 ] = importCBIT( filename );

cbitMat = cbitDecode(cbit1);
cbitMat2 = cbitDecode(cbit2);
TimeLOCAL = datenum(year,month,day,timeH,0,0);

CBIT.CBIT.MSK_GPS2_NAVSTAT   = cbitMat(:,1,1);
CBIT.CBIT.MSK_GPS2_AGE       = cbitMat(:,2,1);
CBIT.CBIT.MSK_CAN_BSOFF_RST  = cbitMat(:,3,1);
CBIT.CBIT.MSK_CAN_TXBUFOVR   = cbitMat(:,4,1);
CBIT.CBIT.MSK_CAN_RXBUFOVR   = cbitMat(:,1,2);
CBIT.CBIT.MSK_CAN_RXOVR      = cbitMat(:,2,2);
CBIT.CBIT.MSK_GPS1_NAVSTAT   = cbitMat(:,3,2);
CBIT.CBIT.MSK_GPS1_AGE       = cbitMat(:,4,2);
CBIT.CBIT.MSK_ORION_BITFAIL  = cbitMat(:,1,3);
CBIT.CBIT.MSK_ORION_MSGCOUNT = cbitMat(:,2,3);
CBIT.CBIT.MSK_ORION_COMM     = cbitMat(:,3,3);
CBIT.CBIT.MSK_ACC_RANGE      = cbitMat(:,4,3);
CBIT.CBIT.MSK_GYRO_RANGE     = cbitMat(:,1,4);
CBIT.CBIT.MSK_TRH_IO         = cbitMat(:,2,4);
CBIT.CBIT.MSK_IRS_DRATE      = cbitMat(:,3,4);
CBIT.CBIT.MSK_COP_IRS        = cbitMat(:,4,4);
CBIT.CBIT.MSK_COP_ADS        = cbitMat(:,1,5);
CBIT.CBIT.MSK_CAN_WARN       = cbitMat(:,2,5);
CBIT.CBIT.MSK_FAULT_PS       = cbitMat(:,3,5);
CBIT.CBIT.MSK_FAULT_BETA     = cbitMat(:,4,5);
CBIT.CBIT.MSK_FAULT_ALPHA    = cbitMat(:,1,6);
CBIT.CBIT.MSK_FAULT_BARO     = cbitMat(:,2,6);
CBIT.CBIT.MSK_ADS_DRATE_RNG  = cbitMat(:,3,6);
CBIT.CBIT.MSK_NUMRPTNG_WARN  = cbitMat(:,4,6);
CBIT.CBIT.MSK_ADS_ITEMP_RNG  = cbitMat(:,1,7);
CBIT.CBIT.MSK_RH_RNG         = cbitMat(:,2,7);
CBIT.CBIT.MSK_EXTEMP_RNG     = cbitMat(:,3,7);
CBIT.CBIT.MSK_PS_RNG         = cbitMat(:,4,7);
CBIT.CBIT.MSK_BETA_RNG       = cbitMat(:,1,8);
CBIT.CBIT.MSK_ALPHA_RNG      = cbitMat(:,2,8);
CBIT.CBIT.MSK_BARO_RNG       = cbitMat(:,3,8);
CBIT.CBIT.MSK_COP_EVNT       = cbitMat(:,4,8);

CBIT.CBIT2.MSK_FILTER_RESET          = cbitMat2(:,3,1);
CBIT.CBIT2.MSK_WARN_ICPEKF           = cbitMat2(:,4,1);
CBIT.CBIT2.MSK_WARN_PVTEKF           = cbitMat2(:,1,2);
CBIT.CBIT2.MSK_NO_RATE_INTEG         = cbitMat2(:,2,2);
CBIT.CBIT2.MSK_WARN_NOTALIVE_GPSUSB  = cbitMat2(:,3,2);
CBIT.CBIT2.MSK_WARN_NOTALIVE_IRS     = cbitMat2(:,4,2);
CBIT.CBIT2.MSK_WARN_NOTALIVE_ADS     = cbitMat2(:,1,3);
CBIT.CBIT2.MSK_SERIAL_OVRFLO_GPS2    = cbitMat2(:,2,3);
CBIT.CBIT2.MSK_SERIAL_OVRFLO_GPS1    = cbitMat2(:,3,3);
CBIT.CBIT2.MSK_DFLASH_IO_ERROR       = cbitMat2(:,4,3);
CBIT.CBIT2.MSK_ADPDAT_SERIAL_FAULT   = cbitMat2(:,1,4);
CBIT.CBIT2.MSK_IMUDAT_SERIAL_FAULT   = cbitMat2(:,2,4);
CBIT.CBIT2.MSK_ALFAT_GPS2COMM        = cbitMat2(:,3,4);
CBIT.CBIT2.MSK_ALFAT_GPS1COMM        = cbitMat2(:,4,4);
CBIT.CBIT2.MSK_ALFAT_CLOSEFILE       = cbitMat2(:,1,5);
CBIT.CBIT2.MSK_ALFAT_WRITEFILE       = cbitMat2(:,2,5);
CBIT.CBIT2.MSK_ALFAT_FWUPDATE        = cbitMat2(:,3,5);
CBIT.CBIT2.MSK_ALFAT_FILEOPEN        = cbitMat2(:,4,5);
CBIT.CBIT2.MSK_ALFAT_DIRLIST         = cbitMat2(:,1,6);
CBIT.CBIT2.MSK_ALFAT_MOUNT           = cbitMat2(:,2,6);
CBIT.CBIT2.MSK_ALFAT_IO              = cbitMat2(:,3,6);
CBIT.CBIT2.MSK_RTC_WARN              = cbitMat2(:,4,6);





%80400000
%001c0000









