Openwrt Package for speedtest-go
---------

A [single-file Ookla speetest tool](https://github.com/showwin/speedtest-go), built as a  Openwrt package.

Usage:

```sh
cd path/to/openwrt/

git clone https://github.com/hathlife/openwrt-speedtest-go package/speedtest-go

./script/feeds update -a
./script/feeds install -a

make menuconfig # Network --> speedtest-go, For upx compress support you need to have upx/ucl in your toolchain.

make package/speedtest-go/complie V=99
make package/speedtest-go/install V=99

scp bin/package/<arch>/base/speedtest-go*.ipk root@router:/tmp
```
Tested platform:

✔ x86_64  
❌ mipsel_24kc (panic: runtime error: invalid memory address or nil pointer dereference)