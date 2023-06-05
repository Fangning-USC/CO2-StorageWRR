function output = readfailure(infil,GNX,GNY,GNZ)
fid = fopen(infil, 'r');C = textscan(fid, '%s', 'Delimiter', '\n');fclose(fid);
indrow1 = find(ismember(C{1}, '''Effective Plastic Strain - Matrix'' '''''));indrow = indrow1+ones(length(indrow1),1);

for ifa=1:length(indrow)
    ss{ifa} = C{1,1}(indrow(ifa):indrow(ifa)+(GNX*GNY*GNZ/6-1),:);
end

for ifaa=1:size(ss,2)
    for jfa=1:length(ss{ifaa})
    strs{ifaa}(jfa,:) = str2num(ss{1,ifaa}{jfa,1});
    end
    output(:,ifaa) = reshape(strs{ifaa}',GNX*GNY*GNZ,1);
end
end

