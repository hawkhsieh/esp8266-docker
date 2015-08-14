# esp8266 easy deveopment environment
安裝了docker後，進入此目錄：
```
cd esp8266
build.sh
compile.sh
```
這個執行環境裡面已經包含了最新的 espressif 1.2.0版<br/>
http://espressif.com/new-sdk-release/<br/>
https://github.com/esp8266/esp8266-wiki/wiki/Building<br/>

已掛載esp8266的bin與user目錄到容器裡面<br/>
因此，只需要執行`compile.sh`就可以編譯`user`裡面的源碼，並且編譯出來的韌體會放在`bin`下面。<br/>

Enjoy!

--------------------------

After you install the docker, execute the `build.sh` script in this repository to build docker image.
I think everything will be ok because docker's magic.
And then you just need `compile.sh`. This will compile your code in `user` folder and release binary  into `bin` folder

Refer to the url to build example or even yours!!
https://github.com/esp8266/esp8266-wiki/wiki/Building

