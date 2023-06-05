function MY_Output_CMG (timet,t_n,TI,timet2)

% % change (it) to a specific time step if don't want to output all time
% FIDPERM = fopen('GasRateRC.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR   *WELLS  *ALL\n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Gas Rate RC'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% 
% FIDPERM = fopen('Cumulative_GasVol.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR   *WELLS  *ALL\n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Cumulative Gas SC'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% FIDPERM = fopen('Cumulative_GasVolRC.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR   *WELLS  *ALL\n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Cumulative Gas RC'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM);
% 
% FIDPERM = fopen('Cumulative_Gasmass.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR   *WELLS  *ALL\n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Cumulative Gas Mass(CO2) SC'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% FIDPERM = fopen('SpeciallHist_dis.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR \n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *SPECIALS ''GHGSOL'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% 
% FIDPERM = fopen('SpeciallHist_Aqu.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR \n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *SPECIALS ''GHGAQU'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% 
% FIDPERM = fopen('SpeciallHist_super.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR \n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *SPECIALS ''GHGSCRIT'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 
% 
% 
% FIDPERM = fopen('SpeciallHist_trap.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet2]);
% fprintf(FIDPERM,'\n');
% fprintf(FIDPERM,'*TABLE-FOR \n');  
% fprintf(FIDPERM,'*COLUMN-FOR  *SPECIALS ''GHGTHY'' *PRECISION 8 *WIDTH 16\n');  
% fprintf(FIDPERM,'*TABLE-END\n');  
% fclose(FIDPERM); 

% gas sat
FIDPERM = fopen('Grid_outputplum.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR ''Gas Saturation''  %d *SRF-FORMAT\n',[timet(it)]);  %d \n',[timet(it)]);    
end
fclose(FIDPERM); 

% fracture gas sat
FIDPERM = fopen('Grid_outputplum_frac.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR *FRACTURE ''Gas Saturation'' %d *SRF-FORMAT\n',[timet(it)]);  %d \n',[timet(it)]);    
end
fclose(FIDPERM); 


% pressure
FIDPERM = fopen('Grid_outputpres.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR ''PRES'' %d *SRF-FORMAT\n',[timet(it)]);    
end
fclose(FIDPERM); 

% fracture permeability
FIDPERM = fopen('Grid_output_permK_frac.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR *FRACTURE ''Permeability K'' %d *SRF-FORMAT\n',[timet(it)]);    
end
fclose(FIDPERM); 

% fracture pressure
FIDPERM = fopen('Grid_output_press_frac.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR *FRACTURE ''Pressure'' %d *SRF-FORMAT\n',[timet(it)]);    
end
fclose(FIDPERM); 

% sector
FIDPERM = fopen('Grid_sec_field.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet2]);
fprintf(FIDPERM,'\n');
fprintf(FIDPERM,'*TABLE-FOR   *SECTORS  *ALL\n');  
fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Gas Moles IPF(CO2)'' *PRECISION 32 *WIDTH 16\n');  
fprintf(FIDPERM,'*TABLE-END\n');  
fclose(FIDPERM); 

% % von mises stress
% FIDPERM = fopen('Grid_outputvms.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet]);
% fprintf(FIDPERM,'\n');
% for it=1:length(timet)
% fprintf(FIDPERM,'*PROPERTY-FOR ''VMSTRESS'' %d \n',[timet(it)]);    
% end
% fclose(FIDPERM); 
% 
% % Mean Total Stress
% FIDPERM = fopen('Grid_outputmeanTotS.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet]);
% fprintf(FIDPERM,'\n');
% for it=1:length(timet)
% fprintf(FIDPERM,'*PROPERTY-FOR ''Mean Total Stress'' %d \n',[timet(it)]);    
% end
% fclose(FIDPERM); 
% 
% Min Stress
FIDPERM = fopen('Grid_outputminS.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:length(timet)
fprintf(FIDPERM,'*PROPERTY-FOR ''Minimum Stress'' %d *SRF-FORMAT \n',[timet(it)]);    
end
fclose(FIDPERM); 
% 
% 
% % displacement in z
% FIDPERM = fopen('Grid_outputDisz.rwd','w');
% fprintf(FIDPERM,'FILE ''Main_data.irf'' \n'); 
% fprintf(FIDPERM,'*TIMES-FOR \n');  
% fprintf(FIDPERM,'%d ',[timet]);
% fprintf(FIDPERM,'\n');
% for it=1:length(timet)
% fprintf(FIDPERM,'*PROPERTY-FOR ''Displacement Along Z'' %d \n',[timet(it)]);    
% end
% fclose(FIDPERM); 
