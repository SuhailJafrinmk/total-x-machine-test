import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/model/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel userModel;
  const UserTile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black12
            )
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          height: size.height*.1,
          width: size.width*.9,
          child: Row(
            children: [
              Expanded(flex: 2,child: 
              CircleAvatar(
                // backgroundColor: Colors.transparent,
                radius: 30,
                backgroundImage: userModel.imageUrl!=null ? NetworkImage(userModel.imageUrl!) : const AssetImage(AppImages.profileImg) as ImageProvider,)),
              Expanded(flex: 2,child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userModel.username),
                  Text('Age:${userModel.age.toString()}'),
                ],
              )),
              Expanded(flex: 4,child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}