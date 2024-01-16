// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:apptest/components/my_button.dart';
import 'package:apptest/components/my_textfield.dart';
import 'package:apptest/components/square_tile.dart';
import 'package:apptest/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  //Controller dos Campos Texto e Senha
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Metodo InscreverUsuario
  void signUserUp() async {
    // mostrar circulo carregando
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      // verificar se as senhas são as mesmas

      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }else{
        //as senhas informadas são diferentes
        showErrorMesage('As senhas informadas são diferentes!');
      }
      //Apos carregar o circular progress indicator
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //email inexistentec
      Navigator.pop(context);
      showErrorMesage(e.code);
    }
  }
  // mensagem de erro ao usuario
  void showErrorMesage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                //logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 25),

                //bem vindo

                Text(
                  "Vamos Criar sua Conta!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //nome usuario

                MyTextField(
                  controller: emailController,
                  hintText: 'Insira seu E-mail',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //senha usuario

                MyTextField(
                  controller: passwordController,
                  hintText: 'Insira sua Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirme sua Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //esqueceu a senha?

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                //botão login

                MyButton(
                  text: 'Inscrever-se',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 50),

                //ou continue para

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou continue com',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50),

                //google + apple login

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquereTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                    ),
                    SizedBox(width: 25),
                    SquereTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                SizedBox(height: 50),

                //não é membro? registre-se

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já possui uma conta?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Conecte-se agora!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
