import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// APP UTAMA
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MenuUtama(),
    );
  }
}

// ============================================================
// MENU UTAMA
// ============================================================

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Praktikum Flutter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const Text(
                  'Dashboard Praktikum 👋',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Pilih studi kasus yang ingin kamu jalankan.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                // =================================================
                // KASUS 1
                // =================================================

                _menuCard(
                  context,
                  icon: Icons.lock_rounded,
                  color: Colors.indigo,
                  title: 'Kasus 1',
                  subtitle: 'Input Password',
                  description:
                      'Show dan Hide Password menggunakan StatefulWidget.',
                  page: const Kasus1Password(),
                ),

                const SizedBox(height: 16),

                // =================================================
                // KASUS 2
                // =================================================

                _menuCard(
                  context,
                  icon: Icons.payments_rounded,
                  color: Colors.teal,
                  title: 'Kasus 2',
                  subtitle: 'Form Pembayaran',
                  description:
                      'Validasi nominal uang menggunakan SnackBar.',
                  page: const Kasus2Validasi(),
                ),

                const SizedBox(height: 16),

                // =================================================
                // KASUS 3
                // =================================================

                _menuCard(
                  context,
                  icon: Icons.confirmation_num_rounded,
                  color: Colors.deepOrange,
                  title: 'Kasus 3',
                  subtitle: 'Pemesanan Tiket',
                  description:
                      'Pengiriman data pemesan antar halaman.',
                  page: const Kasus3DataPassing(),
                ),

                const SizedBox(height: 16),

                // =================================================
                // KASUS 4
                // =================================================

                _menuCard(
                  context,
                  icon: Icons.widgets_rounded,
                  color: Colors.purple,
                  title: 'Kasus 4',
                  subtitle: 'Reusable Widget',
                  description:
                      'Penerapan Clean Code dengan Custom Widget.',
                  page: const Kasus4ReusableWidget(),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(
                    'Pemrograman Berbasis Platform • Flutter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String description,
    required Widget page,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KASUS 1 - INPUT PASSWORD
// ============================================================

class Kasus1Password extends StatefulWidget {
  const Kasus1Password({super.key});

  @override
  State<Kasus1Password> createState() =>
      _Kasus1PasswordState();
}

class _Kasus1PasswordState
    extends State<Kasus1Password> {

  bool _isObscure = true;

  final TextEditingController _passwordController =
      TextEditingController();

  String _password = '';

  bool get hasUppercase =>
      RegExp(r'[A-Z]').hasMatch(_password);

  bool get hasLowercase =>
      RegExp(r'[a-z]').hasMatch(_password);

  bool get hasNumber =>
      RegExp(r'[0-9]').hasMatch(_password);

  int get strength {
    int score = 0;

    if (_password.length >= 8) score++;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasNumber) score++;

    return score;
  }

  String get strengthText {
    if (_password.isEmpty) {
      return 'Belum diisi';
    }

    if (strength <= 1) {
      return 'Lemah';
    }

    if (strength == 2) {
      return 'Sedang';
    }

    if (strength == 3) {
      return 'Baik';
    }

    return 'Kuat';
  }

  Color get strengthColor {
    if (_password.isEmpty) {
      return Colors.grey;
    }

    if (strength <= 1) {
      return Colors.red;
    }

    if (strength == 2) {
      return Colors.orange;
    }

    if (strength == 3) {
      return Colors.blue;
    }

    return Colors.green;
  }

  void _cekPassword() {
    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password belum diisi!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    if (strength < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password masih terlalu lemah!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password sudah cukup baik!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _clearPassword() {
    setState(() {
      _passwordController.clear();
      _password = '';
      _isObscure = true;
    });
  }

  Widget _checkItem(
    String text,
    bool aktif,
  ) {
    return Row(
      children: [
        Icon(
          aktif
              ? Icons.check_circle
              : Icons.circle_outlined,
          size: 18,
          color:
              aktif ? Colors.green : Colors.grey,
        ),

        const SizedBox(width: 8),

        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: aktif
                ? Colors.green.shade700
                : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Kasus 1 - Input Password',
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
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,

                  children: [
                    const Icon(
                      Icons.lock_rounded,
                      size: 60,
                      color: Colors.indigo,
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Buat Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Masukkan password yang aman untuk melanjutkan.',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                          _passwordController,

                      // WAJIB
                      obscureText:
                          _isObscure,

                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },

                      decoration:
                          InputDecoration(
                        hintText:
                            'Masukkan password',

                        prefixIcon:
                            const Icon(
                          Icons.lock_outline,
                        ),

                        suffixIcon:
                            IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure =
                                  !_isObscure;
                            });
                          },

                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [
                        const Text(
                          'Kekuatan Password',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        Text(
                          strengthText,
                          style: TextStyle(
                            color:
                                strengthColor,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    LinearProgressIndicator(
                      value: strength / 4,
                      minHeight: 8,
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Syarat Password:',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _checkItem(
                      'Minimal 8 karakter',
                      _password.length >= 8,
                    ),

                    const SizedBox(height: 7),

                    _checkItem(
                      'Mengandung huruf besar',
                      hasUppercase,
                    ),

                    const SizedBox(height: 7),

                    _checkItem(
                      'Mengandung huruf kecil',
                      hasLowercase,
                    ),

                    const SizedBox(height: 7),

                    _checkItem(
                      'Mengandung angka',
                      hasNumber,
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 52,

                      child:
                          ElevatedButton.icon(
                        onPressed:
                            _cekPassword,

                        icon: const Icon(
                          Icons.check_rounded,
                        ),

                        label: const Text(
                          'Cek Password',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 52,

                      child:
                          OutlinedButton.icon(
                        onPressed:
                            _clearPassword,

                        icon: const Icon(
                          Icons.delete_outline,
                        ),

                        label: const Text(
                          'Hapus Password',
                        ),
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

// ============================================================
// KASUS 2 - FORM PEMBAYARAN
// ============================================================

class Kasus2Validasi extends StatefulWidget {
  const Kasus2Validasi({super.key});

  @override
  State<Kasus2Validasi> createState() =>
      _Kasus2ValidasiState();
}

class _Kasus2ValidasiState
    extends State<Kasus2Validasi> {

  final TextEditingController
      nominalController =
      TextEditingController();

  String jumlahPembayaran = '';

  String formatRupiah(int angka) {
    String angkaString =
        angka.toString();

    String hasil = '';

    int hitung = 0;

    for (
      int i = angkaString.length - 1;
      i >= 0;
      i--
    ) {
      hasil =
          angkaString[i] + hasil;

      hitung++;

      if (hitung == 3 && i != 0) {
        hasil = '.$hasil';
        hitung = 0;
      }
    }

    return 'Rp $hasil';
  }

  void prosesPembayaran() {
    if (nominalController.text
        .trim()
        .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Nominal uang tidak boleh kosong!',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    } else {
      final int? angka =
          int.tryParse(
        nominalController.text.trim(),
      );

      if (angka == null || angka <= 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Nominal harus berupa angka yang valid!',
            ),
            behavior:
                SnackBarBehavior.floating,
          ),
        );

        return;
      }

      setState(() {
        jumlahPembayaran =
            angka.toString();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Pembayaran berhasil diproses!',
          ),
          behavior:
              SnackBarBehavior.floating,
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
    final int? nominal =
        int.tryParse(
      jumlahPembayaran,
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Kasus 2 - Form Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        backgroundColor:
            Colors.indigo,

        foregroundColor:
            Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 500,
            ),

            child: Card(
              elevation: 5,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,

                  children: [
                    const Icon(
                      Icons.payments_rounded,
                      size: 60,
                      color: Colors.indigo,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Form Pembayaran',
                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Masukkan nominal uang yang akan dibayarkan.',
                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Nominal Uang',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                          nominalController,

                      keyboardType:
                          TextInputType.number,

                      decoration:
                          InputDecoration(
                        hintText:
                            'Contoh: 50000',

                        prefixText: 'Rp ',

                        prefixIcon:
                            const Icon(
                          Icons
                              .account_balance_wallet_outlined,
                        ),

                        suffixIcon:
                            IconButton(
                          onPressed:
                              hapusNominal,

                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),

                      onSubmitted: (_) {
                        prosesPembayaran();
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 52,

                      child:
                          ElevatedButton.icon(
                        onPressed:
                            prosesPembayaran,

                        icon: const Icon(
                          Icons.payment_rounded,
                        ),

                        label: const Text(
                          'Bayar',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    if (nominal != null)
                      Card(
                        color: Colors.green
                            .withOpacity(0.08),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                            20,
                          ),

                          child: Column(
                            children: [
                              const Icon(
                                Icons
                                    .check_circle_rounded,
                                color:
                                    Colors.green,
                                size: 42,
                              ),

                              const SizedBox(
                                  height: 10),

                              const Text(
                                'Pembayaran Berhasil',
                                style:
                                    TextStyle(
                                  color:
                                      Colors.green,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              const Text(
                                'Jumlah Pembayaran',
                              ),

                              const SizedBox(
                                  height: 6),

                              Text(
                                formatRupiah(
                                  nominal,
                                ),

                                style:
                                    const TextStyle(
                                  fontSize: 28,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
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

// ============================================================
// KASUS 3 - DATA PASSING
// ============================================================

class Kasus3DataPassing
    extends StatefulWidget {

  const Kasus3DataPassing({
    super.key,
  });

  @override
  State<Kasus3DataPassing> createState() =>
      _Kasus3DataPassingState();
}

class _Kasus3DataPassingState
    extends State<Kasus3DataPassing> {

  final TextEditingController
      namaController =
      TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kasus 3 - Pemesanan Tiket',
        ),

        backgroundColor:
            Colors.deepOrange,

        foregroundColor:
            Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 500,
            ),

            child: Card(
              elevation: 5,

              child: Padding(
                padding:
                    const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,

                  children: [
                    const Icon(
                      Icons
                          .confirmation_num_rounded,

                      size: 60,

                      color:
                          Colors.deepOrange,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Pemesanan Tiket',
                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller:
                          namaController,

                      decoration:
                          InputDecoration(
                        labelText:
                            'Nama Pemesan',

                        hintText:
                            'Masukkan nama Anda',

                        prefixIcon:
                            const Icon(
                          Icons.person_outline,
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 52,

                      child:
                          ElevatedButton.icon(
                        onPressed: () {
                          final nama =
                              namaController
                                  .text
                                  .trim();

                          if (nama.isEmpty) {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Nama pemesan tidak boleh kosong!',
                                ),
                              ),
                            );

                            return;
                          }

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      HalamanKonfirmasi(
                                nama: nama,
                              ),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons
                              .arrow_forward_rounded,
                        ),

                        label: const Text(
                          'Lanjut ke Pembayaran',

                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
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

// ============================================================
// HALAMAN KONFIRMASI KASUS 3
// ============================================================

class HalamanKonfirmasi
    extends StatelessWidget {

  final String nama;

  const HalamanKonfirmasi({
    super.key,
    required this.nama,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pemesanan',
        ),

        backgroundColor:
            Colors.deepOrange,

        foregroundColor:
            Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 5,

            child: Padding(
              padding:
                  const EdgeInsets.all(25),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 65,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Konfirmasi Pemesanan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Nama Pemesan',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    nama,
                    textAlign:
                        TextAlign.center,

                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },

                      icon: const Icon(
                        Icons
                            .arrow_back_rounded,
                      ),

                      label: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KASUS 4 - REUSABLE WIDGET
// ============================================================

class Kasus4ReusableWidget
    extends StatelessWidget {

  const Kasus4ReusableWidget({
    super.key,
  });

  void tampilkanPesan(
    BuildContext context,
    String pesan,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior:
            SnackBarBehavior.floating,
        duration:
            const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          'Kasus 4 - Reusable Widget',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        backgroundColor:
            Colors.indigo,

        foregroundColor:
            Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 900,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                const SizedBox(height: 10),

                const Text(
                  'Dashboard Informasi 📊',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Contoh penerapan Reusable Widget pada Flutter.',
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color:
                        Colors.indigo
                            .withOpacity(0.06),

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons
                            .cleaning_services_rounded,
                        color:
                            Colors.indigo,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          'Satu desain Card dapat digunakan '
                          'berulang kali dengan data yang berbeda.',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                LayoutBuilder(
                  builder:
                      (context, constraints) {
                    int kolom = 1;

                    if (constraints
                            .maxWidth >=
                        800) {
                      kolom = 3;
                    } else if (constraints
                            .maxWidth >=
                        500) {
                      kolom = 2;
                    }

                    return GridView.count(
                      crossAxisCount:
                          kolom,

                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      crossAxisSpacing:
                          16,

                      mainAxisSpacing:
                          16,

                      childAspectRatio:
                          1.15,

                      children: [
                        KartuInfoWidget(
                          icon: Icons
                              .people_alt_rounded,

                          warna:
                              Colors.indigo,

                          judul:
                              'Mahasiswa',

                          nilai:
                              '1.245',

                          deskripsi:
                              'Jumlah mahasiswa yang terdaftar.',

                          onTap: () {
                            tampilkanPesan(
                              context,
                              'Data Mahasiswa dipilih',
                            );
                          },
                        ),

                        KartuInfoWidget(
                          icon:
                              Icons.school_rounded,

                          warna:
                              Colors.teal,

                          judul:
                              'Dosen',

                          nilai:
                              '86',

                          deskripsi:
                              'Jumlah dosen aktif.',

                          onTap: () {
                            tampilkanPesan(
                              context,
                              'Data Dosen dipilih',
                            );
                          },
                        ),

                        KartuInfoWidget(
                          icon:
                              Icons.menu_book_rounded,

                          warna:
                              Colors.orange,

                          judul:
                              'Mata Kuliah',

                          nilai:
                              '72',

                          deskripsi:
                              'Mata kuliah yang tersedia.',

                          onTap: () {
                            tampilkanPesan(
                              context,
                              'Data Mata Kuliah dipilih',
                            );
                          },
                        ),

                        KartuInfoWidget(
                          icon:
                              Icons.assignment_rounded,

                          warna:
                              Colors.purple,

                          judul:
                              'Tugas',

                          nilai:
                              '24',

                          deskripsi:
                              'Tugas yang sedang dikerjakan.',

                          onTap: () {
                            tampilkanPesan(
                              context,
                              'Data Tugas dipilih',
                            );
                          },
                        ),

                        KartuInfoWidget(
                          icon:
                              Icons.check_circle_rounded,

                          warna:
                              Colors.green,

                          judul:
                              'Selesai',

                          nilai:
                              '18',

                          deskripsi:
                              'Tugas yang telah diselesaikan.',

                          onTap: () {
                            tampilkanPesan(
                              context,
                              'Data tugas selesai dipilih',
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),

                  child: const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Text(
                        'Keuntungan Reusable Widget',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        '✓ Mengurangi pengulangan kode',
                      ),

                      Text(
                        '✓ Kode lebih rapi dan mudah dibaca',
                      ),

                      Text(
                        '✓ Mudah melakukan pemeliharaan',
                      ),

                      Text(
                        '✓ Desain cukup dibuat satu kali',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KARTU INFO - REUSABLE WIDGET
// ============================================================

class KartuInfoWidget
    extends StatelessWidget {

  final IconData icon;
  final Color warna;
  final String judul;
  final String nilai;
  final String deskripsi;
  final VoidCallback? onTap;

  const KartuInfoWidget({
    super.key,
    required this.icon,
    required this.warna,
    required this.judul,
    required this.nilai,
    required this.deskripsi,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(20),

        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  Container(
                    width: 52,
                    height: 52,

                    decoration:
                        BoxDecoration(
                      color: warna
                          .withOpacity(0.10),

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: Icon(
                      icon,
                      color: warna,
                      size: 28,
                    ),
                  ),

                  Icon(
                    Icons
                        .arrow_forward_ios_rounded,
                    size: 15,
                    color:
                        Colors.grey.shade400,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                judul,

                style: TextStyle(
                  fontSize: 14,
                  color:
                      Colors.grey.shade600,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                nilai,

                style: const TextStyle(
                  fontSize: 25,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                deskripsi,

                maxLines: 2,

                overflow:
                    TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}