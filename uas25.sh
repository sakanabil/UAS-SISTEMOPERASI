#!/bin/sh
# uas.sh

echo "--Menu--"
echo "1. Buat File"
echo "2. Lihat Permission File"
echo "3. Hapus File"
echo "4. Ubah Izin File"
echo "5. Ubah Nama File"
echo "--------------"
read -p "Pilih Menu: " menu

case "$menu" in
        1)
                echo "--Buat File--"
                echo "Masukkan Nama File beserta Extensionnya (cth: .sh) : "
                read nama_file
                touch "$nama_file"
                ;;
        2)
                echo "--Lihat Izin File--"
                echo "Masukkan Nama File: "
                read nama_file
                ls -l "$nama_file"
                ;;
        3)
                echo "--Hapus File--"
                echo  "Masukkan Nama File: "
                read nama_file 
                rm "$nama_file"
                ;;
        4)
                echo "--Ubah Izin File--"
                echo "Masukkan Nama File: "
                read nama_file
                echo "Ubah Izin: "
                read izin_file
                chmod "$izin_file" "$nama_file"
                echo "Izin File '$nama_file' telah diubah menjadi $izin_file"
                ;;
        5)
                echo "--Ubah Nama File--"
                echo "Masukkan Nama File Yang Ingin diubah: "
                read nama_file
                echo "Ubah Nama Yang Baru: "
                read nama_baru
                mv "$nama_file" "$nama_baru"
                echo "Nama File '$nama_file' telah diubah menjadi $nama_baru"
                ;;
esac