function output = readPermK_frac(infil,GNX,GNY,GNZ)
fid = fopen(infil, 'r');C = textscan(fid, '%s', 'Delimiter', '\n');fclose(fid);
indrow1 = find(ismember(C{1}, '''Permeability K - Fracture'' ''md'''));indrow = indrow1+ones(length(indrow1),1);

for ifa=1:length(indrow)
    ss{ifa} = C{1,1}(indrow(ifa):indrow(ifa)+ceil(GNX*GNY*GNZ/6-1),:);
end

for ifaa=1:size(ss,2)
    for jfa=1:length(ss{ifaa})-1
        strs{ifaa}((jfa-1)*6+1:jfa*6,1) = str2num(ss{1,ifaa}{jfa,1})';
    end
    strsend(:,ifaa) = str2num(ss{1,ifaa}{end,1})';
    
    output(:,ifaa) = [strs{ifaa};strsend(:,ifaa)];
end


end