% NX = 25; NY=25; NZ =26;
% GNX = (NX+4); GNY = (NY+4); GNZ =(NZ+10);
reportpath = '"/auto/rcf-proj/fz2/CMG/CMG2019/Unix/br/2019.10/linux_x64/exe/report.exe"';
%% Displacement in x,y,z

% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2014.10\Win_x64\EXE\report.exe" -f Grid_outputDisz.rwd -o Grid_outputDisz.rwo');
[STATUS RESULTS]=system([reportpath,' -f GeoGrid_outputDisz.rwd -o GeoGrid_outputDisz.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputDisz.rwd -o Grid_outputDisz.rwo');
GeoDispz = read_CMG_output('GeoGrid_outputDisz.rwo',GNX,GNZ,GNY);


%% effective plastic strain
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2014.10\Win_x64\EXE\report.exe" -f Grid_outputplsstrain.rwd -o Grid_outputplsstrain.rwo');
[STATUS RESULTS]=system([reportpath,' -f GeoGrid_outputplsstrain.rwd -o GeoGrid_outputplsstrain.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f Grid_outputplsstrain.rwd -o Grid_outputplsstrain.rwo');
Geoplsstrain = readfailure('GeoGrid_outputplsstrain.rwo',GNX,GNY,GNZ);


% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2014.10\Win_x64\EXE\report.exe" -f Grid_outputDisx.rwd -o Grid_outputDisx.rwo');
[STATUS RESULTS]=system([reportpath,' -f GeoGrid_safactor.rwd -o GeoGrid_safactor.rwo']);
% [STATUS RESULTS]=system('"C:\Program Files (x86)\CMG\BR\2016.11\Win_x64\EXE\report.exe" -f GeoGrid_safactor.rwd -o GeoGrid_safactor.rwo');
GeoSAFAC = readsafactor('GeoGrid_safactor.rwo',GNX,GNY,GNZ);


