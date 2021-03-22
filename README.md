This is the repository for the Matlab and Python codes for generating the results in the manuscript: AI-driven prediction of SARS-CoV-2 variant binding trends from atomistic simulations, Sara Capponi, Shangying Wang, Simone Bianco, doi: https://doi.org/10.1101/2021.03.07.434295.

convert_data_to_image_subtract_moving_average.m: This is the matlab code for data preprocessing. This code preprocesses the raw distance matrices to the subtracted averaged matrices and then converts the matrices to grayscale images ready to be used as inputs to the Convolutional Neural Networks. 


CNN_predict_affinity_spike_protein_12mutations_N501Y_N501V_N501T_N501S_Q498N_N501D.ipynb: This is the Jupyter notebook Python code for predicting the binding trend from the grayscale images generated from the Matlab code above.

We also include the 1o trained neural networks in the folder "saved_CNN_model"

 If you find this code useful in your research, please consider citing:
 @article{capponi2021ai,
  title={AI-driven prediction of SARS-CoV-2 variant binding trends from atomistic simulations},
  author={Capponi, Sara and Wang, Shangying and Bianco, Simone},
  journal={bioRxiv},
  year={2021},
  publisher={Cold Spring Harbor Laboratory}
}
