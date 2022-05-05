import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gps_tracker/model/user_model.dart';
import 'package:gps_tracker/screens/dashboard_screen.dart';
import 'package:gps_tracker/screens/login_screen.dart';
class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
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
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        firstNameEditingController.text = value!;
      },
      validator: (value) {
      if (value == null) {
        return null;
      }

      RegExp emailRegExp = RegExp(r'^.{3,}$');
      if (value.isEmpty) {
        return "First name can't be empty";
      } else if (!emailRegExp.hasMatch(value)) {
        return "First name must be at least 3 characters";
      }

      return null;
    },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        secondNameEditingController.text = value!;
      },
      validator: (value) {
        if (value == null) {
          return null;
        }

        RegExp emailRegExp = RegExp(r'^.{3,}$');
        if (value.isEmpty) {
          return "Second name can't be empty";
        } else if (!emailRegExp.hasMatch(value)) {
          return "Second name must be at least 3 characters";
        }

        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
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
      onSaved: (value){
        passwordEditingController.text = value!;
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
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (value == null) {
          return null;
        }

        if (value.isEmpty || value != passwordEditingController.text) {
          return 'Password do not match';
        }
        return null;
      },
      onSaved: (value){
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder (
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final signupButton = Material (
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton (
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text("SignUp"), centerTitle: true,),

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
                    firstNameField,
                    const SizedBox(height: 15,),
                    secondNameField,
                    const SizedBox(height: 15,),
                    emailField,
                    const SizedBox(height: 15,),
                    passwordField,
                    const SizedBox(height: 15,),
                    confirmPasswordField,
                    const SizedBox(height: 15,),
                    signupButton,
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                          },
                          child: const Text("Login", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.redAccent)),
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


  void signUp (String email, String password) async {

    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "Registering user");
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>{
      postDetailsToFirestore()
      }).catchError((e) => {
        EasyLoading.showError(e)
      });


    }
  }

  postDetailsToFirestore() async {

    //calling firestore
    //calling user model
    //sending the values
    
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    
    // write all values
    
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    
    await firebaseFirestore.collection('user')
    .doc(user.uid)
    .set(userModel.toMap());
    EasyLoading.showSuccess("Account created ");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
  }
}
