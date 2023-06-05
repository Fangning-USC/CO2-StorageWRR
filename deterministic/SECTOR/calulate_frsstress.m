function diff_norm_out = calulate_frsstress(minStress)
load('/scratch1/fangninz/1_23_determ_opt_3var/avg/frs.mat')

MinStress_3d_end = reshape(minStress,38,30,30,16);
minStress_1d = reshape(MinStress_3d_end(5:34,:,6:10,:),30*30*5,16);
frs_1d = reshape(frs,30*30*5,1);
diff = minStress_1d - frs_1d;
for id=1:size(diff,2)
    diff_norm(id) = norm(diff(:,id));
end
diff_norm_out = diff_norm(end);