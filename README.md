# esp8266 deveopment on docker
安裝了docker後，進入此目錄：
```
cd esp8266
build.sh
run.sh
```
執行run.sh隨後就會帶你進入容器裡面，裡面已經包含了
https://github.com/esp8266/esp8266-wiki/wiki/Toolchain#64-bit-debian-linux
裡面所安裝的套件，所以接下來只需要再參照
https://github.com/esp8266/esp8266-wiki/wiki/Building
將你想要的範例clone下來，就能開始開發！感謝docker！

--------------------------
## English version
After you install the docker, execute the `build.sh` script in this repository to build docker image.
I think everything will be ok because docker's imagination.
And then you just need `run.sh`. This will bring you into docker container.

Refer to the url to build example or even yours!!
https://github.com/esp8266/esp8266-wiki/wiki/Building

