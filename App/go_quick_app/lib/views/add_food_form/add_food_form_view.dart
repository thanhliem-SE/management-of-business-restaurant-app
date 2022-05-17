import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

class AddFoodFormView extends StatelessWidget {
  const AddFoodFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(size, context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            inputComponent("Tên món ăn"),
            inputComponent("Mô tả món ăn"),
            inputComponent("Chi tiết món ăn"),
            inputComponent("Giá tiền món ăn"),
            inputComponent("")
          ],
        ),
      ),
    );
  }

  TextField inputComponent(String textHint) {
    return TextField(
      decoration: InputDecoration(
        hintText: textHint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Thêm món ăn vào danh mục',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
