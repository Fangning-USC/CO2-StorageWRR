function output = read_super(infil,colnum)
fid = fopen(infil, 'r');C = textscan(fid, '%s', 'Delimiter', '\n');fclose(fid);
% indrow1 = find(ismember(C{1}, 'GHGSCRIT'));indrow = indrow1+3;

for ifaa=colnum:colnum+15
    output(ifaa-colnum+1,:) = str2num(C{1, 1}{ifaa, 1}  );
end
end
