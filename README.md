# Jarkom-Modul-2-B11-2021

## **Kelompok B-11**
- Muhammad Nevin        (05111940000079)
- Albert Filip Silalahi (05111940000116)
- Jagad Wijaya Purnomo	(05111940000132)

## **Nomor 1**
EniesLobby akan dijadikan sebagai DNS Master, Water7 akan dijadikan DNS Slave, dan Skypie akan digunakan sebagai Web Server. Terdapat 2 Client yaitu Loguetown, dan Alabasta. Semua node terhubung pada router Foosha, sehingga dapat mengakses internet.

### Solusi
Topologi :
![image](https://user-images.githubusercontent.com/55067921/139101398-fd61904a-18ee-4bb9-aa13-e9741178bccc.png)


## **Nomor 2**
Luffy ingin menghubungi Franky yang berada di EniesLobby dengan denden mushi. Kalian diminta Luffy untuk membuat website utama dengan mengakses franky.yyy.com dengan alias www.franky.yyy.com pada folder kaizoku.

### Solusi


## **Nomor 3**
Setelah itu buat subdomain super.franky.yyy.com dengan alias www.super.franky.yyy.com yang diatur DNS nya di EniesLobby dan mengarah ke Skypie.

### Solusi


## **Nomor 4**
Buat juga reverse domain untuk domain utama.

### Solusi


## **Nomor 5**
Supaya tetap bisa menghubungi Franky jika server EniesLobby rusak, maka buat Water7 sebagai DNS Slave untuk domain utama.

### Solusi


## **Nomor 6**
Setelah itu terdapat subdomain mecha.franky.yyy.com dengan alias www.mecha.franky.yyy.com yang didelegasikan dari EniesLobby ke Water7 dengan IP menuju ke Skypie dalam folder sunnygo.

### Solusi


## **Nomor 7**
Untuk memperlancar komunikasi Luffy dan rekannya, dibuatkan subdomain melalui Water7 dengan nama general.mecha.franky.yyy.com dengan alias www.general.mecha.franky.yyy.com yang mengarah ke Skypie.

### Solusi


## **Nomor 8**
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.franky.yyy.com. Pertama, luffy membutuhkan webserver dengan DocumentRoot pada /var/www/franky.yyy.com.

### Solusi


## **Nomor 9**
Setelah itu, Luffy juga membutuhkan agar url www.franky.yyy.com/index.php/home dapat menjadi menjadi www.franky.yyy.com/home.

### Solusi


## **Nomor 10**
Setelah itu, pada subdomain www.super.franky.yyy.com, Luffy membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/super.franky.yyy.com.

### Solusi


## **Nomor 11**
Akan tetapi, pada folder /public, Luffy ingin hanya dapat melakukan directory listing saja.

### Solusi


## **Nomor 12**
Tidak hanya itu, Luffy juga menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache.

### Solusi


## **Nomor 13**
Luffy juga meminta Nami untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.super.franky.yyy.com/public/js menjadi www.super.franky.yyy.com/js.

### Solusi


## **Nomor 14**
Dan Luffy meminta untuk web www.general.mecha.franky.yyy.com hanya bisa diakses dengan port 15000 dan port 15500

### Solusi


## **Nomor 15**
engan autentikasi username luffy dan password onepiece dan file di /var/www/general.mecha.franky.yyy

### Solusi


## **Nomor 16**
Dan setiap kali mengakses IP Skypie akan dialihkan secara otomatis ke www.franky.yyy.com 

### Solusi


## **Nomor 17**
Dikarenakan Franky juga ingin mengajak temannya untuk dapat menghubunginya melalui website www.super.franky.yyy.com, dan dikarenakan pengunjung web server pasti akan bingung dengan randomnya images yang ada, maka Franky juga meminta untuk mengganti request gambar yang memiliki substring “franky” akan diarahkan menuju franky.png. Maka bantulah Luffy untuk membuat konfigurasi dns dan web server ini!


### Solusi
