# dotfiles


Actually, I use the tools below:


* Windows 10
* [Visual Studio Code](https://github.com/microsoft/vscode)
* [Windows Terminal](https://github.com/microsoft/terminal)
* [WSL2](https://github.com/microsoft/WSL)
* [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/)
    * [PhpStorm](https://www.jetbrains.com/phpstorm/)
    * [WebStorm](https://www.jetbrains.com/webstorm/)
    * [PyCharm](https://www.jetbrains.com/pycharm/)
    * [Datagrip](https://www.jetbrains.com/datagrip/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)


---


## Install


### Visual Studio Code


1. Download from [Visual Studio Code site](https://code.visualstudio.com/)
1. Follow installer instructions


### Windows Terminal


1. Install **Windows Terminal** from [Microsoft Store](https://aka.ms/terminal)
1. Install **Powerline Font** from [Github](https://github.com/powerline/fonts)


### WSL 2


1. Install **Kali Linux** from [Microsoft Store](https://www.microsoft.com/en-us/p/kali-linux/9pkr34tncv07?activetab=pivot:overviewtab)


### Jetbrains Toolbox


1. Download from [Jetbrains Toolbox site](https://www.jetbrains.com/toolbox-app/)
1. Follow installer instructions
1. Install **PhpStorm, WebStorm, Pycharm and Datagrip** from **Jetbrains Toolbox**


### Docker Desktop


1. Download from [Docker Desktop site](https://www.docker.com/products/docker-desktop)
1. Follow installer instructions


---


## Setup


### Windows Terminal


1. Copy contents of **config/windows-terminal.json**


### WSL 2


1. Check if your user has permission to execute any command
1. Run `sh -c "$(curl -fsSL https://raw.githubusercontent.com/aironou/dotfiles/main/bin/init.sh)"`
