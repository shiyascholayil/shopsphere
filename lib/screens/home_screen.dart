import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/category_provider.dart';
import 'package:shopsphere/provider/firestore_provider.dart';
import 'package:shopsphere/screens/cart_screen.dart';
import 'package:shopsphere/widgets/home_widget.dart';
import 'package:shopsphere/widgets/permission_widget.dart';
import 'package:shopsphere/widgets/search_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  final PermissionWidget _permissionWidget = PermissionWidget();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProvider).loadProducts();
    });

    _permissionWidget.requestPermission();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestoreProviders = ref.watch(firestoreProvider);
    final categoryProviders = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor:bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        toolbarHeight: 75,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "ShopSphere",
                style: homeScreenAppHeading
            ),
            Text(
                "Discover Your Style",
                style:homeScreenAppSubTitle
            ),
          ],
        ),

        actions: [
          StreamBuilder<int>(
            stream: firestoreProviders.getCartCount(),
            builder: (context, snapshot) {
              int count = snapshot.data ?? 0;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: secondaryColor,
                          size: 28,
                        ),
                      ),
                    ),

                    if (count > 0)
                      Positioned(
                        right: 2,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: redColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: secondaryColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                              "$count",
                              style: homeScreenCartTextStyle
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: Container(
              height: 58,

              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha:0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: TextField(
                focusNode: _searchFocusNode,
                controller: _searchController,

                onTap: () {
                  setState(() {
                    _isSearching = true;
                  });
                },

                style:  homeScreenTextFieldText,

                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),

                  hintText: "Search Your Product",
                  hintStyle: homeScreenHintTextStyle,

                  prefixIcon: IconButton(
                    onPressed: () {
                      if (_isSearching) {
                        FocusScope.of(context).unfocus();

                        setState(() {
                          _isSearching = false;
                          _searchController.clear();
                          categoryProviders.clearSearch();
                        });
                      }
                    },

                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        _isSearching
                            ? Icons.close_rounded
                            : Icons.search_rounded,
                        key: ValueKey(_isSearching),
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                  ),

                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      categoryProviders.clearSearch();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.mic_none_rounded,
                      color: greyShadeW500,
                    ),
                  )
                      : null,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: primaryColor.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),

                  filled: true,
                  fillColor: secondaryColor,
                ),

                onChanged: (value) {
                  setState(() {});
                  categoryProviders.searchResults(value);
                },
              ),
            ),
          ),
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),

        child: _isSearching
            ? SearchWidget(
          key: const ValueKey("search"),
          categoryProvider: categoryProviders,
          searchController: _searchController,
        )
            : HomeWidget(
          key: const ValueKey("home"),
          catoGoryProvider: categoryProviders,
          onOpened: () {
            _searchFocusNode.unfocus();

            categoryProviders.clearSearch();

            _searchController.clear();

            setState(() {
              _isSearching = false;
            });
          },
        ),
      ),
    );
  }
}