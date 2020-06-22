

class ImageDiff:

    def __init__(self,cv_obj,sift):
        self.cv_obj = cv_obj
        self.sift = sift

    # 1) Check if 2 images are equals
    def check_equal(self,image1_path,image2_path):
        image1 = self.cv_obj.imread(image1_path)
        image2 = self.cv_obj.imread(image2_path)
        
        if image1.shape == image2.shape:
            print("The images have same size and channels")
            difference = self.cv_obj.subtract(image1, image2)
            b, g, r = self.cv_obj.split(difference)
            if self.cv_obj.countNonZero(b) == 0 and self.cv_obj.countNonZero(g) == 0 and self.cv_obj.countNonZero(r) == 0:
                print("The images are completely Equal")
                return 0 
            else:
                print("The images are NOT equal")
        else:
            print("Images are not equal in size at all")
            return 1


    # 2) Check for similarities between the 2 images
    def check_similarity_percent(self,image1_path,image2_path):
        image1 = self.cv_obj.imread(image1_path)
        image2 = self.cv_obj.imread(image2_path)
        kp_1, desc_1 = self.sift.detectAndCompute(image1, None)
        kp_2, desc_2 = self.sift.detectAndCompute(image2, None)

        index_params = dict(algorithm=0, trees=5)
        search_params = dict()
        flann = self.cv_obj.FlannBasedMatcher(index_params, search_params)

        matches = flann.knnMatch(desc_1, desc_2, k=2)

        good_points = []
        for m, n in matches:
            if m.distance < 0.6*n.distance:
                good_points.append(m)

        # Define how similar they are
        number_keypoints = 0
        if len(kp_1) <= len(kp_2):
            number_keypoints = len(kp_1)
        else:
            number_keypoints = len(kp_2)


        print("Keypoints 1ST Image: " + str(len(kp_1)))
        print("Keypoints 2ND Image: " + str(len(kp_2)))
        print("GOOD Matches:", len(good_points))
        print("How good it's the match: ", len(good_points) / number_keypoints * 100)

        # result = self.cv_obj.drawMatches(image1, kp_1, image2, kp_2, good_points, None)
        
        percentage_similarity = len(good_points) / number_keypoints * 100
    
        print("Similarity: " + str(int(percentage_similarity)) + "\n")
        return int(percentage_similarity)

        