import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/home_screen.dart';
import '../screens/CartScreen.dart'; // Import the CartScreen
import '../screens/SellerScreen.dart';
import '../screens/SettingsScreen.dart'; // Import the SettingsScreen
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  int itemCountInCart = 0; // Initialize cart item count

  late List<Widget> screens; // Define screens variable

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      CartScreen(), // Use the CartScreen in the screens list
      Scaffold(),
      SellerScreen(),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTabItem(Iconsax.home, "Home", 0),
            buildTabItem(Iconsax.shop, "Seller", 3),
            buildTabItem(Iconsax.calendar_2, "Cart", 1), // Update the index for Cart
            buildTabItem(Iconsax.setting, "Settings", 4),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }

  GestureDetector buildTabItem(IconData icon, String label, int tabIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTab = tabIndex;
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              Icon(
                currentTab == tabIndex ? Iconsax.home5 : icon,
                color: currentTab == tabIndex ? kprimaryColor : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: currentTab == tabIndex ? kprimaryColor : Colors.grey,
                ),
              ),
            ],
          ),
          if (tabIndex == 1 && itemCountInCart > 0) // Show cart item count on Cart tab
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  itemCountInCart.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
