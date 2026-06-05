import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/auth_provider.dart';
import 'package:shopsphere/provider/firestore_provider.dart';
import 'package:shopsphere/widgets/account_form_widget.dart';
import 'package:shopsphere/widgets/confirmation_dialog.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseProvider = ref.watch(firestoreProvider);
    final authProviders = ref.read(authProvider);

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        centerTitle: true,

        title: Text("My Account", style: accountAppBarTitleStyle),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),

              decoration: BoxDecoration(
                color: redColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),

              child: IconButton(
                icon:  Icon(Icons.logout_rounded, color: redColor),

                onPressed: () async {
                  final shouldCancel = await ConfirmationDialog.show(
                    context: context,
                    title: "Logout",
                    content: "Are you sure you want to Logout?",
                  );

                  if (shouldCancel == true) {
                    await authProviders.signOut();
                  }
                },
              ),
            ),
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firebaseProvider.getAccountDetails(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return AccountFormWidget(firebaseProvider: firebaseProvider,isFromAccountScreen: true,);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            physics: const BouncingScrollPhysics(),

            itemCount: docs.length,

            itemBuilder: (context, index) {
              final data = docs[index].data();

              final docId = docs[index].id;

              return Container(
                margin: const EdgeInsets.only(bottom: 20),

                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 30),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor.withValues(alpha: 0.85),
                          ],
                        ),

                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),

                      child: Column(
                        children: [

                          Container(
                            padding: const EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: secondaryColor,
                                width: 3,
                              ),
                            ),

                            child: CircleAvatar(
                              radius: 42,
                              backgroundColor: secondaryColor,

                              child: Icon(
                                Icons.person_rounded,
                                size: 45,
                                color: primaryColor,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),


                          Text(
                            FirebaseAuth.instance.currentUser?.email ?? "",

                            style: accountEmailStyle,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          _buildInfoTile(
                            icon: Icons.person_outline,
                            title: "Full Name",
                            value: data["name"] ?? "",
                          ),

                          const SizedBox(height: 18),


                          _buildInfoTile(
                            icon: Icons.phone_outlined,
                            title: "Phone Number",
                            value: data["phone"] ?? "",
                          ),

                          const SizedBox(height: 18),

                          _buildInfoTile(
                            icon: Icons.location_on_outlined,
                            title: "Street Address",
                            value:
                                "${data["street"] ?? ""}, ${data["city"] ?? ""}",
                          ),

                          const SizedBox(height: 18),

                          _buildInfoTile(
                            icon: Icons.map_outlined,
                            title: "State & PinCode",
                            value:
                                "${data["state"] ?? ""} - ${data["pinCode"] ?? ""}",
                          ),

                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: primaryColor,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: () {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (context) => AccountFormWidget(
                                      firebaseProvider: firebaseProvider,
                                      docId: docId,
                                      isFromAccountScreen:true,
                                      existData: data,
                                    ),
                                  ),
                                );
                              },

                              icon: Icon(
                                Icons.edit_outlined,
                                color: secondaryColor,
                              ),

                              label: Text(
                                "Edit Profile",
                                style: editProfileButtonStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: lightBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: primaryColor, size: 24),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: infoTileTitleStyle),

                const SizedBox(height: 6),

                Text(value, style: infoTileValueStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
