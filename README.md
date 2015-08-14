# esp8266 deveopment with docker container
安裝了docker後，進入此目錄：
```
cd esp8266
build.sh
run.sh
```
執行run.sh隨後就會帶你進入容器裡面，裡面已經包含了<br/>
https://github.com/esp8266/esp8266-wiki/wiki/Toolchain#64-bit-debian-linux<br/>
裡面所安裝的套件，所以接下來只需要再參照<br/>
https://github.com/esp8266/esp8266-wiki/wiki/Building<br/>
就可以開始編譯firmware。為了開發方便，我已掛載esp8266的目錄到容器內的/home/esp8266/project裡面<br/>
因此，將你的程序放到假設是`esp8266/iot`，在容器裡面的位置就是`/home/esp8266/project/iot`。<br/>

Enjoy!

--------------------------

After you install the docker, execute the `build.sh` script in this repository to build docker image.
I think everything will be ok because docker's magic.
And then you just need `compile.sh`. This will compile your code in `user` folder and release binary  into `bin` folder

Refer to the url to build example or even yours!!
https://github.com/esp8266/esp8266-wiki/wiki/Building

