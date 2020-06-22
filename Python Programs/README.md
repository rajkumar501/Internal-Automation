Compare_images.py will be executed to compare the image differences using CSV file input, following are the steps for environmnet setup:

Required Python version : Python3+
Platforms compatible: Windows / MACOS / Linux

Install Dependencies:

$ pip3 install requirements.txt

Samples:

Samples of Images are given in Images/ to try in sample images.csv file 

Usage:

$ cd <path-to-the-script>
  
$ python3 compare_images.py -h 
  usage: compare_images.py [-h] -f FILE_PATH

  optional arguments:
    -h, --help            show this help message and exit
    -f FILE_PATH, --file-path FILE_PATH
                        Please provide the full path to the csv file
                        
$ python3 compare_images.py  -f <file_path_csv>

Output:

Output's result.csv in same folder with required comparision analysis





