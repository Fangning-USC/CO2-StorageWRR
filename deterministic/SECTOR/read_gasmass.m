function output_mass = read_gasmass(infil,ntsteps)
fid = fopen(infil, 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
for ii=1:length(C{1,1})
    s{ii,1} = C{1, 1}{ii, 1};
end

for iii=11:(11+ntsteps):length(s)
    for jj=1:ntsteps+1
        output1(iii+jj-1,:) = str2num(s{iii+jj-1, 1});
    end
end
output_row = find(output1(:,1));
for iiii=1:length(output_row)
    output_mass(iiii,:) = output1(output_row(iiii),:);
end
