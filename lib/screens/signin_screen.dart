import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/screens/currency_screen.dart';
import 'package:moneylover/screens/login_screen.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:moneylover/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthService().signUpUser(
        email: _emailController.text, password: _passwordController.text
    );
    if(res != "success"){
      showSankBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CurrencyScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.black87
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Đăng ký", style: TextStyle(color: Colors.white, fontSize:  25, fontWeight: FontWeight.w600),),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 45,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.facebook, color: Colors.white,),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Text("KẾT NỐI VỚI FACEBOOK", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),)
                    )
                  ],
                ),

              ),
              Container(

                width: double.infinity,
                height: 45,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.gpp_good, color: Colors.white,),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        child: const Text("KẾT NỐI VỚI GOOGLE", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),)
                    )
                  ],
                ),

              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 45,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(left: 20),

                      alignment: Alignment.center,
                      child: const Icon(Icons.apple, color: Colors.black, size: 30,),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Text("ĐĂNG NHẬP VỚI APPLE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),)
                    )
                  ],
                ),

              ),
              const SizedBox(height: 5,),
              const Text("Chúng tôi sẽ không đăng nhập thông tin mà không có sự cho phép của bạn", style: TextStyle(color: Colors.grey, fontSize: 12),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              const Row(
                children: [
                  Flexible(child: Divider()),
                  Text("  HOẶC  ",style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),),
                  Flexible(child: Divider()),

                ],
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "Email",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintStyle: TextStyle(color: Colors.grey)
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _passwordController,

                decoration: const InputDecoration(
                    hintText: "Mật khẩu",
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white,),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    )


                ),
                style: const TextStyle(color: Colors.white),
                obscureText: true,
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:_isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blue,),) : const Text("ĐĂNG KÝ", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen())),
                      child: const Text("Đăng nhập", style: TextStyle(color: Colors.green),)
                  ),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
