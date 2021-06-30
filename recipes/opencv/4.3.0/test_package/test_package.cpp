#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/dnn.hpp>

int main() {
    cv::Mat mat(512, 512, CV_32FC3);
    cv::dnn::blobFromImage(mat);
    cv::dnn::Net net;
    return 0;
}
