#              ************************************
#              ****  RECORD VARYING VARIABLES  ****
#              ************************************
#
#  1. Default time
#  2. Average magnitude (average of |B| values in the interval)
#  3. Latitude (angle delta) of the field vector (where (0,0) is the positive Bx direction)
#  4. Longitude (angle lambda) of the field vector (where (0,0) is the positive Bx direction)
#  5. Magnetometer vector in GSM
#  6. S/C position vector in GSM
#
#
#              ************************************
#              ****  COLUMN HEADINGS  ****
#              ************************************
#   DATE	TIME	 MAGNITUDE	DELTA	LAMBDA	BX_GSM	BY_GSM	BZ_GSM	X_GSM	Y_GSM	Z_GSM
#   dd-mm-yyyy	hh:mm:ss.mil.mic	nT	degrees	degrees	nT	nT	nT	km	km	km
#
#
#
#              ************************************
#              *****    GLOBAL ATTRIBUTES    ******
#              ************************************
#
#     PROJECT                  RBSP>Radiation Belt Storm Probes
#     SOURCE_NAME              RBSPA>Radiation Belt Storm Probes A
#     DISCIPLINE               Solar Physics>Heliospheric Physics
#                              Space Physics>Magnetospheric Science
#     DATA_TYPE                L3>Level 3
#     DESCRIPTOR               EMFISIS>Electric and Magnetic Field Instrument
#     FILE_NAMING_CONVENTI     source_datatype_descriptor
#     DATA_VERSION             1
#     PI_NAME                  Craig Kletzing
#     PI_AFFILIATION           University of Iowa
#     TEXT                     3 axis Fluxgate Magnetometer data.  Sampled onboard at 64 vectors per second.                          
#     TEXT                       3 range states available,  Range 0 (+/- 256 nT),  Range 1 (+/- 4096 nT), Range                       
#                               3 (+/- 65536 nT).                                                                                     
#     INSTRUMENT_TYPE          Magnetic Fields (space)
#     MISSION_GROUP            Van Allen Probes (RBSP)
#     LOGICAL_SOURCE           rbsp-a_magnetometer_hires-gsm_emfisis-l3
#     LOGICAL_FILE_ID          rbsp-a_magnetometer_hires-gsm_emfisis-l3_00000000_v01
#     LOGICAL_SOURCE_DESCR     Fluxgate magnetometer data
#     TIME_RESOLUTION          1 second
#     GENERATED_BY             charles.smith@unh.edu
#     GENERATION_DATE          01/27/14
#     LINK_TEXT                EMFISIS data
#     LINK_TITLE               Current EMFISIS/MAG Issues, Caveats and Production Release Notes
#                              at Iowa
#                              Science Gateway (including Mission Rules of the Road for Data Usage)
#     HTTP_LINK                http://emfisis.physics.uiowa.edu/data/mag_release_notes
#                              http://emfisis.physics.uiowa.edu/
#                              http://athena.jhuapl.edu
#     RBSP_APID                0x292
#     RBSP_DATATYPE            Magnetometer
#     RBSP_MAG_HEADER          null  Nser = 20  Npts = 5529856   Data_Type = real  Coords. = GSM  Delta_t_sec                         
#     RBSP_MAG_HEADER           =  0.015625  Filename = rbspa-emfisis_mag-292_L3-hires-gsm_2012-11-08_v1.1.3.2.asc                    
#     RBSP_MAG_HEADER              Level-0_source_file = emfisis_rbspa_0071_292_03.ptp             Calibration                        
#     RBSP_MAG_HEADER           file = rbspa_2012_318_01.mcr                                                                          
#     RBSP_MAG_HEADER                                                                                                                 
#     RBSP_MAG_HEADER                     Level-0/1/2/3 packet information:                                                           
#     RBSP_MAG_HEADER                                     Data from spacecraft rbspa instrument emfisis/mag                           
#     RBSP_MAG_HEADER                                                    Number of 4-sec packets is: 21601                            
#     RBSP_MAG_HEADER                                                                    Number of original                           
#     RBSP_MAG_HEADER           packets is: 21601  and number of fill packets (if=1) is:     0          Number                        
#     RBSP_MAG_HEADER           of range changes (ir) and MAGinvalid packets (iM=1) are:     5 and     5                              
#     RBSP_MAG_HEADER                    Number of instrument CalState packets (iC=1) is:     0                                       
#     RBSP_MAG_HEADER                                    MET start/stop times with partition are: 1 / 0090028801:06503                
#     RBSP_MAG_HEADER           and 1 / 0090115205:11711     ET start/stop times are:    405604867.1361 and                           
#     RBSP_MAG_HEADER              405691271.2280                           UT start/stop times are: 2012 NOV                         
#     RBSP_MAG_HEADER           07 23:59:59.9534 and 2012 NOV 09 00:00:04.0453          iMAGinvalid flag for                          
#     RBSP_MAG_HEADER           degraded data due to range changes: iM=1 event count =  5  iM=1 range change                          
#     RBSP_MAG_HEADER           start = 313.0015735   iM=1 range change end = 313.0016198      iM=1 range change                      
#     RBSP_MAG_HEADER           MET times with partition:   1 / 0090028937:06515 -- 1 / 0090028941:06515  iM=1                        
#     RBSP_MAG_HEADER           range change start = 313.3340739   iM=1 range change end = 313.3341202                                
#     RBSP_MAG_HEADER            iM=1 range change MET times with partition:   1 / 0090057665:08437 -- 1 /                            
#     RBSP_MAG_HEADER           0090057669:08440  iM=1 range change start = 313.3764351   iM=1 range change                           
#     RBSP_MAG_HEADER           end = 313.3764814      iM=1 range change MET times with partition:   1 / 0090061325:08830             
#     RBSP_MAG_HEADER           -- 1 / 0090061329:08832  iM=1 range change start = 313.7081022   iM=1 range                           
#     RBSP_MAG_HEADER           change end = 313.7081485      iM=1 range change MET times with partition:                             
#     RBSP_MAG_HEADER            1 / 0090089981:10747 -- 1 / 0090089985:10745  iM=1 range change start = 313.7524078                  
#     RBSP_MAG_HEADER             iM=1 range change end = 313.7524541      iM=1 range change MET times with                           
#     RBSP_MAG_HEADER           partition:   1 / 0090093809:11163 -- 1 / 0090093813:11163                                             
#     RBSP_MAG_HEADER                                                                                                                 
#     RBSP_MAG_HEADER                                         Variable definitions:                                                   
#     RBSP_MAG_HEADER                                                                                                                 
#     RBSP_MAG_HEADER              Year is integer year in UT.                                                                        
#     RBSP_MAG_HEADER                                                            decimalday is floating point                         
#     RBSP_MAG_HEADER           f17.6 representation of day-of-year start of measurement Jan 1 = day 1.                               
#     RBSP_MAG_HEADER                            hr, min, sec, micro is integer representation of decimalday                          
#     RBSP_MAG_HEADER           time of day starting 00::00:00.000000.                       METtime is corrected                     
#     RBSP_MAG_HEADER           s/c clock time marking start of measurement.                                                          
#     RBSP_MAG_HEADER                                    Bx, By, Bz, Bmag are magnetic field values in corresponding                  
#     RBSP_MAG_HEADER           coordinate system.                                           Bmag is average                          
#     RBSP_MAG_HEADER           of all underlying |B| values within the averaging interval.                                           
#     RBSP_MAG_HEADER                                         Brms is the total standard deviation for measurements                   
#     RBSP_MAG_HEADER           within the averaging interval.                                     delta, lambda                      
#     RBSP_MAG_HEADER           are latitude and longitude of the field vector  where (0,0) is the positive                           
#     RBSP_MAG_HEADER           Bx direction.                  X, Y, Z is spacecraft location in corresponding                        
#     RBSP_MAG_HEADER           coordinate system.                                                       Badpoint                     
#     RBSP_MAG_HEADER           value for fill or otherwise removed measurements is -99999.9                                          
#     RBSP_MAG_HEADER                                                ir is range (0-3), iC is Calibration current                     
#     RBSP_MAG_HEADER           (1=on), iM is MAG data invalid (iM=1), and if is fill (if=1) flags.                                   
#     RBSP_MAG_HEADER           Year  decimalday hr min sec micro    part / METtime      Bx_GSM [nT]  By_GSM                          
#     RBSP_MAG_HEADER           [nT]  Bz_GSM [nT]   Bmag [nT] delta_GSM [deg] lambda_GSM [deg] X_GSM [km] Y_GSM                       
#                               [km] Z_GSM [km] ir iC iM if                                                                           
