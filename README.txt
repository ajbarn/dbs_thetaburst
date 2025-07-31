#README

Output from CONN toolbox from loni are used to calculate the network level effects

Needed files:
1. realigned and transformed to MNI space file (e.g. wrEP2D_BOLD_MOCO_P2_3MM_0002_ep2d_bold_moco_p2_3mm_*_2.nii)
    a. a key to know which file belongs to which CONN_ID called 'epi_filenames.xlsx' (e.g. DBSSTIM_S002 and Subject001)
2. Atlas file in MNI space (e.g. "Schaefer2018_200Parcels_7Networks_order_FSLMNI152_2mm.nii.gz")
3. 'Schaefer2018_200Parcels_7Networks_order_FSLMNI152_2mm.Centroid_RAS.csv'
4. co-variates (e.ge. age, implant duration)
5. 'resultsROI_Subject***_Condition***.mat'


Steps
1. create filelist of MNI files or add new files to the existing filelist.txt (e.g. wrEP2D_BOLD_MOCO_P2_3MM_0002_ep2d_bold_moco_p2_3mm_*_2.nii)
2. run trim_TR.sh to remove the first 5 TRs from the nifti files
3. run tsnr_calc.sh to calculate the voxelwise tSNR across the brain saved as *.nii
4. create a tSNR file list of the new voxelwise tNSR niftis
5. run calc_avg_tsnr_roi.ipnyb to calculate the average tSNR within the ROIs in your atlas which will produce 'tsnr_schaeffer_df.csv'
6. run "DBS_statistical_analysis" which will load in the 'resultsROI_Subject***_Condition***.mat'
    a. this will load in:
        epi_filenames = pd.read_excel('epi_filenames.xlsx')
        tsnr_schaeffer_df = pd.read_csv('/Users/alexbarnett/Documents/DBS_theta_burst/epis/tsnr_results/tsnr_schaeffer_df.csv')
        roi_list = pd.read_csv('Schaefer2018_200Parcels_7Networks_order_FSLMNI152_2mm.Centroid_RAS.csv')
        data = loadmat('resultsROI_'+sub_list[0]+'_'+cond_list[0]+'.mat')
    b. will create figures for network to network FC
