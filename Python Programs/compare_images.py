#imports required
from csv import DictReader
import csv
from lib.Image import ImageDiff
import argparse
import cv2 
from timeit import default_timer as timer


#Create Argument parser object
parser = argparse.ArgumentParser()
#Create argument for program
parser.add_argument('-f', '--file-path', help="Please provide the full path to the csv file", required=True)



#Variables
args = parser.parse_args()
csv_file = args.file_path
sift = cv2.xfeatures2d.SIFT_create()
cv_obj = cv2
image_inst = ImageDiff(cv_obj,sift)
dict_csv = []
csv_columns = ['image1', 'image2', 'similar', 'elapsed in sec']
csv_out_file = "result.csv"

with open(csv_file, 'r') as read_obj:
    csv_reader = DictReader(read_obj)
    #Ignores first line of headers
    # next(csv_reader)
    start = timer ()
    for row in csv_reader:
        print("Image1:",row['Image1'],"\n","Image2:",row['Image2'])
        bool_check = image_inst.check_equal(row['Image1'],row['Image2'])
        similarity = image_inst.check_similarity_percent(row['Image1'],row['Image2'])
        end = timer ()
        time_elapsed = round((end - start),2)
        if( similarity == 100):
            similar_check = 0
        elif (similarity == 0):
            similar_check = 1
        else:
            similar_check = (100-similarity)/100
        line = {"image1":row['Image1'],"image2":row['Image2'],"similar":similar_check,"elapsed in sec":time_elapsed}
        dict_csv.append(line)
    
cv_obj.waitKey(0)
cv_obj.destroyAllWindows()

#Dump dict values to CSV file
try:
    with open(csv_out_file, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for data in dict_csv:
            writer.writerow(data)
except IOError:
    print("I/O error")


