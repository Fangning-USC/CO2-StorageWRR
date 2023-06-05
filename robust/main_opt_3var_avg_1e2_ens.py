from scipy.optimize import minimize, rosen, rosen_der, rosen_hess
from numpy import loadtxt
import scipy.io
import os
from os.path import exists
import numpy as np
import shutil
import time
import random
from utilities_ens import function_call, function_der, der_run_realization, der_check_realization

main_dir = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var"
   
print('opt_3var_main_avg_1e2')

# delete txt files
if exists("fval_save_avg_1e2_ens.txt"):
   os.remove("fval_save_avg_1e2_ens.txt")
if exists("LOAD_save_avg_1e2_ens.txt"):
   os.remove("LOAD_save_avg_1e2_ens.txt")

os.chdir(main_dir)
# load initializations
ini_norm_all = scipy.io.loadmat('ini_well_norm.mat')
x_initial = ini_norm_all['ini_well_norm'][9] # 10th row

lb = (0-x_initial[-2])/(x_initial[-1] - x_initial[-2])
ub = (583914-x_initial[-2])/(x_initial[-1] - x_initial[-2])

# And variables must be positive, hence the following bounds:
bnds = ((lb, ub), (lb, ub), (lb, ub))

# Define constriants
cons = ({'type': 'eq', 'fun': lambda x:  x[0] + x[1] + x[2] - sum(x_initial[:3])}) # constrain sum of x_norm

# Define constrained optimization & settings using Sequential Least Squares Programming
res = minimize(function_call, x_initial[:3], method='SLSQP', jac=function_der, bounds=bnds,
               tol=1e-10, constraints=cons, options={'disp': True}) #'initial_tr_radius': 10,'verbose': 3  'SLSQP', trust-constr, 'disp': True

#res = minimize(function_call, x_initial[:3], method='trust-constr', jac=function_der, bounds=bnds,
#               tol=1e-10, constraints=cons, options={'initial_tr_radius': 10, 'verbose': 3}) #options={'disp': True}) #callback=callbackF, jac=forward_call_jac, bounds=bnds, trust-constr, initial_tr_radius
