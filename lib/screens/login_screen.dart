import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gps_tracker/screens/dashboard_screen.dart';
import 'package:gps_tracker/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}
 class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();

  final _auth = FirebaseAuth.instance;

   @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return null;
        }

        RegExp emailRegExp = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

        if (value.isEmpty) {
          return 'Email can\'t be empty';
        } else if (!emailRegExp.hasMatch(value)) {
          return 'Enter a correct email';
        }

        return null;
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder (
            borderRadius: BorderRadius.circular(10)
        )
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        if (value == null) {
          return null;
        }

        if (value.isEmpty) {
          return 'Password can\'t be empty';
        } else if (value.length < 6) {
          return 'Enter a password with length at least 6';
        }

        return null;
      },
      obscureText: true,
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final loginButton = Material (
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton (
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
     return Scaffold(
       appBar: AppBar(title: Text("Login"), centerTitle: true,),
  backgroundColor: Colors.white,
       body: Center(
         child: SingleChildScrollView(
           child: Container(
              color: Colors.white,
             child: Padding(
               padding: const EdgeInsets.all(36.0),
               child: Form(
                 key: _formKey,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>
                   [
                     SizedBox(
                       height: 200,
                       child: Image.asset(
                         "assets/images/logo.png",
                         fit: BoxFit.contain,
                       ),
                     ),
                     const SizedBox(height: 30,),
                     emailField,
                     const SizedBox(height: 15,),
                     passwordField,
                     const SizedBox(height: 15,),
                     loginButton,
                     const SizedBox(height: 15,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Text("Don't have an account? "),
                       GestureDetector(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegistrationScreen()));
                         },
                         child: const Text("Signup", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.redAccent)),
                       )
                     ],
                   )],

                 ),
               ),
             ),
           ),
         ),
       ),
    );


  }
  void signIn(String email, String password) async {
     EasyLoading.show( status: "Signing in");
    if(_formKey.currentState!.validate()){
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const DashboardScreen()), (route) => false),
          EasyLoading.showSuccess("Logged in successfully")}
              })
          .catchError((e) {
        EasyLoading.showError("Wrong username or password");
      });
    }
    else {
      EasyLoading.showError("Check input");
    }
  }
 }