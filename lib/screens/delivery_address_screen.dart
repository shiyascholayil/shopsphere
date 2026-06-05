import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/firestore_provider.dart';
import 'package:shopsphere/screens/payment_method_screen.dart';
import 'package:shopsphere/widgets/account_form_widget.dart';

class DeliveryAddressScreen extends ConsumerWidget {
  final QuerySnapshot<Map<String, dynamic>>? cartItems;
  final List<Map<String, dynamic>>? buyItems;

  const DeliveryAddressScreen({super.key, this.cartItems, this.buyItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseProvider = ref.watch(firestoreProvider);

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,

        title: Text("Delivery Address", style: deliveryAppBarStyle),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),

        decoration: BoxDecoration(
          color: secondaryColor,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),

          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: SizedBox(
          width: double.infinity,
          height: 58,

          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => PaymentMethodScreen(
                    cartItems: cartItems,
                    buyItems: buyItems,
                  ),
                ),
              );
            },

            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: primaryColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Proceed To Payment", style: deliveryButtonTextStyle),

                const SizedBox(width: 10),

                Icon(Icons.arrow_forward_rounded, color: secondaryColor),
              ],
            ),
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firebaseProvider.getAccountDetails(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No data", style: noDataTextStyle));
          }

          final accountDetails = snapshot.data!.docs;

          if (accountDetails.isEmpty) {
            return AccountFormWidget(firebaseProvider: firebaseProvider,isFromAccountScreen:false,);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            physics: const BouncingScrollPhysics(),

            itemCount: accountDetails.length,

            itemBuilder: (context, index) {
              final data = accountDetails[index].data();

              final docId = accountDetails[index].id;

              return Container(
                margin: const EdgeInsets.only(bottom: 20),

                decoration: BoxDecoration(
                  color: secondaryColor,

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 20,
                      ),

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

                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color: secondaryColor.withValues(alpha: 0.15),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: Icon(
                              Icons.location_on_outlined,
                              color: secondaryColor,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "Delivery Address",
                                  style: deliveryHeaderTitleStyle,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Shipping details for your order",
                                  style: deliveryHeaderSubtitleStyle,
                                ),
                              ],
                            ),
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
                            icon: Icons.home_outlined,
                            title: "Street Address",
                            value: "${data["street"]}, ${data["city"]}",
                          ),

                          const SizedBox(height: 18),

                          _buildInfoTile(
                            icon: Icons.map_outlined,
                            title: "State & PinCode",
                            value: "${data["state"]} - ${data["pinCode"]}",
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
                                      isFromAccountScreen: false,
                                      docId: docId,

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
                                "Edit Address",
                                style: deliveryButtonTextStyle,
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
                Text(title, style: deliveryInfoTitleStyle),

                const SizedBox(height: 6),

                Text(value, style: deliveryInfoValueStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
