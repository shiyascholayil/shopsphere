import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/auth_provider.dart';
import 'package:shopsphere/widgets/loading_widget.dart';

class SighupScreen extends ConsumerStatefulWidget {
  const SighupScreen({super.key});

  @override
  ConsumerState<SighupScreen> createState() => _SighupScreenState();
}

class _SighupScreenState extends ConsumerState<SighupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviders = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Center(
                    child: Container(
                      height: 90,
                      width: 90,

                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.12),

                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        Icons.shopping_bag_rounded,
                        size: 45,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Text(
                    "Create Account",

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Sign up to continue shopping",

                    style: TextStyle(color: greyShadeW600, fontSize: 15),
                  ),

                  const SizedBox(height: 40),

                  TextFormField(
                    controller: _emailController,

                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      hintText: "Enter your email",

                      labelText: "Email",

                      prefixIcon: Container(
                        margin: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.10),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Icon(Icons.email_rounded, color: primaryColor),
                      ),

                      filled: true,

                      fillColor: secondaryColor,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide(color:greyShade200),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide(color: primaryColor, width: 1.8),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 18,
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }

                      if (!value.contains("@")) {
                        return "Enter valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  TextFormField(
                    controller: _passwordController,

                    obscureText: _obscureText,

                    decoration: InputDecoration(
                      hintText: "Enter your password",

                      labelText: "Password",

                      prefixIcon: Container(
                        margin: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.10),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Icon(Icons.lock_rounded, color: primaryColor),
                      ),

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },

                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                      ),

                      filled: true,

                      fillColor: secondaryColor,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                        borderSide: BorderSide(color: primaryColor, width: 1.8),
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 18,
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }

                      if (value.length < 6) {
                        return "Minimum 6 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 34),

                  authProviders.isLoading
                      ? const LoadingWidget(message: "Creating Account")
                      : SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool success = await authProviders
                                    .registerWithEmailAndPassword(
                                      _emailController.text.trim(),

                                      _passwordController.text.trim(),
                                    );

                                if (!success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        "Registration Failed",
                                      ),

                                      backgroundColor: redColor,

                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,

                              elevation: 0,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            child: Text(
                              "Create Account",

                              style: TextStyle(
                                color: secondaryColor,

                                fontSize: 16,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 24),

                  Center(
                    child: Text(
                      "Welcome to ShopSphere",

                      style: TextStyle(
                        color: greyShadeW600,

                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
