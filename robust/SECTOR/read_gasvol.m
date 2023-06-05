function output_vol = read_gasvol(infil,ntsteps)
fid = fopen(infil, 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
for iiii=1:length(C{1, 1})
    s{iiii,1} = C{1, 1}{iiii, 1};
end
% length(lb_input)

for iii=9:(9+ntsteps):length(s)
    for jj=1:ntsteps+1
        output1(iii+jj-1,:) = str2num(s{iii+jj-1, 1});
    end
end
output_row = find(output1(:,1));

for ii=1:length(output_row)
    output_vol(ii,:) = output1(output_row(ii),:);
end





