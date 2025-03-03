import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';
import 'package:un_intercambio/core/theme.dart'; // Importar colores
import 'package:flutter/services.dart'; // Para capturar la tecla Enter

//TODO revisar si se pueden utilizar widgets o colores ya creados

// Representación de un estudiante
class Estudiante {
  final String nombre;
  final String avatarUrl;

  Estudiante({required this.nombre, required this.avatarUrl});
}

class ChatPage extends StatefulWidget {
  final String title;

  const ChatPage({super.key, required this.title});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  String? _currentChatStudent; // Ahora puede ser nulo hasta que se seleccione un chat
  Estudiante? _currentStudent; // Guardamos el estudiante seleccionado

  // Lista de estudiantes
  final List<Estudiante> estudiantes = [
    Estudiante(nombre: 'Juanita Perez', avatarUrl: 'assets/images/avatar1.png'),
    Estudiante(nombre: 'Maria Garcia', avatarUrl: 'assets/images/avatar2.png'),
    Estudiante(nombre: 'Luis Morales', avatarUrl: 'assets/images/avatar3.png'),
    // Añadir más estudiantes si es necesario
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text); // Agregar el mensaje escrito por el usuario
      });
      _controller.clear();

      // Respuesta automática con "Hola"
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _messages.add("Hola"); // Agregar la respuesta "Hola"
        });
      });
    }
  }

  void _startChat(Estudiante estudiante) {
    setState(() {
      _currentChatStudent = estudiante.nombre;  // Establecer el nombre del estudiante actual
      _currentStudent = estudiante;  // Guardar el estudiante seleccionado
      _messages.clear(); // Limpiar los mensajes anteriores cuando se inicia un nuevo chat
    });
  }

  void _goBackToChats() {
    setState(() {
      _currentChatStudent = null;
      _currentStudent = null; // Limpiar la selección del chat
    });
  }

  // Función para capturar la tecla Enter
  void _onKey(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      _sendMessage(); // Enviar mensaje cuando se presiona Enter
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 2, // Índice para la pantalla de chat
      child: Column(
        children: [
          const SizedBox(height: 100),
          // Título del chat con el nombre del estudiante y su foto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _currentStudent == null
                ? Text(
                    widget.title.isNotEmpty ? widget.title : 'Selecciona un chat',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: SystemColors.primaryBlue, // Usando el color primario
                    ),
                  )
                : Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: SystemColors.primaryBlue),
                        onPressed: _goBackToChats, // Llamar la función para retroceder
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(_currentStudent!.avatarUrl),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _currentStudent!.nombre,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: SystemColors.primaryBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
          
          // Lista de estudiantes (Chats)
          Expanded(
            child: _currentChatStudent == null
                ? ListView.builder(
                    itemCount: estudiantes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(estudiantes[index].avatarUrl),
                        ),
                        title: Text(
                          estudiantes[index].nombre,
                          style: const TextStyle(color: SystemColors.primaryGreenDark,  fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _startChat(estudiantes[index]);
                        },
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      bool isUserMessage = index % 2 == 0; // Mensaje del usuario (gris) o del estudiante (azul)
                      return Align(
                        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isUserMessage ? Colors.grey[300] : SystemColors.primaryBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _messages[index],
                            style: TextStyle(
                              color: isUserMessage ? Colors.black : Colors.white, // Ajustar el color del texto
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Caja de entrada de texto y botón para enviar, solo visible cuando se selecciona un estudiante
          if (_currentChatStudent != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              // ignore: deprecated_member_use
              child: RawKeyboardListener(
                onKey: _onKey, // Capturamos la tecla presionada
                focusNode: FocusNode(), // Necesario para que el teclado capture la entrada
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Escribe un mensaje...',
                          hintStyle: const TextStyle(color: SystemColors.neutralMedium),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: SystemColors.neutralMedium),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: SystemColors.labelActive),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send, color: SystemColors.primaryBlue), // Color del icono
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
