import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/services/auth_service.dart';
import 'package:head_up_ui/views/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final _pwFieldKey = GlobalKey<FormBuilderFieldState>();
  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.isValid ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: const Image(
                    height: 250,
                    width: 250,
                    image: AssetImage("assets/images/note-logo.png")),
              ),
              Container(
                width: 450,
                child: Column(children: [
                  FormBuilder(
                      onChanged: () {
                        _validateForm();
                        _emailFieldKey.currentState?.validate();
                      },
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                // email form field
                                FormBuilderTextField(
                                  key: _emailFieldKey,
                                  name: 'email',
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.email(),
                                  ]),
                                ),

                                // password form field
                                FormBuilderTextField(
                                  key: _pwFieldKey,
                                  name: 'password',
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Password is required"),
                                  ]),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // login button
                          RawMaterialButton(
                            fillColor: _isFormValid
                                ? const Color(0xff63cdff)
                                : Colors.grey,
                            hoverColor: const Color(0xff4f9ec9),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.black12,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(5),
                            onPressed: _isFormValid
                                ? () {
                                    // Validate and save the form values
                                    _formKey.currentState?.saveAndValidate();
                                    debugPrint(_formKey.currentState?.value
                                        .toString());

                                    // On another side, can access all field values without saving form with instantValues
                                    _formKey.currentState?.validate();
                                    debugPrint(_formKey
                                        .currentState?.instantValue
                                        .toString());
                                    if (_formKey.currentState!.validate()) {
                                      authService.getTokenSignIn(context,
                                          _formKey.currentState!.value);
                                    }
                                  }
                                : null,
                            child: Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: const Text(
                                'Log in',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 50,
                  )
                ]),
              ),
              // SignInButton(
              //     Buttons.Google,
              //   	onPressed: () async {
              //       await authService.getTokenGoogleSignIn(context);
              //     },
              // ),
              GoogleAuthButton(
                onPressed: () async {
                  await authService.getTokenGoogleSignIn(context);
                },
                style: const AuthButtonStyle(
                  padding: EdgeInsets.all(16.0),
                  borderColor: Colors.black54,
                  borderWidth: 1.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
