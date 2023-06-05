function diff_norm_out = calulate_frsstress(minStress)
load('/scratch1/fangninz/11_07_robustOPT_Geomech_3var/frs.mat')

MinStress_3d_end = reshape(minStress,38,30,30,16);
minStress_1d = reshape(MinStress_3d_end(5:34,:,6:10,:),30*30*5,16);
frs_1d = reshape(frs,30*30*5,1);
diff = minStress_1d - frs_1d;
for id=1:size(diff,2)
    diff_norm(id) = norm(diff(:,id));
end
diff_norm_out = diff_norm(end);