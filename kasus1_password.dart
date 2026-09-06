import 'package:flutter/material.dart';

class Kasus1Password extends StatefulWidget {
  const Kasus1Password({super.key});

  @override
  State<Kasus1Password> createState() => _Kasus1PasswordState();
}

class _Kasus1PasswordState extends State<Kasus1Password> {
  // WAJIB sesuai instruksi dosen
  bool _isObscure = true;

  final TextEditingController _passwordController =
      TextEditingController();

  String _password = '';

  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(_password);
  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(_password);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(_password);

  int get strength {
    int score = 0;

    if (_password.length >= 8) score++;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasNumber) score++;

    return score;
  }

  String get strengthText {
    if (_password.isEmpty) return 'Belum diisi';
    if (strength <= 1) return 'Lemah';
    if (strength == 2) return 'Sedang';
    if (strength == 3) return 'Baik';
    return 'Kuat';
  }

  Color get strengthColor {
    if (_password.isEmpty) return Colors.grey;
    if (strength <= 1) return Colors.red;
    if (strength == 2) return Colors.orange;
    if (strength == 3) return Colors.blue;
    return Colors.green;
  }

  void _cekPassword() {
    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password belum diisi!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (strength < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password masih terlalu lemah!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password sudah cukup baik!'),
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

  Widget _buildCheck(String text, bool active) {
    return Row(
      children: [
        Icon(
          active ? Icons.check_circle : Icons.circle_outlined,
          size: 18,
          color: active ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: active ? Colors.green.shade700 : Colors.grey.shade600,
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
      backgroundColor: const Color(0xFFF4F6FA),

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
                borderRadius: BorderRadius.circular(22),
              ),

              child: Padding(
                padding: const EdgeInsets.all(28),

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
                        Icons.lock_rounded,
                        color: Colors.indigo,
                        size: 36,
                      ),
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TEXTFIELD
                    TextField(
                      controller: _passwordController,

                      // WAJIB
                      obscureText: _isObscure,

                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },

                      decoration: InputDecoration(
                        hintText: 'Masukkan password',

                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),

                        // TOMBOL SHOW / HIDE
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },

                          // IKON DINAMIS
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
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
                    ),

                    const SizedBox(height: 18),

                    // KEKUATAN PASSWORD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Kekuatan Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          strengthText,
                          style: TextStyle(
                            color: strengthColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    LinearProgressIndicator(
                      value: strength / 4,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                      color: strengthColor,
                      backgroundColor: Colors.grey.shade200,
                    ),

                    const SizedBox(height: 18),

                    // CHECKLIST
                    const Text(
                      'Syarat Password:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _buildCheck(
                      'Minimal 8 karakter',
                      _password.length >= 8,
                    ),

                    const SizedBox(height: 7),

                    _buildCheck(
                      'Mengandung huruf besar',
                      hasUppercase,
                    ),

                    const SizedBox(height: 7),

                    _buildCheck(
                      'Mengandung huruf kecil',
                      hasLowercase,
                    ),

                    const SizedBox(height: 7),

                    _buildCheck(
                      'Mengandung angka',
                      hasNumber,
                    ),

                    const SizedBox(height: 25),

                    // BUTTON CEK
                    SizedBox(
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _cekPassword,
                        icon: const Icon(Icons.check_rounded),
                        label: const Text(
                          'Cek Password',
                          style: TextStyle(
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

                    const SizedBox(height: 12),

                    // BUTTON CLEAR
                    SizedBox(
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: _clearPassword,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text(
                          'Hapus Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Gunakan ikon mata untuk menampilkan atau '
                              'menyembunyikan password.',
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