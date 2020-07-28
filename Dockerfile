
FROM ubuntu:16.04


RUN apt-get update && \
        apt-get install -y --no-install-recommends \
	python3 \
	python3-dev \
	build-essential \
	git \
	wget \
	python3-testresources -y \
	python3-pip 
	
RUN pip3 install numpy &&\
	pip3 install matplotlib && \
	apt-get install cmake -y \
	git gfortran -y\
	libjpeg8-dev libjasper-dev libpng12-dev -y\
	libtiff5-dev -y\
	libtiff-dev -y \
	libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev -y \
	libxine2-dev libv4l-dev -y \
	libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev -y\
	libgtk2.0-dev libtbb-dev qt5-default -y \
	libatlas-base-dev -y \
	libfaac-dev libmp3lame-dev libtheora-dev -y \	
	libvorbis-dev libxvidcore-dev -y \
	libopencore-amrnb-dev libopencore-amrwb-dev -y \
	libavresample-dev -y \
	x264 v4l-utils -y

RUN git clone https://github.com/opencv/opencv.git && \
	cd opencv \
	&& git checkout 3.4.3 \
	&& cd .. \
	&& git clone https://github.com/opencv/opencv_contrib.git \
	&& cd opencv_contrib \
	&& git checkout 3.4.3 \
	&& cd .. \
	&& cd opencv \
	&& mkdir build && cd build \
	&& cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"3.4.3" \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
	-D BUILD_opencv_python3=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. \
	&& make -j8 \
	&& make install 
	
RUN cd /opencv/build/lib/python3/ \
	&& cp cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages

CMD ["python3 --version"]
