import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totelx_machine_test/blocs/userData/userdata_bloc.dart';
import 'package:totelx_machine_test/constants/app_colors.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/view/screens/authentication/number_input_screen.dart';
import 'package:totelx_machine_test/view/screens/user/widgets/user_tile.dart';
import 'package:totelx_machine_test/view/ui_utilities/bottom_sheet.dart';
import 'package:totelx_machine_test/view/ui_utilities/logout_alert.dart';
import 'package:totelx_machine_test/view/ui_utilities/success_dialogue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _users = []; 
  List<UserModel> _filteredUsers = [];

  @override
  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _users
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    logInfo('we are now inside the homescreen widget...');
    final Size size = MediaQuery.of(context).size;

    return BlocListener<UserdataBloc, UserdataState>(
      listener: (context, state) {
        if(state is UserDataAddedSuccessState){
          showSuccessDialog(context);
        }
        if (state is UserLogOutSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PhoneNumberVerificationScreen()));
        }
        if (state is UserDatasFetchedSuccess) {
          setState(() {
            _users = state.users;
            _filteredUsers = _users; 
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 30,
          child: IconButton(
            onPressed: ()=>showCustomBottomSheet(context),
             icon: Icon(Icons.add,color: Colors.white,)),
        ),
        appBar: AppBar(
          title: Text(
            'Nilambur',
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
          actions: [
            IconButton(onPressed: () {
              showLogoutConfirmationDialog(context);
            }, icon: Icon(Icons.logout)),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (query) {
                  _filterUsers(query);
                },
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: _filteredUsers.isNotEmpty
              ? ListView.builder(
                padding: EdgeInsets.all(10),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    logInfo('the items in the list are ${_filteredUsers.length}');
                    return UserTile(userModel: user);
                  },
                )
              : const Center(child: Text('No users found')),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
