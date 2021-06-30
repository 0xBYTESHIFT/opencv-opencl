#!/usr/bin/env bash

conan user --clean && \
conan remote clean && \
conan remote add cyberduckninja https://api.bintray.com/conan/cyberduckninja/conan && \
conan remote add 3opinion http://gitlab.3opinion.ai:9300/ 2> /dev/null && \
\
conan user admin -r 3opinion -p f4a8025b895cd3aa632ad6d0c3131ec5 && \
\
conan export /data/recipes/libva libva/2.9@3opinion/stable && \
conan create recipes/libva libva/2.9@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "va"  && \
\
conan export /data/recipes/intel-vaapi-driver intellvaapidriver/2.4@3opinion/stable && \
conan create recipes/intel-vaapi-driver intellvaapidriver/2.4@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "intellvaapidriver"  && \
\
conan export /data/recipes/nasm nasm/2.13.02@3opinion/stable && \
conan create recipes/nasm nasm/2.13.02@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "nasm"  && \
\
conan export /data/recipes/libx264 libx264/20190605@3opinion/stable && \
conan create recipes/libx264 libx264/20190605@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "libx264"  && \
\
conan export /data/recipes/openh264 openh264/1.7.0@3opinion/stable && \
conan create recipes/openh264 openh264/1.7.0@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "openh264"  && \
\
conan export /data/recipes/vpx vpx/1.8.0@3opinion/stable && \
echo "vpx 1 "  && \
conan create recipes/vpx vpx/1.8.0@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "vpx"  && \
\
conan export /data/recipes/ffmpeg ffmpeg/4.2.1@3opinion/stable && \
conan create recipes/ffmpeg ffmpeg/4.2.1@3opinion/stable -s compiler.libcxx=libstdc++11 && \
echo "ffmpeg" && \
\
conan upload intel-vaapi-driver --all -r 3opinion -c --force && \
conan upload libva --all -r 3opinion -c --force && \
conan upload libx264 --all -r 3opinion -c --force && \
conan upload openh264 --all -r 3opinion -c --force && \
conan upload ffmpeg --all -r 3opinion -c --force