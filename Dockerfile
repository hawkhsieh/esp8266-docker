FROM ubuntu:14.04

#RUN dpkg --add-architecture i386
#RUN echo "foreign-architecture i386" >> /etc/dpkg/dpkg.cfg.d/architectures
#RUN deb [arch=amd64,i386] http://uk.archive.ubuntu.com/ubuntu/ quantal main universe
#RUN echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list
#RUN echo "deb-src http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y sudo git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev python-serial libexpat-dev
#
# You must NOT be root to run crosstool-NG
#
RUN mkdir -p /home/esp8266/Espressif
RUN useradd -s /bin/bash -m esp8266 && \
            echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266 && \
            chmod 0440 /etc/sudoers.d/esp8266

RUN chown esp8266:esp8266 -R /home/esp8266
USER esp8266
ENV HOME=/home/esp8266
#
# Install the Xtensa crosstool-NG
#
RUN cd /home/esp8266/Espressif && \
    git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git
RUN cd /home/esp8266/Espressif/crosstool-NG && \
        ./bootstrap && ./configure --prefix=`pwd` && make && make install
RUN cd /home/esp8266/Espressif/crosstool-NG/ && ./ct-ng xtensa-lx106-elf && ./ct-ng build
ENV PATH=/home/esp8266/Espressif/crosstool-NG/builds/xtensa-lx106-elf/bin:$PATH
#
# Setting up the Espressif SDK
#
ADD ./esp_iot_sdk_v1.2.0_15_07_03.zip /home/esp8266/Espressif/
RUN sudo apt-get install -y unzip
RUN cd /home/esp8266/Espressif && \
    unzip -o esp_iot_sdk_v1.2.0_15_07_03.zip && \
    mv esp_iot_sdk_v1.2.0 ESP8266_SDK && \
    mv License ESP8266_SDK/
#
# Patching
#
RUN cd /home/esp8266/Espressif/ESP8266_SDK && \
    sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile && \
    mv examples/IoT_Demo .
#
# Installing Xtensa libraries and headers
#
RUN cd /home/esp8266/Espressif/ESP8266_SDK && \
    wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a &&  \
    wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a && \
    wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz && \
    tar -xvzf include.tgz
#
# Installing the ESP image tool
#
RUN cd /home/esp8266/Espressif && git clone https://github.com/tommie/esptool-ck.git
RUN cd /home/esp8266/Espressif/esptool-ck && make
ENV PATH=$PATH:$HOME/esptool-ck
#
# Installing the ESP upload tool
#
RUN cd /home/esp8266/Espressif && \
    git clone https://github.com/themadinventor/esptool esptool-py && \
    chmod a+w -R crosstool-NG/builds/xtensa-lx106-elf/bin && \
    ln -s /home/esp8266/Espressif/esptool-py/esptool.py crosstool-NG/builds/xtensa-lx106-elf/bin/

WORKDIR /home/esp8266

#
# freeRTOS
#
RUN git clone https://github.com/espressif/esp_iot_rtos_sdk
RUN cp /home/esp8266/Espressif/ESP8266_SDK/lib/libhal.a /home/esp8266/esp_iot_rtos_sdk/lib/

CMD cd /home/esp8266/esp_iot_rtos_sdk/app && \
    chmod a+x ./gen_misc.sh && \
    sudo chown -R esp8266 ../bin && \
    ./gen_misc.sh



