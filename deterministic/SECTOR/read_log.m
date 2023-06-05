function output = read_log(infil)

% if exist(infil) > 0
fid = fopen(infil, 'r');C = textscan(fid, '%s', 'Delimiter', '\n');fclose(fid);
output = find(ismember(C{1}, 'Simulator preparing to halt: Licensing unavailabilty.'));
% else
%     output = 1;
end

