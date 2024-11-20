import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:checker/feature/main_screen/presentation/controller/main_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterUserDialog extends StatefulWidget{
  final MainScreenController mainScreenController;

  const RegisterUserDialog({super.key, required this.mainScreenController});

  @override
  State<RegisterUserDialog> createState() => _RegisterUserDialogState();
}

class _RegisterUserDialogState extends State<RegisterUserDialog> {
  final TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(
      padding: EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min,children: [
        Text("Кажется, вы заходите первый раз"),
        Row(children: [Expanded(child: TextFormField(controller: nicknameController,decoration:InputDecoration(hintText: "Your nickname"),))],),
        Row(children: [Expanded(child: MaterialButton(child: Text("Подтвердить"),onPressed: (){
          widget.mainScreenController.registerMainUser(RegisterUser(nickname: nicknameController.text)).then((v){
            print("VDSVDSFVEWFEW $v");
          });
        })),
          SizedBox(width: 24,),
          Expanded(child: MaterialButton(child: Text("Выйти"),onPressed: (){

          }))],)
      ],),
    ),);
  }
}