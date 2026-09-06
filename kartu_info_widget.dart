import 'package:flutter/material.dart';

class KartuInfoWidget extends StatelessWidget {
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
      shadowColor: warna.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ICON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: warna.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: warna,
                      size: 28,
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // JUDUL
              Text(
                judul,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 5),

              // NILAI
              Text(
                nilai,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // DESKRIPSI
              Text(
                deskripsi,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}