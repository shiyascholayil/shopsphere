import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/riverpod/firestore_riverpod.dart';
import 'package:shopsphere/widgets/textfield_widget.dart';

class AccountFormWidget extends StatefulWidget {
  final FirestoreProvider firebaseProvider;

  final String? docId;
  final Map<String, dynamic>? existData;
  final  bool isFromAccountScreen;

  const AccountFormWidget({
    super.key,
    required this.firebaseProvider,
    this.docId,
    this.existData,
    required this.isFromAccountScreen,
  });

  @override
  State<AccountFormWidget> createState() => _AccountFormWidgetState();
}

class _AccountFormWidgetState extends State<AccountFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final streetController = TextEditingController();

  final cityController = TextEditingController();

  final stateController = TextEditingController();

  final pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existData != null) {
      final data = widget.existData!;

      nameController.text = data["name"] ?? "";

      phoneController.text = data["phone"] ?? "";

      streetController.text = data["street"] ?? "";

      cityController.text = data["city"] ?? "";

      stateController.text = data["state"] ?? "";

      pinCodeController.text = data["pinCode"] ?? "";
    }
  }

  @override
  void dispose() {
    nameController.dispose();

    phoneController.dispose();

    streetController.dispose();

    cityController.dispose();

    stateController.dispose();

    pinCodeController.dispose();

    super.dispose();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final firebaseProvider = widget.firebaseProvider;

    final docId = widget.docId;

    Map<String, dynamic> data = {
      "name": nameController.text.trim(),

      "phone": phoneController.text.trim(),

      "street": streetController.text.trim(),

      "city": cityController.text.trim(),

      "state": stateController.text.trim(),

      "pinCode": pinCodeController.text.trim(),
    };

    try {
      if (docId == null) {
        await firebaseProvider.saveAddress(data);
      } else {
        await firebaseProvider.upDateAddress(docId, data);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Address saved successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save address")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        centerTitle: true,

        title:widget.isFromAccountScreen?
        Text(
          widget.docId == null ? "Add  Profile" : "Edit  Profile",

          style: editScreenHeadTextStyle,
        ): Text(
          widget.docId == null ? "Add  Address" : "Edit  Address",

          style: editScreenHeadTextStyle,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Container(
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              color: secondaryColor,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.05),

                  blurRadius: 20,

                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  TextFieldWidget(
                    label: "Full Name",

                    controller: nameController,

                    icon: Icons.person_outline,
                  ),

                  TextFieldWidget(
                    label: "Phone Number",

                    controller: phoneController,

                    keyboardType: TextInputType.phone,

                    icon: Icons.phone_outlined,
                  ),

                  TextFieldWidget(
                    label: "Street Address",

                    controller: streetController,

                    icon: Icons.home_outlined,
                  ),

                  TextFieldWidget(
                    label: "City",

                    controller: cityController,

                    icon: Icons.location_city_outlined,
                  ),

                  TextFieldWidget(
                    label: "State",

                    controller: stateController,

                    icon: Icons.map_outlined,
                  ),


                  TextFieldWidget(
                    label: "PinCode",

                    controller: pinCodeController,

                    keyboardType: TextInputType.number,

                    icon: Icons.pin_drop_outlined,
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,

                    height: 58,

                    child: ElevatedButton(
                      onPressed: submit,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,

                        elevation: 4,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      child:widget.isFromAccountScreen? Text(
                        widget.docId == null
                            ? "Save Profile"
                            : "Update Profile",

                        style: saveAddressTextStyle,
                      ):Text(
                        widget.docId == null
                            ? "Save address"
                            : "Update address",

                        style: saveAddressTextStyle,
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
