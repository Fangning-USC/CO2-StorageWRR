from scipy.optimize import minimize
from numpy import loadtxt
import scipy.io
import os
from os.path import exists
import numpy as np
import shutil
import time
import random
import json
from forward_call_cmg_arcf_iter import forward_call_cmg_arcf_iter
from forward_call_cmg_arcf import forward_call_cmg_arcf

def function_call(input_x):
    
    # get main working dir
    main_dir = "/scratch1/fangninz/1_23_determ_opt_3var/avg"
    
    # load initial
    inum = 15 # 1th row
    ini_norm_all = scipy.io.loadmat('ini_well_norm.mat')
    x_initial = ini_norm_all['ini_well_norm'][inum]
    x_back = np.around((input_x * (x_initial[46] - x_initial[45]) + x_initial[45]),4)

    x_back[x_back<0] = 0


    ## check x_save
    # load x_save file
    x_save_ = scipy.io.loadmat('x_save.mat')
    x_save = np.around(x_save_['x_save'],4)
    
    # check if x_back is in x_save
    bool_array = (x_save == x_back).all(1)
    ind_iftrue = np.where(bool_array)
    if len(ind_iftrue[0]):
        ind_xsave = ind_iftrue[0][0]
    else:
        # if x_back not in x_save, save x_back in x_save
        x_save = np.concatenate((x_save, [x_back]), axis=0)
        # resave x_save.mat
        scipy.io.savemat('x_save.mat', {'x_save': x_save})
        ind_xsave = len(x_save) - 1
 
    
    # get fval from simulatioin
    if (exists('workspace'+str(ind_xsave)+'.mat')) or (exists('FM'+str(ind_xsave))): 
        # if file or FM folder exist, pass
        pass

    else:
        # run forward call in CMG
        forward_call_cmg_arcf_iter(int(ind_xsave))

            
    # wait until simulation result generated
    bool_check = [False]
    bool_pass = [True]
    
    while bool_check != bool_pass:
        os.chdir(main_dir)
        bool_check = []
        bool_check.append(exists('workspace' + str(ind_xsave) + '.mat'))
    time.sleep(30)

    os.chdir(main_dir)
    # load sim results
    f_all = scipy.io.loadmat('workspace' + str(ind_xsave) + '.mat')
    f = f_all['obj_val'][0][0]
    
    # print fval into txt   
    with open('fval_save_avg.txt', 'a') as file:
        file.write('*************** Func Call ***************\n')
        file.write('x_norm = ' + str(input_x) +'\n')
        file.write('x = ' + str(x_back) +'\n')
        file.write('f = ' + str(f) +'\n')
        file.write('*****************************************\n')
        file.write('\n')
        
    with open('LOAD_save_avg.txt', 'a') as file:
        file.write(str(ind_xsave) + ' ' + str(x_back[0]) + ' ' + str(x_back[1]) + ' ' + str(x_back[2]) + ' ' + str(f) +'\n')
        
        
    return f


def function_der(input_x):

    main_dir = "/scratch1/fangninz/1_23_determ_opt_3var/avg"
    input_x = np.array(input_x)
    delta = 1e-2

    # calculate u_norm
    u_norm = np.tile(input_x,(3,1))
    
    for iu in range(len(input_x)):
        u_intermed = input_x[iu] + delta
        u_norm[iu][iu] = u_intermed
        
    # concatenate input_x into u_norm
    u_norm = np.concatenate((u_norm, [input_x]), axis=0)
    
    # load initial
    inum = 15 # 10th row
    ini_norm_all = scipy.io.loadmat('ini_well_norm.mat')
    x_initial = ini_norm_all['ini_well_norm'][inum]
    
    # get true u
    u_back = np.around((u_norm * (x_initial[46] - x_initial[45]) + x_initial[45]),4)

    # process u_back to be positive
    u_back[u_back<0] = 0
    
    # calculate gradient
    g = der_run_realization(u_back)
    
    os.chdir(main_dir)
        
    # print gradient into txt   
    with open('fval_save_avg.txt', 'a') as file:
        file.write('***************** Grad Eval ********************\n')
        file.write('x = ' + str(u_back[-1]) +'\n')
        file.write('u = ' + str(u_back[:3]) +'\n')
        file.write('g = ' + str(g) +'\n')
        file.write('************************************************\n')
        file.write('\n')

    return g



def der_run_realization(u_back):
    main_dir = "/scratch1/fangninz/1_23_determ_opt_3var/avg"
    delta = 1e-2
    ## check u in x_save
    # 1. load x_save file
    os.chdir(main_dir)
    x_save_ = scipy.io.loadmat('x_save.mat')
    x_save = np.around(x_save_['x_save'],4)
    
    # 2. check if u_back is in x_save, one by one
    indu_in_xsave = []
    for iu, u_back_i in enumerate(u_back):
        os.chdir(main_dir)
        
        bool_array = (x_save == u_back_i).all(1)
        ind_iftrue = np.where(bool_array)
        
        if len(ind_iftrue[0]):
            ind_xsave = ind_iftrue[0][0]
            indu_in_xsave.append(ind_xsave)
        else:
            # if x_back not in x_save, save x_back in x_save
            x_save = np.concatenate((x_save, [u_back_i]), axis=0)
            # resave x_save.mat
            scipy.io.savemat('x_save.mat', {'x_save': x_save})
            ind_xsave = len(x_save) - 1
            indu_in_xsave.append(ind_xsave)

        os.chdir(main_dir)
        if (exists('workspace'+str(ind_xsave)+'.mat')) or (exists('FM'+str(ind_xsave))): 
            pass
        else:
            # run forward call in CMG
            forward_call_cmg_arcf(ind_xsave)
    
    # wait until all simulation results generated
    bool_check = [False, ] * 4
    bool_pass = [True, ] * 4

    while bool_check != bool_pass:
        bool_check = []
        for iu in range(len(u_back)):
            os.chdir(main_dir)
            bool_check.append(exists('workspace' + str(indu_in_xsave[iu]) + '.mat'))
    time.sleep(30)
    
    g_ = []
    for iu in range(len(u_back)):
        os.chdir(main_dir)
        f_all_g = scipy.io.loadmat('workspace' + str(indu_in_xsave[iu]) + '.mat')
        f_g = f_all_g['obj_val'][0][0]
        g_.append(f_g)
    
    # calculate gradient using forward FD
    g_ = np.array(g_)
    g__ = (g_[:3] - g_[-1]) / delta
    g = g__ / np.linalg.norm(g__)
    
    return g
