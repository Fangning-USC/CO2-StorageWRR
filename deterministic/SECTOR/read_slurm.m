function output = read_slurm(infil)
fid = fopen(infil, 'r');C = textscan(fid, '%s', 'Delimiter', '\n');fclose(fid);
output = find(ismember(C{1}, 'MATLAB is exiting because of fatal error'));

