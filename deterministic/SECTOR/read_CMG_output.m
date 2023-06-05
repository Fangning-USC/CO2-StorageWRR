%% reading outputs
function [output ] = read_CMG_output(filename,NX,NZ,NY)

fid = fopen(filename, 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
line_read1 = ['**  K = ',num2str(1),', J = ',num2str(1)];
rows1 = find(ismember(C{1}, line_read1));

if NY==1
    line_read2 = ['**  K = ',num2str(2),', J = ',num2str(1)];
    rows2 = find(ismember(C{1}, line_read2));    
else
    line_read2 = ['**  K = ',num2str(1),', J = ',num2str(2)];
    rows2 = find(ismember(C{1}, line_read2));
end

if isempty(rows1)==1
    output = zeros(NX*NY*NZ,1);
    return
end

nd = rows2(1)-1- (rows1(1)+1)+1;

for k=1:NZ
    for j=1:NY
    % fid = fopen(filename, 'r');
    % C = textscan(fid, '%s', 'Delimiter', '\n');
    % fclose(fid);
    line_read = ['**  K = ',num2str(k),', J = ',num2str(j)];
    %// Search a specific string and find all rows containing matches
    % D = strfind(C{1}, '**  K = 1, J = 1');
    % D = strfind(C{1}, line_read);
    % rows = find(~cellfun('isempty', D));
    rows = find(ismember(C{1}, line_read));
    clear kfn;
    kfn(1) = (k-1)*NX*NY+(j-1)*NX;
        for TS =1:length(rows)
            for ij=1:nd
                clear STRESS_temp;
                STRESS_temp = str2num (C{1,1}{rows(TS)+ij,1});
                kfn(ij+1) = length (STRESS_temp)+kfn(ij);
                output(kfn(ij)+1:kfn(ij+1),TS) = STRESS_temp;
            end
        end
    end
end




end



