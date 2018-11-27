# Guia de instalação


### Boot

1. `curl -X GET http://linorg.usp.br/archlinux/iso/2018.11.01/archlinux-2018.11.01-x86_64.iso -O`
1. `dd bs=4M if=archlinux-2018.11.01-x86_64.iso of=/dev/sdb status=progress oflag=sync`
1. Habilitar modo de boot legado na BIOS.


### Configurações

1. `loadkeys br-abnt2`
1. Se usar wifi
    1. `wifi-menu`
1. `ping 8.8.8.8`
1. Se `ping` não funcionar, tentar `systemctl stop dhcpcd` e o `ping` novamente. 
1. `timedatectl set-ntp true`


### Partições

1. `cfdisk /dev/sda`

|Dispositivo|Montagem|Tamanho|Tipo|Formato|
|---|---|---|---|---|
|/dev/sda1|/boot|800M|EFI System|FAT32|
|/dev/sda2|/|50G|Linux System|ext4|
|/dev/sda3|/var|150G|Linux System|ext4|
|/dev/sda4|/home|265G|Linux System|ext4|

2. `mkfs.fat -F32 /dev/sda1`
1. `cryptsetup -s 512 -h sha512 -y --use-urandom luksFormat /dev/sda2`
1. `cryptsetup open /dev/sda2 root`
1. `mkfs.ext4 /dev/mapper/root`
1. `cryptsetup -s 512 -h sha512 -y --use-urandom luksFormat /dev/sda3`
1. `cryptsetup open /dev/sda3 var`
1. `mkfs.ext4 /dev/mapper/var`
1. `cryptsetup -s 512 -h sha512 -y --use-urandom luksFormat /dev/sda4`
1. `cryptsetup open /dev/sda4 home`
1. `mkfs.ext4 /dev/mapper/home`
1. `mount /dev/mapper/root /mnt`
1. `mkdir /mnt/boot /mnt/var /mnt/home`
1. `mount /dev/sda1 /mnt/boot`
1. `mount /dev/mapper/var /mnt/var`
1. `mount /dev/mapper/home /mnt/home`


### Pacotes

1. `pacstrap /mnt base base-devel`


### Arquivos para montagem dos discos

1. `genfstab -L /mnt > /mnt/etc/fstab`
1. `echo 'var /dev/sda3' > /mnt/etc/crypttab`
1. `echo 'home /dev/sda4' >> /mnt/etc/crypttab`


### Chroot

1. `arch-chroot /mnt`
1. `ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime`
1. `hwclock --systohc`
1. `echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen`
1. `locale-gen`
1. `echo 'LANG=pt_BR.UTF-8' >> /etc/locale.conf`
1. `echo 'KEYMAP=br-abnt2' > /etc/vconsole.conf`
1. `echo '221B' > /etc/hostname`
1. `echo '127.0.0.1 localhost 221B 221B.localdomain' > /etc/hosts`
1. `echo '::1 localhost 221B 221B.localdomain' >> /etc/hosts`
1. Abrir `/etc/mkinitcpio.conf` e alterar `HOOKS`para `HOOKS=(base udev autodetect keyboard keymap consolefont modconf
block encrypt filesystems fsck)`
1. `mkinitcpio -p linux`
1. `passwd`
1. `useradd -m -g aironou -G users http log sys wheel audio disk floppy input optical scanner storage video -s /bin/zsh aironou`
1. Abrir `/etc/sudoers` e incluir configuração para o grupo `wheel` para `%wheel ALL=(ALL) ALL`
1. `passwd aironou`
1. `pacman -S efibootmgr vim`
1. Se usar wifi
    1. `pacman -S dialog wpa_supplicant`
1. Abrir `/etc/default/grub` e alterar `GRUB_CMDLINE_LINUX` para `GRUB_CMDLINE_LINUX=cryptdevice=/dev/sda2:root
root=/dev/mapper/root`
1. `grub-install --efi-directory=/boot --bootloader-id=grub --boot-directory=/boot --debug --recheck /dev/sda`
1. `grub-mkconfig -o /boot/grub/grub.cfg`


### Reboot

1. `umount -R /mnt`
1. `shutdown -h 0`


# @TODO

1. Criar um link que aponte sempre para a última release da ISO do Arch Linux
1. Melhorar passos para configurar a rede
1. Criar keyfile após criptografar as partições
1. Substituir passos que dependem de interação do usuário
1. Criar script para executar cada etapa descrita
