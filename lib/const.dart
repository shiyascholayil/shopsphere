import 'package:flutter/material.dart';

final Color primaryColor = Colors.black;
final Color secondaryColor = Colors.white;
final Color redColor = Colors.red;
final Color yellowColor = Colors.yellow;
final Color bgColor = const Color(0xffF5F7FA);
final Color greyShadeW500 = Colors.grey.shade500;
final Color greyShadeW600 = Colors.grey.shade600;
final Color greyShadeW700 = Colors.grey.shade700;
final Color greyShadeW300 = Colors.grey.shade300;
final Color greyShade100 = Colors.grey.shade100;
final Color greyShade200 = Colors.grey.shade200;
final Color redShadeW400 = Colors.red.shade400;
final Color greenColor = Colors.green;
final Color textLight = Colors.grey;
final Color cardShadowColor =  Color(0x14000000);
final Color deleteBackgroundColor =  Color(0x14FF0000);
final Color borderColor =  Color(0xFFE0E0E0);
final Color greyBackground =  Color(0xFFF5F5F5);
final Color iconBgColor =  Color(0xFFF2F2F2);
final Color greyDarkColor =  Color(0xFF666666);
final Color greyLightColor =  Color(0xFFEAEAEA);
final Color greyTextColor =  Color(0xFF757575);
final Color blackTextColor = Colors.black87;
final Color lightBackgroundColor =  Color(0xFFF8F9FB);
final Color redAccentColor = Colors.redAccent;




final TextStyle loginTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,

);

final TextStyle filterSortTextStyle=TextStyle(
   fontSize:20.0,
   color: Colors.black,
  fontWeight:FontWeight.bold,
);

final TextStyle reviewName=TextStyle(

  fontWeight:FontWeight.bold,
  color:greyDarkColor,
);

final  TextStyle editScreenHeadTextStyle=TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: primaryColor,

);
final TextStyle saveAddressTextStyle=TextStyle(

    fontSize: 17,
    fontWeight: FontWeight.bold,
    color:secondaryColor ,

);

final TextStyle font18SizeBlack =TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryColor,
);
final TextStyle homeScreenAppHeading=TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 24,
  letterSpacing: 1,
);
final TextStyle homeScreenAppSubTitle= TextStyle(
color: secondaryColor.withValues(alpha:0.8),
fontSize: 12,
);

final TextStyle  homeScreenCartTextStyle=TextStyle(
  color: secondaryColor,
  fontSize: 11,
  fontWeight: FontWeight.bold,
);


final TextStyle  homeScreenTextFieldText= TextStyle(
fontSize: 15,
fontWeight: FontWeight.w500,
);

final TextStyle  homeScreenHintTextStyle=TextStyle(
color: greyShadeW500,
fontSize: 14,
);
final TextStyle loginWelcomeText =TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);
final TextStyle loginSubText=TextStyle(
  fontSize: 15,
  color: Colors.grey.shade600,
);
final TextStyle loginPasswordText  =TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
);
final TextStyle loginText =TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final  TextStyle primaryTextStyle=TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);
final TextStyle  screenDetailsText= TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
final TextStyle categoryTextStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
  letterSpacing: 1,
  fontSize: 12,
);

final TextStyle productTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
  height: 1.3,
);

final TextStyle priceLabelStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 13,
);

final TextStyle priceTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

final TextStyle ratingTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black87,
);

final  TextStyle cartAppBarTitleStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

const TextStyle emptyCartTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle emptyCartSubtitleStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 15,
  height: 1.5,
);

final TextStyle itemCountTextStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
);

final TextStyle totalLabelTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 14,
);

final TextStyle totalPriceTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

final TextStyle checkoutButtonTextStyle = TextStyle(
  color: secondaryColor,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final TextStyle sectionTitleStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle descriptionTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey.shade700,
  height: 1.7,
);

final TextStyle quantityTitleStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final TextStyle reviewTitleStyle = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle bottomButtonTextStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

final TextStyle paymentAppBarTitleStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle paymentTitleStyle = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle paymentSubtitleStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 15,
);

final TextStyle proceedButtonTextStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);
final TextStyle orderAppBarTitleStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final  TextStyle emptyOrderTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle emptyOrderSubtitleStyle = TextStyle(
  color: Colors.grey,
  fontSize: 15,
);

final TextStyle orderCountTextStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
);

final  TextStyle orderTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final  TextStyle orderPlacedTextStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);

final TextStyle paymentLabelStyle = TextStyle(
  color: Colors.grey.shade700,
);

const TextStyle paymentValueStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

final TextStyle totalPriceStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

final  TextStyle productSectionTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle orderedProductNameStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.black87,
);
final  TextStyle orderedQtyStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);

final  TextStyle orderedPriceStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle cancelButtonTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
);




 final TextStyle accountAppBarTitleStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle accountEmailStyle = TextStyle(
  color: secondaryColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

final  TextStyle editProfileButtonStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

final TextStyle infoTileTitleStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 13,
);

final  TextStyle infoTileValueStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w600,
  fontSize: 15,
  height: 1.5,
);
final  TextStyle deliveryAppBarStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final  TextStyle deliveryHeaderTitleStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

final  TextStyle deliveryHeaderSubtitleStyle = TextStyle(
  color: Colors.white70,
  fontSize: 13,
);

final TextStyle deliveryInfoTitleStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 13,
);

final  TextStyle deliveryInfoValueStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w600,
  fontSize: 15,
  height: 1.5,
);

final  TextStyle deliveryButtonTextStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

final TextStyle noDataTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
final TextStyle successTitleStyle = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
  height: 1.3,
);

final TextStyle successSubtitleStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey.shade600,
  height: 1.7,
);

final TextStyle deliveryLabelStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 13,
);

final TextStyle deliveryTimeStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  color: Colors.black87,
);

final TextStyle continueButtonStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);
final TextStyle orderSummaryAppBarStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle headerTitleStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle headerSubtitleStyle = TextStyle(
  color: secondaryColor.withValues(alpha: 0.85),
  fontSize: 14,
);

final TextStyle sectionTitleStyles = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final TextStyle paymentMethodStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black87,
);

final TextStyle paymentSubtitleStyles = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 13,
);

final TextStyle productNameStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black87,
);

final TextStyle quantityStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);

final TextStyle productPriceStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: primaryColor,
);

final TextStyle totalLabelStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.black87,
);

final TextStyle totalPriceStyles = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: primaryColor,
);

final TextStyle placeOrderButtonStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

final TextStyle priceRowTitleStyle = TextStyle(
  color: Colors.grey.shade700,
  fontSize: 15,
);

final TextStyle priceRowValueStyle = const TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 16,
  color: Colors.black87,
);

final TextStyle appBarTitleStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 22,
);

final TextStyle titleStyle =  TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: textLight,
);

final  TextStyle orderTitleStyles = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: textLight,
);

final  TextStyle productNameStyles = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: textLight,
);

final  TextStyle priceStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

final  TextStyle boldStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: textLight,
);

final  TextStyle greenSmallStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);

final  TextStyle primarySmallStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);
final TextStyle subtitle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 15,
);
final TextStyle cartTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  height: 1.4,
);

 final TextStyle cartQuantityStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: primaryColor,
);

 final TextStyle cartPriceStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);
final TextStyle titleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: blackTextColor,
);

final TextStyle subtitleTextStyle = TextStyle(
  fontSize: 13,
  color: greyTextColor,
);

final TextStyle itemTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: blackTextColor,
);

final TextStyle selectedItemTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: secondaryColor,
);

final TextStyle buttonTextStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
);


final TextStyle loadingTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: blackTextColor,
  letterSpacing: .4,
);

final TextStyle loadingSubTitleStyle = TextStyle(
  fontSize: 14,
  color: greyTextColor,
);




final  TextStyle loadingTitleStyles = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: blackTextColor,
  letterSpacing: .4,
);

final TextStyle loadingSubTitleStyles = TextStyle(
  fontSize: 14,
  color: greyTextColor,
);


final  TextStyle paymentTitleStyles = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  letterSpacing: .2,
  color: blackTextColor,
);

final  TextStyle selectedPaymentTitleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  letterSpacing: .2,
  color: primaryColor,
);

final  TextStyle paymentSubtitleStyless = TextStyle(
  color: greyTextColor,
  fontSize: 13.5,
  height: 1.4,
);

final TextStyle categoryTextStyles = TextStyle(
  color: primaryColor,
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

final TextStyle productTitleStyles = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  height: 1.4,
);

final  TextStyle priceTextStyles = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

final  TextStyle ratingTextStyles = TextStyle(
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  fontSize: 12,
);
final  TextStyle reviewNames = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

final  TextStyle reviewCommentStyle = TextStyle(
  color: greyDarkColor,
  fontSize: 13,
  height: 1.4,
);

final TextStyle reviewRatingStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

final TextStyle emptyReviewStyle = TextStyle(
  color: greyDarkColor,
  fontSize: 14,
);



final TextStyle searchTitleStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: blackTextColor,
);

final TextStyle searchSubTitleStyle = TextStyle(
  color: greyTextColor,
  fontSize: 15,
  height: 1.5,
);

final TextStyle searchProductTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  height: 1.4,
);

final  TextStyle searchCategoryTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

final  TextStyle searchPriceTextStyles = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);


final TextStyle selectedSortTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: secondaryColor,
);

final  TextStyle buttonTextStyles = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
);


final TextStyle textFieldInputStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: blackTextColor,
);

final TextStyle focusedLabelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

final TextStyle unFocusedLabelStyle = TextStyle(
  color: greyTextColor,
  fontWeight: FontWeight.w500,
);




