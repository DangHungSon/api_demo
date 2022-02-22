import 'package:api_demo/blocs/auth_blocs/auth_bloc.dart';
import 'package:api_demo/blocs/auth_blocs/auth_events.dart';
import 'package:api_demo/blocs/auth_blocs/auth_states.dart';
import 'package:api_demo/home.dart';
import 'package:api_demo/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Username controller
  final _userNameController = TextEditingController();

  //Password controller
  final _passwordController = TextEditingController();


  @override
  void initState() {
    _getLogin();
    super.initState();
  }
  _requestLogin() {
    BlocProvider.of<AuthBloc>(context).add(RequestLoginEvent(
        userName: _userNameController.text,
        passWord: _passwordController.text));
  }

  _getLogin() async {
    final pref = await SharedPreferencesService.instance;
    _userNameController.text = pref.userCode == 'Son' ? 'Son' : '';
    _passwordController.text = pref.password == '123456' ? '123456' : '';
    setState(() {});
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => _buildUI(context),
        listener: (context, state) {
          if (state is AuthLoading) {
          } else if (state is AuthLoaded) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else if (state is AuthError) {}
        });
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 50,
          right: 50,
          top: 120,
        ),
        child: Column(
          children: [
            _login(context),
            const SizedBox(height: 15),
            _loginButton(context),
            _or(context),
            _otherLoginForm(context),
            _register(context)
          ],
        ),
      ),
    );
  }

  //Login
  Widget _login(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome !!',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        Material(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              hintText: "Username / Email",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.account_circle_rounded),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Material(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.lock),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Forgot Password?',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 15),
        )
      ],
    );
  }

  //Login button
  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        width: 240,
        child: Material(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 10,
          color: Colors.blue,
          child: Center(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap: () {
                _requestLogin();
              },
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Or widget
  Widget _or(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.arrow_forward_sharp,
            size: 20,
          ),
          Icon(
            Icons.circle,
            size: 10,
            color: Colors.orange,
          ),
          Text(
            ' OR ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.circle,
            size: 10,
            color: Colors.orange,
          ),
          Icon(
            Icons.arrow_back_sharp,
            size: 20,
          ),
        ],
      ),
    );
  }

  //Other login form
  Widget _otherLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/facebook.png')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/images/google-plus.png')),
            ),
          ),
          Material(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/twitter.png')),
          ),
        ],
      ),
    );
  }

  //Move to register screen
  Widget _register(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: RichText(
          text: const TextSpan(children: <TextSpan>[
        TextSpan(
            text: "Don't have Account? ",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
        TextSpan(
            text: "Register",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500))
      ])),
    );
  }
}
