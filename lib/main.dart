
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/firebase_options.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/responsive/mobile_screen_layout.dart';
import 'package:moneylover/responsive/responsive_layout.dart';
import 'package:moneylover/responsive/web_screen_layout.dart';
import 'package:moneylover/screens/add_screen.dart';
import 'package:moneylover/screens/category_screen.dart';
import 'package:moneylover/screens/currency_screen.dart';
import 'package:moneylover/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),


        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Kiểm tra nếu người dùng đã đăng nhập thành công
              if (snapshot.hasData) {
                // Lấy thông tin người dùng từ Firestore
                User? user = snapshot.data;
                if (user != null) {
                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('usersc').doc(user.uid).snapshots(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (userSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${userSnapshot.error}'),
                        );
                      }
                      // Kiểm tra nếu dữ liệu của người dùng có tồn tại và currencyId là rỗng
                      if (userSnapshot.hasData && userSnapshot.data!['currencyId'] == "") {
                        // Trả về widget khác nếu currencyId của người dùng là rỗng
                        return const CurrencyScreen();
                      } else {
                        //Trả về ResponsiveLayout nếu currencyId không rỗng
                        return const ResponsiveLayout(
                          mobileScreenLayout: MobileScreenLayout(),
                          webScreenLayout: WebScreenLayout(),
                        );

                      }
                    },
                  );
                }
              } else if (snapshot.hasError) {
                // Trả về màn hình thông báo lỗi nếu có lỗi xảy ra với stream
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // Trả về tiêu đề đợi nếu stream chưa được kết nối
            return const Center(
              child: LoginScreen(),
            );
          },
        ),



    );
  }
}

