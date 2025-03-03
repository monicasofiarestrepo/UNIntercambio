import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';

class Postulation {
  final String title;
  final String description;
  final String location;
  final String status;
  final double progress;

  Postulation({
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.progress,
  });
}

class PostulationsList extends StatelessWidget {
  final List<Postulation> postulations;

  const PostulationsList({super.key, required this.postulations});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550, 
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha:0.1), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mis Aplicaciones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "*Los documentos oficiales pueden llegarte a tu correo electrónico",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              // Ensures listview takes remaining space
              child: ListView.builder(
                shrinkWrap: true, // Helps prevent layout issues
                itemCount: postulations.length,
                itemBuilder: (context, index) {
                  final postulation = postulations[index];
                  return PostulationItem(postulation: postulation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostulationItem extends StatelessWidget {
  final Postulation postulation;

  const PostulationItem({super.key, required this.postulation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postulation.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            postulation.description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(postulation.location, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color:  postulation.status == "Activa" ?  Colors.green.shade100 : SystemColors.labelWarning,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    postulation.status == "Activa" ? const Icon(Icons.check_circle_outline, size: 14, color: Colors.green) : const Icon(Icons.error_outline, size: 14, color: Colors.deepOrange),
                    const SizedBox(width: 4),
                    Text(
                      postulation.status,
                      style: TextStyle(fontSize: 14, color: postulation.status == "Activa" ? Colors.green : Colors.deepOrange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          postulation.status == "Activa" ? LinearProgressIndicator(
            value: postulation.progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(10),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
