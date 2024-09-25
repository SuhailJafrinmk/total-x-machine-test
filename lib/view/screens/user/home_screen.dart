import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totelx_machine_test/constants/app_colors.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/providers/home_screen_provider.dart';
import 'package:totelx_machine_test/providers/pick_image_provider.dart';
import 'package:totelx_machine_test/providers/signout_provider.dart';
import 'package:totelx_machine_test/utils/custom_snackbar.dart';
import 'package:totelx_machine_test/view/screens/authentication/number_input_screen.dart';
import 'package:totelx_machine_test/view/screens/user/widgets/user_tile.dart';
import 'package:totelx_machine_test/view/ui_utilities/bottom_sheet.dart';
import 'package:totelx_machine_test/view/ui_utilities/logout_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    // Fetch all users when the screen loads
    Future.microtask(() =>
        Provider.of<HomeScreenProvider>(context, listen: false).getAllUsers());
  }

  void _filterUsers(String query, List<UserModel> users) {
    setState(() {
      _filteredUsers = users
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    logInfo('we are now inside the homescreen widget...');
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 30,
        child: IconButton(
          onPressed: () {
            showCustomBottomSheet(context);
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Nilambur',
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        actions: [
          Consumer<SignOutProvider>(
            builder: (context, value, child) {
              if(value.state==AuthState.signedOut){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneNumberVerificationScreen()));
                });
              }
              return IconButton(
              onPressed: () {
                showLogoutConfirmationDialog(context);
              },
              icon: const Icon(Icons.logout),
            );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: _searchController,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.white38
                ),
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                final homeScreenProvider =
                    Provider.of<HomeScreenProvider>(context, listen: false);
                _filterUsers(query, homeScreenProvider.users);
              },
            ),
          ),
        ),
      ),
      body: Consumer2<PickImageProvider, HomeScreenProvider>(
        builder: (context, pickImageProvider, homeScreenProvider, child) {
          if (pickImageProvider.state == ImageProviderState.errorPickingImage ||
              pickImageProvider.state == ImageProviderState.errorUploading) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                  context, true, pickImageProvider.errorMessage));
            });
          }

          if (homeScreenProvider.state == HomeScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (homeScreenProvider.state == HomeScreenState.error) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                  context, true, homeScreenProvider.errorMessage));
            });
            return const Center(child: Text('Error loading users'));
          }

          // Filtering users
          final usersToShow = _searchController.text.isEmpty
              ? homeScreenProvider.users
              : _filteredUsers;

          return SizedBox(
            height: size.height,
            width: size.width,
            child: usersToShow.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: usersToShow.length,
                    itemBuilder: (context, index) {
                      final user = usersToShow[index];
                      logInfo('the items in the list are ${usersToShow.length}');
                      return UserTile(userModel: user);
                    },
                  )
                : const Center(child: Text('No users found')),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
