import 'package:flutter/material.dart';

class Kasus2Validasi extends StatefulWidget {
  const Kasus2Validasi({super.key});

  @override
  State<Kasus2Validasi> createState() => _Kasus2ValidasiState();
}

class _Kasus2ValidasiState extends State<Kasus2Validasi> {
  final TextEditingController nominalController = TextEditingController();

  String jumlahPembayaran = '';

  // Format angka menjadi Rupiah tanpa package tambahan
  String formatRupiah(int angka) {
    String angkaString = angka.toString();
    String hasil = '';

    int hitung = 0;

    for (int i = angkaString.length - 1; i >= 0; i--) {
      hasil = angkaString[i] + hasil;
      hitung++;

      if (hitung == 3 && i != 0) {
        hasil = '.$hasil';
        hitung = 0;
      }
    }

    return 'Rp $hasil';
  }

  void prosesPembayaran() {
    // Validasi sesuai instruksi dosen
    if (nominalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominal uang tidak boleh kosong!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final int? angka = int.tryParse(nominalController.text.trim());

      if (angka == null || angka <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nominal harus berupa angka yang valid!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      setState(() {
        jumlahPembayaran = angka.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pembayaran berhasil diproses!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void hapusNominal() {
    setState(() {
      nominalController.clear();
      jumlahPembayaran = '';
    });
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int? nominal = int.tryParse(jumlahPembayaran);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Kasus 2 - Form Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),

            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ICON
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.payments_rounded,
                        size: 36,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Form Pembayaran',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Masukkan nominal uang yang akan dibayarkan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Nominal Uang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: nominalController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        hintText: 'Contoh: 50000',

                        prefixIcon: const Icon(
                          Icons.account_balance_wallet_outlined,
                        ),

                        prefixText: 'Rp ',

                        suffixIcon: IconButton(
                          onPressed: hapusNominal,
                          icon: const Icon(Icons.clear),
                          tooltip: 'Hapus',
                        ),

                        filled: true,
                        fillColor: const Color(0xFFF7F8FC),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                      ),

                      onSubmitted: (_) {
                        prosesPembayaran();
                      },
                    ),

                    const SizedBox(height: 20),

                    // BUTTON BAYAR
                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: prosesPembayaran,
                        icon: const Icon(Icons.payment_rounded),
                        label: const Text(
                          'Bayar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // HASIL PEMBAYARAN
                    if (nominal != null)
                      Card(
                        elevation: 0,
                        color: Colors.green.withOpacity(0.08),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Colors.green.withOpacity(0.25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),

                          child: Column(
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 42,
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                'Pembayaran Berhasil',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Jumlah Pembayaran',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                formatRupiah(nominal),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 18),

                    // INFO
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.indigo,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Nominal tidak boleh kosong dan harus '
                              'berupa angka yang valid.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}