fid = fopen('callCMG.slurm', 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
ss(1,1) =(C{1, 1}(9,1));
ss(1,1) = erase(ss(1,1),'# ');
input_ind = str2num(ss{1,1});
format long


%% Aquifer size (# grids in x, y and z direction and grid size)
NX=38;
NY=30;
NZ=30;

ntsteps = 15; %year
ntsteps2 = 30; %year
%% Output
t_n=1:ntsteps;
timet = 0:365:t_n(end)*365;
timet(1)=0;
TI=length(t_n);
timet2 = 0:365:t_n(end)*365;
timet2(1)=0;

load('/scratch1/fangninz/1_23_determ_opt_3var/avg/x_save.mat')


well_rate = repmat(x_save(input_ind+1,:),1,15);
%% Print well rate
for ir=1:length(well_rate)
    delete (['well_rate',num2str(ir),'.IN']);
    FIDPERM = fopen(['well_rate',num2str(ir),'.IN'],'w');
    fprintf(FIDPERM,'OPERATE *MAX *STG %.4f CONT\n',[well_rate(ir)]);
    fclose(FIDPERM);
end

% Output at specific time/all time
MY_Output_CMG(timet,t_n,TI,timet2);
% MY_Output_CMG_Geo(timet,t_n,TI);

%% Call CMG
[STATUS RESULTS]=system('"/project/jafarpou_227/CMG/2019/gem/2019.10/linux_x64/exe/gm201910.exe" -f Main_data.dat -log');

read_reservoirgrid;

total_leak_mole = 0;

% calculate norm diff minStress (at last time step)
diff_norm_out = calulate_frsstress(MinStress);

if isempty(find(permK_frac>1)) == 0
    % calculate total leakage
    total_leak_mole = (output_sector{1, 4}(end,2)-output_sector{1, 4}(1,2)) + ...
        (output_sector{1, 5}(end,2)-output_sector{1, 5}(1,2)) + ...
        (output_sector{1, 7}(end,2)-output_sector{1, 7}(1,2));
    escape_ratio = 1 - output_sector{1, 6}(end,2) / output_sector{1, 1}(end,2);
end

obj_val = -diff_norm_out + total_leak_mole.^2;

x_save=[];

cd ..

save(['workspace',num2str(input_ind),'.mat'])
rmdir(['FM',num2str(input_ind)],'s');

