function [DATA ] = rsm2mtx(infil,numfullrows,numcols,nc,TEXTGAP)

%%  READ WELL OBSERVATION DATA FROM .RMS FILE

fprintf(1,' .. Reading simulated observation from %s ..\n',infil);

fid = fopen(infil,'r');
if(fid == -1)
    fprintf(1,'\nERROR: input file %s not opened\n',infil);
    return;
end

% .. read in numeric data
DATA = [];
% TEXTGAP = 9;
% read full row/col set (including first row trimmed for dates)
% numfullrows = 3;
for NSET = 1:numfullrows
    if(NSET == 1)
        TEMP     = textscan(fid,'%n','headerlines',TEXTGAP);
        TEMPDATA = reshape(TEMP{1},nc,ceil(length(TEMP{1})/nc))';
        
        % use col 2 = years
        DATA = [DATA TEMPDATA(:,1) TEMPDATA(:,2:end)]; clear TEMP TEMPDATA
         clear TEMP TEMPDATA2
    else
        TEMP     = textscan(fid,'%n','headerlines',TEXTGAP-1);
        TEMPDATA = reshape(TEMP{1},nc,ceil(length(TEMP{1})/nc))';
        DATA = [DATA TEMPDATA(:,2:end)]; clear TEMP TEMPDATA
    end
end

% numcols = 7;
TEMP = textscan(fid,'%n','headerlines',TEXTGAP-1);
TEMPDATA = reshape(TEMP{1},numcols,ceil(length(TEMP{1})/numcols))';
DATA = [DATA TEMPDATA(:,2:end)]; clear TEMP TEMPDATA

fclose(fid);


%%  build struct
% .. initialize struct
% local_struct = struct([]);
% 
% % .. define datatype arrays
% types = {'FGPR'  'FGPT'};
% wells = {'Pro1'};
% 
% % .. build struct
% %    note: the datatypes are hardwired
% 
% tsteps = size(DATA,1);
% cnt    = 0;
% 
% for i = 1:length(types)
%     for j = 1:length(wells)
%         for t = 1:tsteps
%             cnt = cnt + 1;
%             local_struct(cnt).type  = types(i);
%             local_struct(cnt).well  = wells(j);
%             local_struct(cnt).year  = DATA(t,1);
%             data_col = i+1;
%             local_struct(cnt).datum = DATA(t,data_col);
%         end
%     end
% end