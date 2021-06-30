#include <iostream>
#include <opencv2/core/opencl/opencl_info.hpp>
#include <opencv2/opencv.hpp>

int main(int argc, char **argv) {
  cv::setNumThreads(1);
  cv::ocl::setUseOpenCL(true);

  if (!cv::ocl::haveOpenCL()) {
    std::cerr << "NO OPENCL!\n";
    return 1;
  } else {
    std::cout << "YOU HAVE OPENCL!\n";
  }

  return 0;
}
