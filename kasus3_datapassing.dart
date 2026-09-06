import 'package:flutter/material.dart';

class Kasus3DataPassing extends StatefulWidget {
  const Kasus3DataPassing({super.key});

  @override
  State<Kasus3DataPassing> createState() => _Kasus3DataPassingState();
}

class _Kasus3DataPassingState extends State<Kasus3DataPassing> {
  final TextEditingController namaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemesanan Tiket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Input Pemesanan Tiket',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Pemesan',
                hintText: 'Masukkan nama Anda',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HalamanKonfirmasi(
                      nama: namaController.text,
                    ),
                  ),
                );
              },
              child: const Text('Lanjut ke Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN B
class HalamanKonfirmasi extends StatelessWidget {
  final String nama;

  const HalamanKonfirmasi({
    super.key,
    required this.nama,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pemesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Konfirmasi Pemesanan Tiket',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Nama Pemesan',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}