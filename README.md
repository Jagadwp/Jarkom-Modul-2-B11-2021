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

  ![02-01](https://user-images.githubusercontent.com/31863229/138604972-862e5f21-579f-497b-88d8-a89c397ccc23.PNG)
- Buat folder `kaizoku` di dalam `/etc/bind`.

  ```
  mkdir /etc/bind/kaizoku
  ```
- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `kaizoku` yang baru saja dibuat dan ubah namanya menjadi `franky.B11.com`.

  ```
  cp /etc/bind/db.local /etc/bind/kaizoku/franky.B11.com
  ```
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![02-02](https://user-images.githubusercontent.com/31863229/138604974-f22d570b-8983-4057-b538-99a0b1eae771.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Edit file `/etc/resolv.conf` seperti pada gambar berikut:

  ![02-03](https://user-images.githubusercontent.com/31863229/138604976-c91c2357-e94c-4f4c-bd8e-9688a03cbd93.PNG)
- Lakukan ping domain `franky.B11.com` dan `www.franky.B11.com`.

  ![02-04](https://user-images.githubusercontent.com/31863229/138604968-bf89f8dc-6855-4aec-a54f-d51bd2aa9aa8.PNG)

## Soal 3
Setelah itu buat subdomain `super.franky.yyy.com` dengan alias `www.super.franky.yyy.com` yang diatur DNS nya di EniesLobby dan mengarah ke Skypie.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![03-01](https://user-images.githubusercontent.com/31863229/138607683-fc9a0ab3-0f2d-495a-95a4-190a4406d690.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `super.franky.B11.com`.

  ![03-02](https://user-images.githubusercontent.com/31863229/138607616-7a3e2c4f-a9fa-46e1-8869-b06c06439484.PNG)

## Soal 4
Buat juga reverse domain untuk domain utama.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![04-01](https://user-images.githubusercontent.com/31863229/138608215-9c81c5c6-841d-4ee6-ac97-c9aeac83c857.PNG)
- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `kaizoku` yang baru saja dibuat dan ubah namanya menjadi `2.182.192.in-addr.arpa`.

  ```
  cp /etc/bind/db.local /etc/bind/kaizoku/2.182.192.in-addr.arpa
  ```
- Edit file `/etc/bind/kaizoku/2.182.192.in-addr.arpa` seperti pada gambar berikut:

  ![04-02](https://user-images.githubusercontent.com/31863229/138608218-aad67a21-2e26-4515-8d30-0dbcc785486b.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan pengecekan konfigurasi dengan perintah `host -t PTR 192.182.2.2`.

  ![04-03](https://user-images.githubusercontent.com/31863229/138608220-e9af715c-628e-45c3-b9df-8dd90118ab26.PNG)

## Soal 5
Supaya tetap bisa menghubungi Franky jika server EniesLobby rusak, maka buat Water7 sebagai DNS Slave untuk domain utama.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![05-01](https://user-images.githubusercontent.com/31863229/138608897-e941962a-ae1c-4ad9-9bf9-661c8a66e0e0.PNG)
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

  ![05-02](https://user-images.githubusercontent.com/31863229/138608898-a4c81747-c995-48aa-85c9-8568fc688b21.PNG)
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

  ![05-03](https://user-images.githubusercontent.com/31863229/138608902-ba9806a8-549e-48c7-993d-ae9310eee1ab.PNG)
- Lakukan ping domain `franky.B11.com`.

  ![05-04](https://user-images.githubusercontent.com/31863229/138608904-4f897143-9edb-4dbe-a7cf-bd6ff15136f3.PNG)

## Soal 6
Setelah itu terdapat subdomain `mecha.franky.yyy.com` dengan alias `www.mecha.franky.yyy.com` yang didelegasikan dari EniesLobby ke Water7 dengan IP menuju ke Skypie dalam folder sunnygo.

### Jawaban
**Pada EniesLobby**
- Edit file `/etc/bind/kaizoku/franky.B11.com` seperti pada gambar berikut:

  ![06-01](https://user-images.githubusercontent.com/31863229/138610108-06d654ab-72af-4542-84ca-d11191b4addf.PNG)
- Edit file `/etc/bind/named.conf.options` seperti pada gambar berikut:

  ![06-02](https://user-images.githubusercontent.com/31863229/138610112-b124ab94-3095-434c-ae01-60a57421e6a6.PNG)
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![06-03](https://user-images.githubusercontent.com/31863229/138610113-ca288dab-be46-4c48-a19c-a17fcde19478.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Water7**
- Edit file `/etc/bind/named.conf.options` seperti pada gambar berikut:

  ![06-04](https://user-images.githubusercontent.com/31863229/138610114-8ee223f2-c04b-4b03-b809-4093ad35d3a3.PNG)
- Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

  ![06-05](https://user-images.githubusercontent.com/31863229/138610115-7fff082c-e675-4b64-bcfd-8ec4d1e16379.PNG)
- Buat folder `sunnygo` di dalam `/etc/bind`.

  ```
  mkdir /etc/bind/sunnygo
  ```
- Copykan file `db.local` pada path `/etc/bind` ke dalam folder `sunnygo` yang baru saja dibuat dan ubah namanya menjadi `mecha.franky.B11.com`.

  ```
  cp /etc/bind/db.local /etc/bind/sunnygo/mecha.franky.B11.com
  ```
- Edit file `/etc/bind/sunnygo/mecha.franky.B11.com` seperti pada gambar berikut:

  ![06-06](https://user-images.githubusercontent.com/31863229/138610118-db206c8e-fa3e-48a9-b985-c00fb991f75f.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `mecha.franky.B11.com` dan `www.mecha.franky.B11.com`.

  ![06-07](https://user-images.githubusercontent.com/31863229/138610119-68f7a6ec-87a2-49ca-b6bc-615d3380a52d.PNG)

## Soal 7
Untuk memperlancar komunikasi Luffy dan rekannya, dibuatkan subdomain melalui Water7 dengan nama `general.mecha.franky.yyy.com` dengan alias `www.general.mecha.franky.yyy.com` yang mengarah ke Skypie.

### Jawaban
**Pada Water7**
- Edit file `/etc/bind/sunnygo/mecha.franky.B11.com` seperti pada gambar berikut:

  ![07-01](https://user-images.githubusercontent.com/31863229/138610375-671877c7-1fac-48be-ae53-e183062fde0b.PNG)
- Restart bind9.

  ```
  service bind9 restart
  ```

**Pada Loguetown**
- Lakukan ping domain `general.mecha.franky.B11.com`.

  ![07-02](https://user-images.githubusercontent.com/31863229/138610376-36e4f097-cddd-4a9a-a5ad-222803544258.PNG)

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
Dan Luffy meminta untuk web `www.general.mecha.franky.yyy.com` hanya bisa diakses dengan port 15000 dan port 15500.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Copy file `000-default.conf` menjadi file `general.mecha.franky.B11.com.conf`.
- Edit file `general.mecha.franky.B11.com.conf` seperti pada gambar berikut:

  ![14-01](https://user-images.githubusercontent.com/67728406/139527233-8db0ea26-1f30-4a1f-92bd-9ff57b48a197.png)

- Edit file `/etc/apache2/ports.conf` untuk mengaktifkan port 15000 dan port 15500 seperti pada gambar berikut:

  ![14-02](https://user-images.githubusercontent.com/67728406/139527252-3681f195-8ddd-4834-95fa-b28e66c1d8f8.png)

- Aktifkan konfigurasi general.mecha.franky.B11.com.

  ```
  a2ensite general.mecha.franky.B11.com
  ```
- Restart apache.

  ```
  service apache2 restart
  ```
- Pindah ke directory `/var/www`.
- Download file zip menggunakan `wget`.

  ```
  wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/general.mecha.franky.zip
  ```
- Lakukan unzip.

  ```
  unzip general.mecha.franky.zip
  ```
- Rename folder `general.mecha.franky` menjadi `general.mecha.franky.B11.com` dan terdapat isi file seperti pada gambar berikut:

  ![14-03](https://user-images.githubusercontent.com/67728406/139527268-f280c25c-b144-4a84-94b8-7966854909da.png)


**Pada Loguetown**
- Buka `general.mecha.franky.B11.com` menggunakan lynx.

  ![14-04](https://user-images.githubusercontent.com/31863229/138662635-4721d99a-0698-46f6-ad73-29b1dcc08a3e.PNG)
- Buka `general.mecha.franky.B11.com:15000` menggunakan lynx.

  ![14-05](https://user-images.githubusercontent.com/67728406/139527305-b9305f2e-81ac-4bc0-b123-19d85192f3f0.png)

- Buka `general.mecha.franky.B11.com:15500` menggunakan lynx.

  ![14-06](https://user-images.githubusercontent.com/67728406/139527305-b9305f2e-81ac-4bc0-b123-19d85192f3f0.png)

## Soal 15
Dengan authentikasi username `luffy` dan password `onepiece` dan file di `/var/www/general.mecha.franky.yyy`.

### Jawaban
**Pada Skypie**
- Pindah ke directory `/etc/apache2/sites-available`.
- Edit file  `.htaccess` pada `general.mecha.franky.B11.com.conf` seperti pada gambar berikut:

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
- Buka `general.mecha.franky.B11.com:15000` menggunakan lynx dengan username `luffy` dan password `onepiece`.

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

## Pembagian Tugas
|Nama                   |Soal   |
|:---------------------:|:-----:|
|nama|soal|
|nama|soal|
|Jagad Wijaya Purnomo|7-17|
