#!/bin/sh
# uas.sh

set -e

display_menu() {
    echo "--Menu--"
    echo "1. Buat File"
    echo "2. Lihat Permission File"
    echo "3. Hapus File"
    echo "4. Ubah Izin File"
    echo "5. Ubah Nama File"
    echo "6. Buka File"
    echo "7. Monitoring Proses"
    echo "8. Pindai Jaringan"
    echo "9. Uji Kecepatan Internet"
    echo "10. Keluar"
    echo "--------------"
}

# Fungsi untuk membuat file
buat_file() {
    echo "--Buat File--"
    read -p "Masukkan Nama File beserta Extensionnya (cth: .sh) : " nama_file
    touch "$nama_file"
    echo "File '$nama_file' telah dibuat."
}

# Fungsi untuk melihat izin file
lihat_izin_file() {
    echo "--Lihat Izin File--"
    read -p "Masukkan Nama File: " nama_file
    ls -l "$nama_file"
}

# Fungsi untuk menghapus file
hapus_file() {
    echo "--Hapus File--"
    read -p "Masukkan Nama File: " nama_file
    rm "$nama_file"
    echo "File '$nama_file' telah dihapus."
}

# Fungsi untuk mengubah izin file
ubah_izin_file() {
    echo "--Ubah Izin File--"
    read -p "Masukkan Nama File: " nama_file
    read -p "Ubah Izin: " izin_file
    chmod "$izin_file" "$nama_file"
    echo "Izin File '$nama_file' telah diubah menjadi $izin_file."
}

# Fungsi untuk mengubah nama file
ubah_nama_file() {
    echo "--Ubah Nama File--"
    read -p "Masukkan Nama File Yang Ingin diubah: " nama_file
    read -p "Ubah Nama Yang Baru: " nama_baru
    mv "$nama_file" "$nama_baru"
    echo "Nama File '$nama_file' telah diubah menjadi $nama_baru."
}

# Fungsi untuk membuka file
buka_file() {
    echo "--Buka File--"
    read -p "Masukkan Nama File Yang Ingin Dibuka: " nama_file
    cat "$nama_file"
}

# Fungsi untuk memindai jaringan
scan_network() {
    if ! command -v nmap &> /dev/null; then
        echo "nmap tidak ditemukan. Apakah Anda ingin menginstal nmap? (y/n)"
        read install_nmap
        if [ "$install_nmap" = "y" ]; then
            sudo apt-get update
            sudo apt-get install nmap -y
        else
            echo "nmap diperlukan untuk memindai jaringan."
            return
        fi
    fi

    nmap 192.168.1.0/24 | tee scan_result.txt
    echo "Pemindaian jaringan selesai. Hasil disimpan di scan_result.txt."
}

# Fungsi untuk menguji kecepatan internet
test_internet_speed() {
    if ! command -v speedtest-cli &> /dev/null; then
        echo "speedtest-cli tidak ditemukan. Apakah Anda ingin menginstal speedtest-cli? (y/n)"
        read install_speedtest
        if [ "$install_speedtest" = "y" ]; then
            sudo apt-get update
            sudo apt-get install speedtest-cli -y
        else
            echo "speedtest-cli diperlukan untuk menguji kecepatan internet."
            return
        fi
    fi

    speedtest-cli | tee speed_test_result.txt
    echo "Tes kecepatan internet selesai. Hasil disimpan di speed_test_result.txt."
}

# Loop utama
while true; do
    display_menu
    read -p "Pilih Menu: " menu

    case "$menu" in
        1) buat_file ;;
        2) lihat_izin_file ;;
        3) hapus_file ;;
        4) ubah_izin_file ;;
        5) ubah_nama_file ;;
        6) buka_file ;;
        8) scan_network ;;
        9) test_internet_speed ;;
        10) echo "Keluar dari program."; exit 0 ;;
        *) echo "Opsi tidak valid. Silakan pilih opsi 1-10." ;;
    esac
done
