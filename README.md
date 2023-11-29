<p align="center">
    <img src="logo.png" width="50%"></img>
</p>

### [Wiki](https://github.com/codelao/EasyInject/wiki)
**or:**
`git clone https://github.com/codelao/EasyInject.wiki.git`

## Welcome to EasyInject!
### Description
EasyInject is a library of scripts for injecting different payloads and attack vectors into the target machine.
### Disclaimer
This library is made for ethical purposes only (for example, CTFs). Author is not responsible for any malicious activities that can be made by using any of contents of this library!

## Installation
### Install whole library:
```
git clone https://github.com/codelao/EasyInject.git
```
### Install specific injector:
```
wget https://github.com/codelao/EasyInject/raw/main/<dir_name>/<file_name>
```
Replace *dir_name* with needed repo tree, and *file_name* with needed file from this tree. You should install all files from the needed injector's directory as they contain dependencies and usage guides.

## Usage
Read injector's usage guide before running it.
If injector requires options - use `-h` option while running it
### Standard run
```
pip3 install -r requirements.txt
```
___
```
chmod +x injector.py
./injector.py <options>
```
or:
```
python3 injector.py <options>
```
### Obfuscation
I recommend using `pyarmor`</br>
#### Basic python script obfuscation:
```
pyarmor obfuscate injector.py
```
#### Creating obfuscated executable file:
```
pyarmor pack injector.py
```
You can run obfuscated exec by clicking on it (not supported on some operating systems), or by using this command:
```
./injector <options>
```
