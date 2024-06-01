import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _confirmUpload() async {
    if (_image != null) {
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin file yang dipilih sudah benar?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Ya'),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        // Implement the logic to upload the payment proof image
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bukti pembayaran berhasil diupload'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap pilih gambar terlebih dahulu'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: _image != null
                    ? Image.file(
                        _image!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey[700],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Tekan untuk memilih gambar',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmUpload,
              child: Text('Kirim Bukti Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
