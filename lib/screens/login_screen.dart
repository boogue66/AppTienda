import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/providers/login_form_provider.dart';
import 'package:tienda/ui/input_decorations.dart';
import 'package:tienda/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 180,
          ),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text('Acceso', style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: 10),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),
              ),
            ],
          )),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Crear nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'tucorreo@mail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es correcto.';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Password',
                  prefixIcon: Icons.password),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'El password debe de ser de 6 carateres.';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 5,
                color: Colors.deepPurple,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        await Future.delayed(const Duration(seconds: 2));
                        // TODO_validar si login es correcto
                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(context, 'home');
                      }),
          ],
        ));
  }
}
