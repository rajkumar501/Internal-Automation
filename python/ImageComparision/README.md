# Compare Images for similarity

Compare the Images for visual similarity

## Getting Started

#### Clone the repository
```
git clone https://github.com/rajkumar501/Internal-Automation.git
git checkout develop
```


### Prerequisites

#### Required Version : Python 3.6+ , Python 3.7.7 is best recommended version to use

```
$ pip3 install -r requirements.txt
```

#### Prepare the CSV file as in sample provided 
```
$ ./image.csv
```
##### Take Images from any path but for testing can also the sample images in folder

```
$ Images/
```

### Running the Util


Check usage using -h option

```
$ python3 compare_images.py -h 
  usage: compare_images.py [-h] -f FILE_PATH

  optional arguments:
    -h, --help            show this help message and exit
    -f FILE_PATH, --file-path FILE_PATH
                        Please provide the full path to the csv file
```

Run the util as follows :

```
$ python3 compare_images.py  -f <file_path_csv>

```

## Output

Expected output will be result.csv file as in sample in the project folder

```
$ result.csv

```

### Similarity Scale

###### (Similar) 0 - 1 (Not similar)

ex. 0.23 is more similar than 0.50 which is more near to value 1 

## Versioning
version 1.0.0


## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc











