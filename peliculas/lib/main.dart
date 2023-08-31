import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(213, 45, 122, 167),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/principal.png',
                    width: 312,
                    height: 217,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Screen\nScape',
                style: GoogleFonts.knewave(
                  color: Colors.white,
                  fontSize: 60,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'peliculas');
                  },
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: 10), // Agrega espacio a la izquierda del icono
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                  label: SizedBox.shrink(),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF080B),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ], // Cierra la lista de children
          ), // Cierra el Column
        ), // Cierra el SafeArea
      ), // Cierra el Scaffold
    ); // Cierra el GestureDetector
  }
}

void main() {
  WidgetsApp.debugAllowBannerOverride = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Scape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 94, 1, 255)),
        useMaterial3: true,
      ),
      home: HomePageWidget(),
    );
  }
}
