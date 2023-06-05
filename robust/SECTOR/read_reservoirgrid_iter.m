reportpath = '"/project/jafarpou_227/CMG/2019/br/2019.10/linux_x64/exe/report.exe"';
% reportpath = '"C:\Program Files (x86)\CMG\BR\2019.10\Win_x64\EXE\report.exe"';

% %% Cumulative Gas Volume SC, m^3
% [STATUS RESULTS]=system([reportpath,' -f Cumulative_GasVol.rwd -o Cumulative_GasVol.rwo']);
% CO2_cumVolume = read_gasvol('Cumulative_GasVol.rwo',ntsteps);CO2_Volume=0;
% for ivol=1:3
%     CO2_Volume = CO2_Volume+CO2_cumVolume(ivol*(ntsteps+1),2);
% end
% %% Cumulative Gas Volume RC, m^3
% [STATUS RESULTS]=system([reportpath,' -f Cumulative_GasVolRC.rwd -o Cumulative_GasVolRC.rwo']);
% CO2_cumVolumeRC = read_gasvol('Cumulative_GasVolRC.rwo',ntsteps);CO2_VolumeRC=0;
% for ivol=1:3
%     CO2_VolumeRC = CO2_VolumeRC+CO2_cumVolumeRC(ivol*(ntsteps+1),2);
% end
% %% Cumulative Gas Mass SC, kg
% [STATUS RESULTS]=system([reportpath,' -f Cumulative_Gasmass.rwd -o Cumulative_Gasmass.rwo']);
% CO2_cumMass=[];CO2_cumMass = read_gasmass('Cumulative_Gasmass.rwo',ntsteps);CO2_mass = 0;
% for ivol=1:3
%     CO2_mass = CO2_mass+CO2_cumMass(ivol*(ntsteps+1),2);
% end


%% CO2 plume
[STATUS RESULTS]=system([reportpath,' -f Grid_outputplum.rwd -o Grid_outputplum.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
CO2Plume = readPlume('Grid_outputplum.rwo',NX,NY,NZ);

%% CO2 plume frac
[STATUS RESULTS]=system([reportpath,' -f Grid_outputplum_frac.rwd -o Grid_outputplum_frac.rwo']);
CO2Plume_frac = readPlume_frac('Grid_outputplum_frac.rwo',NX,NY,NZ);

%% Pressure
[STATUS RESULTS]=system([reportpath,' -f Grid_outputpres.rwd -o Grid_outputpres.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
Pressure = readPressure('Grid_outputpres.rwo',NX,NY,NZ);

%% Pressure
[STATUS RESULTS]=system([reportpath,' -f Grid_output_press_frac.rwd -o Grid_output_press_frac.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
Pressure_frac = readPressure_frac('Grid_output_press_frac.rwo',NX,NY,NZ);


%% Perm K frac
[STATUS RESULTS]=system([reportpath,' -f Grid_output_permK_frac.rwd -o Grid_output_permK_frac.rwo']);
permK_frac = readPermK_frac('Grid_output_permK_frac.rwo',NX,NY,NZ);

%% Sector CO2 in place
[STATUS RESULTS]=system([reportpath,' -f Grid_sec_field.rwd -o Grid_sec_field.rwo']);
output_sector = read_sector('Grid_sec_field.rwo',ntsteps);

% %% VMS
% [STATUS RESULTS]=system([reportpath,' -f Grid_outputvms.rwd -o Grid_outputvms.rwo']);
% % [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
% VonMises = read_CMG_output('Grid_outputvms.rwo',NX,NZ,NY);
% 
% %% Mean Total Stress
% [STATUS RESULTS]=system([reportpath,' -f Grid_outputmeanTotS.rwd -o Grid_outputmeanTotS.rwo']);
% % [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
% MeanTotStress = read_CMG_output('Grid_outputmeanTotS.rwo',NX,NZ,NY);
% 
%% Min Stress
[STATUS RESULTS]=system([reportpath,' -f Grid_outputminS.rwd -o Grid_outputminS.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
MinStress = readStress('Grid_outputminS.rwo',NX,NY,NZ);

% %% Dz
% [STATUS RESULTS]=system([reportpath,' -f Grid_outputDisz.rwd -o Grid_outputDisz.rwo']);
% % [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
% dispz = read_CMG_output('Grid_outputDisz.rwo',NX,NZ,NY);





