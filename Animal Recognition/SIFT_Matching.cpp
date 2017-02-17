#include <iostream>
#include <fstream>
#include <string>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/nonfree/nonfree.hpp>

using namespace std;
using namespace cv;

int main(int argc, const char* argv[]) {
    //string prefix = "/Users/apple/Desktop/CV/SIFTMatching/images/Input";
    string prefix = "/Users/apple/Desktop/Input";
    string suffix = ".jpg";
    
    for (int i = 1; i <= 1; i++) {
        stringstream stream_i;
        stream_i << i;
        string num_i = stream_i.str();
        
        for (int j = 2; j <= 2; j++) {
            stringstream stream_j;
            stream_j << j;
            string num_j = stream_j.str();
            
            string path1 = prefix + num_i + suffix;
            string path2 = prefix + num_j + suffix;
            cout << path1 << endl;
            cout << path2 << endl;
            
            cv::Mat input1 = cv::imread(path1, 1);
            cv::Mat input2 = cv::imread(path2, 1);
            
            //SiftFeatureDetector
            cv::SiftFeatureDetector detector(100);
            vector<KeyPoint> keypoints1, keypoints2;
            
            detector.detect(input1, keypoints1);
            detector.detect(input2, keypoints2);
            
            cv::SiftDescriptorExtractor extractor;
            cv::Mat descriptors1,descriptors2;
            
            extractor.compute(input1, keypoints1, descriptors1);
            extractor.compute(input2, keypoints2, descriptors2);
            
            //matches
            cv::BFMatcher matcher(NORM_L2);
            vector<DMatch> matches;
            
            matcher.match(descriptors1, descriptors2, matches);
            
            cv::Mat img_matches;
            cv::drawMatches(input1,keypoints1,input2,keypoints2,matches,img_matches);
            
            //Good matches
            double max_dist = 0;
            double min_dist = 10000;
            double result = 0;
            
            //-- Quick calculation of max and min distances between keypoints
            for(int i = 0; i < descriptors1.rows; i++) {
                double dist = matches[i].distance;
                if( dist < min_dist ) {
                    min_dist = dist;
                }
                if( dist > max_dist ) {
                    max_dist = dist;
                }
            }
            
            //-- Draw only "good" matches (i.e. whose distance is less than 2*min_dist )
            //-- PS.- radiusMatch can also be used here.
            vector<DMatch> goodMatches;
            
            for( int i = 0; i < descriptors1.rows; i++ ) {
                if( matches[i].distance <= 0.8 * max_dist ) {
                    goodMatches.push_back(matches[i]);
                }
            }
            
            //-- Draw only "good" matches
            cv::Mat img_good_matches;
            drawMatches(input1, keypoints1, input2, keypoints2, goodMatches, img_good_matches);
            
            
            //show result
            cv::imshow("matches",img_matches);
            //cv::imwrite("/Users/apple/Desktop/CV/SIFTMatching/matches.jpg",img_matches);
            cv::imwrite("/Users/apple/Desktop/SIFTmatches.jpg",img_matches);
            
            cv::imshow("good matches",img_good_matches);
            //cv::imwrite("/Users/apple/Desktop/CV/SIFTMatching/goodMatches.jpg",img_good_matches);
            cv::imwrite("/Users/apple/Desktop/SIFTgoodMatches.jpg",img_good_matches);
            
            printf("-- Max dist : %f \n", max_dist);
            printf("-- Min dist : %f \n", min_dist);
            cout << matches.size() << endl;
            cout << goodMatches.size() << endl;
            result = (float)goodMatches.size() / (float)matches.size();
            printf("Scores %f \n", result);
            
            //write scores into txt file
//            ofstream in;
//            in.open("/Users/apple/Desktop/CV/SIFTMatching/matchScores.txt",ios::binary|ios::app);
//            in << result <<endl;
//            in.close();
        }
    }
    
    
    cv::waitKey();
    return 0;
}
