function MY_Output_CMG (timet,t_n,TI)

% change (it) to a specific time step if don't want to output all time

% displacement in i,j,k
FIDPERM = fopen('GeoGrid_outputDisx.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''Displacement Along X'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 
 
FIDPERM = fopen('GeoGrid_outputDisy.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''Displacement Along Y'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 

FIDPERM = fopen('GeoGrid_outputDisz.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''Displacement Along Z'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 

% effective stress ijk
FIDPERM = fopen('GeoGrid_outputstrx.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESI'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 


FIDPERM = fopen('GeoGrid_outputstry.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESJ'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 


FIDPERM = fopen('GeoGrid_outputstrz.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESK'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 



% von mises stress
FIDPERM = fopen('GeoGrid_outputvms.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''VMSTRESS'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 

% total stress
FIDPERM = fopen('GeoGrid_outputtotls.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESSM'' %d \n',[timet(it)]);    
end
fclose(FIDPERM);

% Shear stress ij,ik,jk
FIDPERM = fopen('GeoGrid_outputshearij.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESSHIJ'' %d \n',[timet(it)]);    
end
fclose(FIDPERM);


FIDPERM = fopen('GeoGrid_outputshearik.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESSHIK'' %d \n',[timet(it)]);    
end
fclose(FIDPERM);


FIDPERM = fopen('GeoGrid_outputshearjk.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESSHJK'' %d \n',[timet(it)]);    
end
fclose(FIDPERM);


FIDPERM = fopen('GeoGrid_outputstrmin.rwd','w'); % minimum stress
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESMNP'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 


FIDPERM = fopen('GeoGrid_outputstrmax.rwd','w');% maximum stress
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRESMXP'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 


FIDPERM = fopen('GeoGrid_outputpres.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''PRES'' %d \n',[timet(it)]);    
end
fclose(FIDPERM); 

FIDPERM = fopen('GeoGrid_outputplsstrain.rwd','w'); % effective plastic strain
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRNEPL'' %d *SRF-FORMAT\n',[timet(it)]);   
end
fclose(FIDPERM);

FIDPERM = fopen('GeoGrid_safactor.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''Safety Factor'' %d *SRF-FORMAT\n',[timet(it)]);    
end
fclose(FIDPERM); 

FIDPERM = fopen('GeoGrid_strainvol.rwd','w');
fprintf(FIDPERM,'FILE ''Main_data.gmch.irf'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',[timet]);
fprintf(FIDPERM,'\n');
for it=1:t_n(TI)+1
fprintf(FIDPERM,'*PROPERTY-FOR ''STRAINVOL'' %d *SRF-FORMAT\n',[timet(it)]);    
end
fclose(FIDPERM); 
end