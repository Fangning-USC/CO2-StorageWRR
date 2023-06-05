function output_sector = read_sector(infil,ntsteps)

fid = fopen(infil, 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');

for ii=1:length(C{1,1})
    s{ii,1} = C{1, 1}{ii, 1};
end
idx = strfind(s,'day                                   gmole');
ind_s = find(~cellfun(@isempty,idx));

output_sector = [];
for i=1:length(ind_s)
    for j=1:ntsteps+1
        output_sector{i}(j,:) = str2num(s{ind_s(i)+1+j, 1});
    end
end
