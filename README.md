# Jarkom-Modul-2-B11-2021

## **Kelompok B-11**
- Muhammad Nevin        (05111940000079)
- Albert Filip Silalahi (05111940000116)
- Jagad Wijaya Purnomo	(05111940000132)


## Soal 1
EniesLobby akan dijadikan sebagai DNS Master, Water7 akan dijadikan DNS Slave, dan Skypie akan digunakan sebagai Web Server. Terdapat 2 Client yaitu Loguetown, dan Alabasta. Semua node terhubung pada router Foosha, sehingga dapat mengakses internet.

### Jawaban

Membuat topologi sebagai berikut:

![01-01](https://user-images.githubusercontent.com/31863229/138602120-ba27cff0-326a-4a12-8baf-6cb9476e475d.PNG)

Lakukan setting network masing-masing node dengan fitur `Edit network configuration` dengan setting sebagai berikut:

**Foosha (sebagai Router)**
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.182.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.182.2.1
	netmask 255.255.255.0
```

**Loguetown (sebagai Client)**
```
auto eth0
iface eth0 inet static
	address 192.182.1.2
	netmask 255.255.255.0
	gateway 192.182.1.1
```

**Alabasta (sebagai Client)**
```
auto eth0
iface eth0 inet static
	address 192.182.1.3
	netmask 255.255.255.0
	gateway 192.182.1.1
```

**EniesLobby (sebagai DNS Master)**
```
auto eth0
iface eth0 inet static
	address 192.182.2.2
	netmask 255.255.255.0
	gateway 192.182.2.1
```

**Water7 (sebagai DNS Slave)**
```
auto eth0
iface eth0 inet static
	address 192.182.2.3
	netmask 255.255.255.0
	gateway 192.182.2.1
```

**Skypie (sebagai Web Server)**
```
auto eth0
iface eth0 inet static
	address 192.182.2.4
	netmask 255.255.255.0
	gateway 192.182.2.1
```

Ketikkan `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.182.0.0/16` pada router `Foosha`.

Ketikkan `echo nameserver 192.168.122.1 > /etc/resolv.conf` pada node ubuntu yang lain.

Restart semua node dan coba `ping google.com`. Berikut bukti `Loguetown` dapat mengakses internet.

![01-02](https://user-images.githubusercontent.com/31863229/138602128-fdeaf005-5b76-4cbf-b324-8701cba646af.PNG)

## Soal 2
Luffy ingin menghubungi Franky yang berada di `EniesLobby` dengan denden mushi. Kalian diminta Luffy untuk membuat website utama dengan mengakses `franky.yyy.com` dengan alias `www.franky.yyy.com` pada folder kaizoku.

### Jawaban

**Pada EniesLobby**
- Install aplikasi bind9.

  ```
  apt-get install bind9 -y
  ```
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![02-01](https://user-images.githubusercontent.com/67728406/139534483-4377b448-1587-4d6b-92c4-1c015287e6e8.png)

- Buat folder `kaizoku` di dalam `/etc/bind`.

  ```
  mkdir /etc/bind/kaizoku
  ```
- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `kaizoku` yang baru saja dibuat dan ubah namanya menjadi `franky.B11.com`.

  ```
  cp /etc/bind/db.local /etc/bind/kaizoku/franky.B11.com
  ```
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![02-02](https://user-images.githubusercontent.com/67728406/139534680-08250ef0-18ce-4cfd-86ee-0b389c0e2154.png)


- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Edit file `/etc/resolv.conf` seperti pada gambar berikut:

  ![02-03](https://user-images.githubusercontent.com/67728406/139534564-6ff9f253-99fa-4d98-822f-20b7e346b142.png)

- Lakukan ping domain `franky.B11.com` dan `www.franky.B11.com`.

  ![02-04](https://user-images.githubusercontent.com/67728406/139534610-27f87150-37a8-4be2-9b17-614d36c761d9.png)


## Soal 3
Setelah itu buat subdomain `super.franky.yyy.com` dengan alias `www.super.franky.yyy.com` yang diatur DNS nya di EniesLobby dan mengarah ke Skypie.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![03-01](https://user-images.githubusercontent.com/67728406/139534723-9637281e-d0c0-481b-984d-992e143dc9e6.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `super.franky.B11.com`.

  ![03-02](https://user-images.githubusercontent.com/67728406/139534752-739b82cc-1274-45d8-9e3e-1aee0af0d2c4.png)


## Soal 4
Buat juga reverse domain untuk domain utama.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![04-01](https://user-images.githubusercontent.com/67728406/139534802-e60fb59f-b46d-4997-b6f4-f88f686ec4a9.png)

- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `kaizoku` yang baru saja dibuat dan ubah namanya menjadi `2.182.192.in-addr.arpa`.

  ```
  cp /etc/bind/db.local /etc/bind/kaizoku/2.182.192.in-addr.arpa
  ```
- Edit file `/etc/bind/kaizoku/2.182.192.in-addr.arpa` seperti pada gambar berikut:

  ![04-02](https://user-images.githubusercontent.com/67728406/139534911-b7a491e9-4cb2-4676-a0bb-b3ca38681c3e.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan pengecekan konfigurasi dengan perintah `host -t PTR 192.182.2.2`.

  ![04-03](https://user-images.githubusercontent.com/67728406/139534951-673af4f6-22b9-468f-a707-cb103caab01f.png)


## Soal 5
Supaya tetap bisa menghubungi Franky jika server EniesLobby rusak, maka buat Water7 sebagai DNS Slave untuk domain utama.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![05-01](https://user-images.githubusercontent.com/67728406/139534993-e881c230-076c-489a-8a91-6352a608497b.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Water7**
- Install aplikasi bind9.

  ```
  apt-get install bind9 -y
  ```
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![05-02](https://user-images.githubusercontent.com/67728406/139535036-a8b52151-492e-47e4-8890-ebc9964b83e5.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Pada `Enieslobby` silahkan matikan service bind9.
  ```
  service bind9 stop
  ```
- Edit file `/etc/resolv.conf` seperti pada gambar berikut:

  ![05-03](https://user-images.githubusercontent.com/67728406/139535080-ebf4eeb2-9844-4f0f-8046-a31248e911d4.png)

- Lakukan ping domain `franky.B11.com`.

  ![05-04](https://user-images.githubusercontent.com/67728406/139535108-f201381b-c44d-4919-a79e-0081387717fb.png)


## Soal 6
Setelah itu terdapat subdomain `mencha.franky.yyy.com` dengan alias `www.mencha.franky.yyy.com` yang didelegasikan dari EniesLobby ke Water7 dengan IP menuju ke Skypie dalam folder sunnygo.

### Jawaban
_*Pada project GNS3 kami terdapat typo. Kata `mecha` terlanjur kami tulis dengan `mencha`di semua konfigurasi._ <br><br>
**Pada EniesLobby**
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![06-01](https://user-images.githubusercontent.com/67728406/139535363-4039d4ae-1d59-40b0-bc3f-939451211a15.png)

- Edit file `/etc/bind/named.conf.options` seperti pada gambar berikut:

  ![06-02](https://user-images.githubusercontent.com/67728406/139535430-523fe301-1e7e-4c66-9eb5-1f599a5cb40d.png)

- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![06-03](https://user-images.githubusercontent.com/67728406/139535454-1030f213-3332-41bd-b32e-bbc9b7890878.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Water7**
- Edit file `/etc/bind/named.conf.options` seperti pada gambar berikut:

  ![06-04](https://user-images.githubusercontent.com/67728406/139535497-bc800d00-cc31-4f70-86cc-9717aaa91157.png)

- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![06-05](https://user-images.githubusercontent.com/67728406/139535539-0c3e3cc3-6fcb-4c6e-bb3e-cf3afda3597e.png)

- Buat folder `sunnygo` di dalam `/etc/bind`.

  ```
  mkdir /etc/bind/sunnygo
  ```
- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `sunnygo` yang baru saja dibuat dan ubah namanya menjadi `mencha.franky.B11.com`.

  ```
  cp /etc/bind/db.local /etc/bind/sunnygo/mencha.franky.B11.com
  ```
- Edit file `/etc/bind/sunnygo/mencha.franky.B11.com` seperti pada gambar berikut:

  ![06-06](https://user-images.githubusercontent.com/67728406/139535569-4ec9bcd5-3897-4eec-adde-c851f7e7e694.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `mencha.franky.B11.com` dan `www.mencha.franky.B11.com`.

  ![06-07](https://user-images.githubusercontent.com/67728406/139535608-04668993-6aa6-4191-928e-ac97fc74ea0a.png)


## Soal 7
Untuk memperlancar komunikasi Luffy dan rekannya, dibuatkan subdomain melalui Water7 dengan nama `general.mencha.franky.yyy.com` dengan alias `www.general.mencha.franky.yyy.com` yang mengarah ke Skypie.

### Jawaban
**Pada Water7**
- Edit file `/etc/bind/sunnygo/mencha.franky.B11.com` seperti pada gambar berikut:

  ![07-01](https://user-images.githubusercontent.com/67728406/139535677-dc48eb6e-c6d8-457e-9853-f23ba6acd72f.png)

- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `general.mencha.franky.B11.com`.

  ![07-02](https://user-images.githubusercontent.com/67728406/139535716-cf452584-c97d-44e3-9d2c-a3daaf4911ba.png)


## Soal 8
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver `www.franky.yyy.com`. Pertama, luffy membutuhkan webserver dengan DocumentRoot pada `/var/www/franky.yyy.com`.

### Jawaban
**Pada Skypie**
- Install aplikasi apache, PHP, dan libapache2-mod-php7.0.

  ```
  apt-get install apache2 -y
  apt-get install php -y
  apt-get install libapache2-mod-php7.0 -y
  ```
- Pindah ke directory `/etc/apache2/sites-available`.
- Copy file `000-default.conf` menjadi file `franky.B11.com.conf`.
- Edit file `franky.B11.com.conf` seperti pada gambar berikut:

  ![08-01](https://user-images.githubusercontent.com/67728406/139526675-99c58eb4-997c-45fe-8039-235fdb198fe4.png)

- Aktifkan konfigurasi franky.B11.com.

  ```
  a2ensite franky.B11.com
  ```
- Restart apache.

  ```
  service apache2 restart
  ```
- Pindah ke directory `/var/www`.
- Download file zip menggunakan `wget`.

  ```
  wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/franky.zip
  ```
- Lakukan unzip.

  ```
  unzip franky.zip
  ```
- Rename folder `franky` menjadi `franky.B11.com` dan terdapat isi file seperti pada gambar berikut:

  ![08-02](https://user-images.githubusercontent.com/67728406/139528021-466fe91b-8b38-4451-8f70-5e2311d2896f.png)


**Pada Loguetown**
- Install aplikasi lynx.

  ```
  apt-get install lynx -y
  ```
- Buka `www.franky.B11.com` menggunakan lynx.

  ![08-03](https://user-images.githubusercontent.com/31863229/138613005-39722a4d-d33f-4579-a8d9-be9b2c2e29ca.PNG)

## Soal 9
Setelah itu, Luffy juga membutuhkan agar url `www.franky.yyy.com/index.php/home` dapat menjadi menjadi `www.franky.yyy.com/home`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `franky.B11.com.conf` seperti pada gambar berikut:

  ![09-01](https://user-images.githubusercontent.com/67728406/139526675-99c58eb4-997c-45fe-8039-235fdb198fe4.png)
- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `www.franky.B11.com/home` menggunakan lynx.

  ![09-02](https://user-images.githubusercontent.com/31863229/138647857-59c7e0ac-4a6c-496d-93de-a0176037f41b.PNG)

## Soal 10
Setelah itu, pada subdomain `www.super.franky.yyy.com`, Luffy membutuhkan penyimpanan aset yang memiliki DocumentRoot pada `/var/www/super.franky.yyy.com`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Copy file `000-default.conf` menjadi file `super.franky.B11.com.conf`.
- Edit file `super.franky.B11.com.conf` seperti pada gambar berikut:

  ![10-01](https://user-images.githubusercontent.com/67728406/139526834-d91e0894-c9fc-42e6-8d4d-f82d73123461.png)

- Aktifkan konfigurasi super.franky.B11.com.

  ```
  a2ensite super.franky.B11.com
  ```
- Restart apache.

  ```
  service apache2 restart
  ```
- Pindah ke directory `/var/www`.
- Download file zip menggunakan `wget`.

  ```
  wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/super.franky.zip
  ```
- Lakukan unzip.

  ```
  unzip super.franky.zip
  ```
- Rename folder `super.franky` menjadi `super.franky.B11.com` dan terdapat isi file seperti pada gambar berikut:

  ![10-02](https://user-images.githubusercontent.com/67728406/139526873-3c5190f7-2fb9-45a2-89f0-b7c7d37b903e.png)


**Pada Loguetown**
- Buka `super.franky.B11.com` menggunakan lynx.

  ![10-03](https://user-images.githubusercontent.com/67728406/139526923-2e91e88f-6965-4ced-a9aa-9cfae21c201b.png)


## Soal 11
Akan tetapi, pada folder `/public`, Luffy ingin hanya dapat melakukan directory listing saja.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `super.franky.B11.com.conf` seperti pada gambar berikut:

  ![11-01](https://user-images.githubusercontent.com/67728406/139526998-5d22d029-8499-45f4-b3ee-d7946acbf902.png)

- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `super.franky.B11.com/public` menggunakan lynx.

  ![11-02](https://user-images.githubusercontent.com/67728406/139527033-dec49dbc-8000-4af3-9e15-a633cebfb979.png)

- Buka `super.franky.B11.com/public/css`, `super.franky.B11.com/public/images`, dan `super.franky.B11.com/public/js` menggunakan lynx.

  ![11-03](https://user-images.githubusercontent.com/67728406/139527052-03614f03-709d-427c-ab26-473458a99e6f.png)


## Soal 12
Tidak hanya itu, Luffy juga menyiapkan error file `404.html` pada folder `/error` untuk mengganti error kode pada apache.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `super.franky.B11.com.conf` seperti pada gambar berikut:

  ![12-01](https://user-images.githubusercontent.com/67728406/139527103-93ef32fa-cd5e-4cd2-944c-de4c1ab7aefc.png)

- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `super.franky.B11.com/publoc` (terdapat typo) menggunakan lynx.

  ![12-02](https://user-images.githubusercontent.com/31863229/138652187-10cdf3a5-14f6-4ab7-a1f9-c13ba4e520e5.PNG)

## Soal 13
Luffy juga meminta Nami untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset `www.super.franky.yyy.com/public/js` menjadi `www.super.franky.yyy.com/js`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `super.franky.B11.com.conf` seperti pada gambar berikut:

  ![13-01](https://user-images.githubusercontent.com/67728406/139527133-c00f05d7-5c68-40af-b8c0-80df288d2ce7.png)

- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `super.franky.B11.com/js` menggunakan lynx.

  ![13-02](https://user-images.githubusercontent.com/67728406/139527203-a053431a-b0d2-482f-86d8-839de9acab8e.png)



## Soal 14
Dan Luffy meminta untuk web `www.general.mencha.franky.yyy.com` hanya bisa diakses dengan port 15000 dan port 15500.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Copy file `000-default.conf` menjadi file `general.mencha.franky.B11.com.conf`.
- Edit file `general.mencha.franky.B11.com.conf` seperti pada gambar berikut:

  ![14-01](https://user-images.githubusercontent.com/67728406/139527233-8db0ea26-1f30-4a1f-92bd-9ff57b48a197.png)

- Edit file `/etc/apache2/ports.conf` untuk mengaktifkan port 15000 dan port 15500 seperti pada gambar berikut:

  ![14-02](https://user-images.githubusercontent.com/67728406/139527252-3681f195-8ddd-4834-95fa-b28e66c1d8f8.png)

- Aktifkan konfigurasi general.mencha.franky.B11.com.

  ```
  a2ensite general.mencha.franky.B11.com
  ```
- Restart apache.

  ```
  service apache2 restart
  ```
- Pindah ke directory `/var/www`.
- Download file zip menggunakan `wget`.

  ```
  wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/general.mencha.franky.zip
  ```
- Lakukan unzip.

  ```
  unzip general.mencha.franky.zip
  ```
- Rename folder `general.mencha.franky` menjadi `general.mencha.franky.B11.com` dan terdapat isi file seperti pada gambar berikut:

  ![14-03](https://user-images.githubusercontent.com/67728406/139527268-f280c25c-b144-4a84-94b8-7966854909da.png)


**Pada Loguetown**
- Buka `general.mencha.franky.B11.com` menggunakan lynx.

  ![14-04](https://user-images.githubusercontent.com/31863229/138662635-4721d99a-0698-46f6-ad73-29b1dcc08a3e.PNG)
- Buka `general.mencha.franky.B11.com:15000` menggunakan lynx.

  ![14-05](https://user-images.githubusercontent.com/67728406/139527305-b9305f2e-81ac-4bc0-b123-19d85192f3f0.png)

- Buka `general.mencha.franky.B11.com:15500` menggunakan lynx.

  ![14-06](https://user-images.githubusercontent.com/67728406/139527305-b9305f2e-81ac-4bc0-b123-19d85192f3f0.png)

## Soal 15
Dengan authentikasi username `luffy` dan password `onepiece` dan file di `/var/www/general.mencha.franky.yyy`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file  `.htaccess` pada `general.mencha.franky.B11.com.conf` seperti pada gambar berikut:

  ![15-01](https://user-images.githubusercontent.com/67728406/139527428-a0904f02-32f7-44a1-a154-fb439e2c0c30.png)

- Jalankan perintah berikut untuk membuat akun autentikasi baru dengan username `luffy`. Kita akan diminta untuk memasukkan password baru dan confirm password tersebut diisi `onepiece`.

  ```
  htpasswd -c /etc/apache2/.htpasswd luffy
  ```
- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `general.mencha.franky.B11.com:15000` menggunakan lynx dengan username `luffy` dan password `onepiece`.

  ![15-02](https://user-images.githubusercontent.com/67728406/139527470-cdf49725-f1ea-44c7-8f23-4a59f1230073.png)


## Soal 16
Dan setiap kali mengakses IP Skypie akan diahlikan secara otomatis ke `www.franky.yyy.com`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `000-default.conf` seperti pada gambar berikut:

  ![16-01](https://user-images.githubusercontent.com/67728406/139527719-3ad9e40b-234c-460f-af28-8ecdcc3d5679.png)

- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `192.182.2.4` (IP Skypie) menggunakan lynx.

  ![16-02](https://user-images.githubusercontent.com/31863229/138668611-6fe34a91-9581-46c2-8a53-6f7e05155cf9.PNG)

## Soal 17
Dikarenakan Franky juga ingin mengajak temannya untuk dapat menghubunginya melalui website `www.super.franky.yyy.com`, dan dikarenakan pengunjung web server pasti akan bingung dengan randomnya images yang ada, maka Franky juga meminta untuk mengganti request gambar yang memiliki substring `franky` akan diarahkan menuju `franky.png`.

### Jawaban
**Pada Skypie**
- Jalankan perintah `a2enmod rewrite` untuk mengaktifkan module rewrite.
- Restart apache dengan perintah `service apache2 restart`.
- Tambahkan file baru `.htaccess` pada folder `/var/www/super.franky.B11.com`, di mana file tersebut akan dimodifikasi menjadi:

  ![17-01](https://user-images.githubusercontent.com/67728406/139527739-a4ccd390-46b5-482a-b05a-0bdd31c34af9.png)
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file `super.franky.B11.com.conf` agar file `.htaccess` dapat berjalan seperti pada gambar berikut:

  ![17-02](https://user-images.githubusercontent.com/67728406/139527768-83738789-0136-4d20-ab3a-f36de023d0f4.png)
- Restart apache.

  ```
  service apache2 restart
  ```

**Pada Loguetown**
- Buka `super.franky.B11.com/public/images/franky.png` menggunakan lynx.

  ![17-03](https://user-images.githubusercontent.com/67728406/139527791-c5a6efde-f91b-4b94-8fcd-f284b8bb93c3.png)

- Buka `super.franky.B11.com/public/images/eyeoffranky.jpg` menggunakan lynx.

  ![17-04](https://user-images.githubusercontent.com/67728406/139527807-309c7620-0974-482d-aa21-0b98a49150de.png)

- Buka `super.franky.B11.com/public/images/background-frank.jpg` menggunakan lynx.

  ![17-05](https://user-images.githubusercontent.com/67728406/139527835-b1c9c383-f642-4252-aece-6b36f429b3c5.png)


## Kendala
1. Lupa memasukkan script instalasi dan konfigurasi ke `script.sh`.
2. Kesulitan dalam mengganti request gambar yang memiliki substring franky untuk diarahkan menuju franky.png pada soal no. 17.
3. Typo pada `mencha`, harusnya `mecha`. Kami terlanjur menggunakan `mencha` di semua konfigurasi.

## Pembagian Tugas
|Nama                   |Soal   |
|:---------------------:|:-----:|
|Muhammad Nevin|1-3|
|Albert Filip Silalahi|4-6|
|Jagad Wijaya Purnomo|7-17|
