import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';

class UserProfilePage extends StatelessWidget {
  final String title;
  
  const UserProfilePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 3,
    
      child: Center (child:
      Column (
      
      children: 
      [
        SizedBox(height: 120,),
        Text("Estudiante 1", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        SizedBox(height: 30,),

        Container(
        width: 380,
        height: 550,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.grey.shade100,
        ),
        padding: EdgeInsets.all(30),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset('assets/images/avatar2.png'),
          ),
              InfoText(label: "Promedio", value: "4.8"),
              InfoText(label: "Avance", value: "81%"),
              InfoText(label: "Carrera", value: "Ing. Administrativa"),
              InfoText(label: "Idiomas", value: "Inglés B1 y portugués A2"),
              InfoText(label: "Correo", value: "estudiantosa@unal.edu.co"),
              InfoText(label: "Celular", value: "3044833098"),

          Center(child: Column(children: [
            Icon(Icons.upload_file, size: 60),
            Text("Hoja de Vida", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ],),)


        ],)
      )],
      ))
    );
  }
}


class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
