import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_up_app/backend/database_service.dart';
import 'package:order_up_app/components/misc/app_colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  final user = FirebaseAuth.instance.currentUser;




  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: DatabaseService().getUsername(uid: (user?.uid)!), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userName = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.maroonColor, foregroundColor: AppColors.whiteColor,
            ),
            body: Center(
              child: SizedBox(
                width: 412,
                height: 917,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 18, bottom: 16),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                                      width: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email: ", style: TextStyle(fontSize: 24),),
                                Text(
                                  "${user?.email}",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),

                            Row(
                              children: [
                                Text("Account Creation: ", style: TextStyle(fontSize: 24),),
                                Text(
                                  "${user?.metadata.creationTime!.month}-${user?.metadata.creationTime!.day}-${user?.metadata.creationTime!.year}",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),

                        
                            Image.network('https://www.bworldonline.com/wp-content/uploads/2025/02/312m-BingoPlus-KV-NCR_Print-Ad_Business-World_29.7x27cm_CMYK-OL.jpg')                      
                          ],
                        ),
                      ),
                    ),

                    // Nav Bar //
                  
                  ],
                ),
              ),
            ),
          );
        }
    });
  }
}
