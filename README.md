# Version 2.0
Penambahan fungsi untuk angka desimal
# Mod
Lucky Vic <luckynvic@gmail.com>

# Usage
* Gunakan property Number untuk angka di depan koma. 
* Gunakan decimal untuk angka di belakang koma.
* Gunakan Value untuk menghasilkan angka di depan dan belakang koma.
* Gunakan DecimalNumber untuk menentukan jumlah angka dibelakang koma. 0 = Tidak menggunakan angka desimal

```delphi
var
Angkanya : string;
     begin
     ATTerbilang.DecimalNumber := 2;
     ATTerbilang.Value := 123.45;
	
     Angkanya :=ATTerbilang.Terbilang; { hasilnya akan 'sertaus dua puluh tiga koma empat lima'}
    end;
```
