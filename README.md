# Variational Autoenoder
## For 2025 LSI Design Contest in Okinawa

## Team Name : CASP-er

## Goals
This repo aim to implement Variational Autoencoder algorithm. 


## Running Testbench 🚀
Run testbench from this project root directory or move to subfunction directory. Testbench is run using iverilog. The files used in the testbench are inside the txt files. This testbench can run directly on **Windows OS** systems. Other OS, change file directory path on the txt file.
To run the testbench, use the following command: 

```
iverilog.exe -c <txt_file.txt>
```

Then to run the program, do the following:

```
vvp a.out
```

## Database
The dataset used is the WM-811K dataset that can be obtained in this [link](http://mirlab.org/dataset/public/)