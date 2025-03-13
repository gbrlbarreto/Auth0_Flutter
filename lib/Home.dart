import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Auth0 auth0;
  bool isLoading = false;

  _deslogarUsuario() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              Text("Usuario logado. Bem-vindo!"),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Center(
                  child:
                      isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                            child: Text(
                              "Deslogar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.green,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.fromLTRB(32, 16, 32, 16),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _deslogarUsuario();
                            },
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
