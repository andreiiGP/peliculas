import 'package:flutter/material.dart';
import 'package:peliculas/loguin.dart';
class HomePageWidget extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Fondo transparente
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pueba.png'), // Imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Espacio para la imagen encima del botón
                    SizedBox(
                      width: 350, // Ancho de la imagen
                      height: 300, // Alto de la imagen
                      child: Image.asset(
                        'assets/principal.png', // Ruta de la imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16), // Espacio entre la imagen y el botón
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IniciosesionWidget(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 60),
                        backgroundColor: Color.fromARGB(156, 70, 135, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(
                          fontFamily: 'Amaranth',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Espacio entre el botón y otros elementos
                    // Resto del contenido aquí...
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IniciosesionWidget(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 60),
                        backgroundColor: Color.fromARGB(156, 70, 135, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Registrate',
                        style: TextStyle(
                          fontFamily: 'Amaranth',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Espacio entre el botón y otros elementos
                    // Resto del contenido aquí...
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
          seedColor: const Color.fromARGB(255, 94, 1, 255),
        ),
        useMaterial3: true,
      ),
      home: HomePageWidget(),
       routes: {
          '/loguin': (context) => const IniciosesionWidget(),
/*           '/menudia': (context) => const Mesa1Widget(),
          '/pantallamesas': (context) => PantallaMesasWidget(),
          '/perfilmesero': (context) => const PerfilmeseroWidget(),
          '/registro': (context) => const RegistroWidget(), */
        });
  }
}
