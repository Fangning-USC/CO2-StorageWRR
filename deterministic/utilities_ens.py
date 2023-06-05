from scipy.optimize import minimize, rosen, rosen_der, rosen_hess
from numpy import loadtxt
import scipy.io
import os
from os.path import exists
import numpy as np
import shutil
import time
import random
import json
from forward_call_cmg_jaf_iter import forward_call_cmg_jaf_iter
from forward_call_cmg_jaf import forward_call_cmg_jaf

def function_call(input_x):
    
    # get main working dir
    main_dir = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var"
    main_dir_folder = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var/ens_1e2"

    os.chdir(main_dir)

    # load initial
    inum = 9 # 1th row
    n_p = 100 # no. of sampling
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
    

    realization_nums = list(range(1,101))
    
    # get fval from each realization
    for num in realization_nums:
        # cd to dir of realization
        path_reali = '/contribution70/realization' + str(num)
        os.chdir(main_dir + path_reali)
        
        if (exists('workspace'+str(ind_xsave)+'.mat')) or (exists('FM'+str(ind_xsave))): 
            # if file or FM folder exist, pass
            pass

        else:
            # run forward call in CMG
            forward_call_cmg_jaf_iter(int(ind_xsave))

            
            
    # wait until all simulation results generated
    bool_check = [False, ] * n_p
    bool_pass = [True, ] * n_p
    
    while bool_check != bool_pass:
        bool_check = []
        for num in realization_nums:
            path_reali = '/contribution70/realization' + str(num)
            os.chdir(main_dir + path_reali)
        
            bool_check.append(exists('workspace' + str(ind_xsave) + '.mat'))
            #print(('workspace' + str(int(indu_in_xsave[iu])) + '.mat'))
        #time.sleep(1)

    time.sleep(30)
    # initialize f_all_realization list to store f from all realizations
    f_all_realization = []
    for num in realization_nums:
        path_reali = '/contribution70/realization' + str(num)
        os.chdir(main_dir + path_reali)
        # load sim results
        f_all = scipy.io.loadmat('workspace' + str(ind_xsave) + '.mat')
        f = f_all['obj_val'][0][0]
        f_all_realization.append(f)
    f_all_mean = np.mean(f_all_realization)
    
    # cd back to main dir
    os.chdir(main_dir_folder)
    
    
    # print fval into txt   
    with open('fval_save_avg_1e2_ens.txt', 'a') as file:
        file.write('*************** Func Call ***************\n')
        file.write('x_norm = ' + str(input_x) +'\n')
        file.write('x = ' + str(x_back) +'\n')
        file.write('f_all_realization = ' + str(f_all_realization) +'\n')
        file.write('f_mean = ' + str(f_all_mean) +'\n')
        file.write('realization_nums = ' + str(realization_nums) +'\n')
        file.write('*****************************************\n')
        file.write('\n')
        
    with open('LOAD_save_avg_1e2_ens.txt', 'a') as file:
        file.write(str(ind_xsave) + ' ' + str(x_back[0]) + ' ' + str(x_back[1]) + ' ' + str(x_back[2]) + ' ' + str(f_all_mean) +'\n')
        
        
    return f_all_mean


def function_der(input_x):

    main_dir = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var"
    main_dir_folder = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var/ens_1e2"

    input_x = np.array(input_x)
    
    os.chdir(main_dir)

    delta = 1e-2
    n_p = 100 # no. of sampling
    # calculate u_norm
    u_norm = np.tile(input_x,(3,1))
    
    for iu in range(len(input_x)):
        u_intermed = input_x[iu] + delta
        u_norm[iu][iu] = u_intermed
        
    # concatenate input_x into u_norm
    u_norm = np.concatenate((u_norm, [input_x]), axis=0)
    
    # load initial
    inum = 9 # 10th row
    ini_norm_all = scipy.io.loadmat('ini_well_norm.mat')
    x_initial = ini_norm_all['ini_well_norm'][inum]
    
    # get true u
    u_back = np.around((u_norm * (x_initial[46] - x_initial[45]) + x_initial[45]),4)

    # process u_back to be positive
    u_back[u_back<0] = 0
    
    realization_nums = list(range(1,101))
    
    g_all = []
    indu_in_xsave_all = []
    for num_reali in realization_nums:
        indu_in_xsave_all.append(der_run_realization(num_reali, u_back))
        
    for num_reali, indu_in_xsave in zip(realization_nums, indu_in_xsave_all):
        g = der_check_realization(num_reali, u_back, indu_in_xsave)
        g_all.append(g)
    
    g_avg = np.mean(g_all, axis=0)
    
    os.chdir(main_dir_folder)
        
    # print gradient into txt   
    with open('fval_save_avg_1e2_ens.txt', 'a') as file:
        file.write('***************** Grad Eval ********************\n')
        file.write('x = ' + str(u_back[-1]) +'\n')
        file.write('u = ' + str(u_back[:3]) +'\n')
        file.write('g_all = ' + str(g_all) +'\n')
        file.write('g_avg = ' + str(g_avg) +'\n')
        file.write('************************************************\n')
        file.write('\n')

    return g_avg



def der_run_realization(reali, u_back):
    main_dir = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var"
    path_reali = '/contribution70/realization' + str(reali)

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
            

        os.chdir(main_dir + path_reali)
    
        if (exists('workspace'+str(ind_xsave)+'.mat')) or (exists('FM'+str(ind_xsave))): 
            pass
        else:
            # run forward call in CMG
            forward_call_cmg_jaf(ind_xsave)
    return indu_in_xsave

def der_check_realization(reali, u_back, indu_in_xsave):
    delta = 1e-2

    main_dir = "/scratch2/fangninz/11_07_robustOPT_Geomech_3var"
    path_reali = '/contribution70/realization' + str(reali)

    for iu, u_back_i in enumerate(u_back):
        os.chdir(main_dir)
    
        # wait until all simulation results generated
        bool_check = [False, ] * 4
        bool_pass = [True, ] * 4
        #print(indu_in_xsave)

        while bool_check != bool_pass:
            bool_check = []
            for iu in range(len(u_back)):
                os.chdir(main_dir + path_reali)
                bool_check.append(exists('workspace' + str(indu_in_xsave[iu]) + '.mat'))
                #print(('workspace' + str(int(indu_in_xsave[iu])) + '.mat'))
            
    
    time.sleep(1)
    
    g_ = []
    for iu in range(len(u_back)):
        os.chdir(main_dir + path_reali)
        f_all_g = scipy.io.loadmat('workspace' + str(indu_in_xsave[iu]) + '.mat')
        f_g = f_all_g['obj_val'][0][0]
        g_.append(f_g)
    
    # calculate gradient using forward FD
    g_ = np.array(g_)
    g__ = (g_[:3] - g_[-1]) / delta
    g = g__ / np.linalg.norm(g__)
    
    return g
