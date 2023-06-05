reportpath = '"/project/jafarpou_227/CMG/2019/br/2019.10/linux_x64/exe/report.exe"';

%% Min Stress
[STATUS RESULTS]=system([reportpath,' -f Grid_outputminS.rwd -o Grid_outputminS.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputpres.rwd -o Grid_outputpres.rwo');
MinStress = readStress('Grid_outputminS.rwo',NX,NY,NZ);

%% Sector CO2 in place
[STATUS RESULTS]=system([reportpath,' -f Grid_sec_field.rwd -o Grid_sec_field.rwo']);
output_sector = read_sector('Grid_sec_field.rwo',ntsteps);

%% Perm K frac
[STATUS RESULTS]=system([reportpath,' -f Grid_output_permK_frac.rwd -o Grid_output_permK_frac.rwo']);
permK_frac = readPermK_frac('Grid_output_permK_frac.rwo',NX,NY,NZ);

