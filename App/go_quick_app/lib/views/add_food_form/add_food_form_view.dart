import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/views/add_food_form/add_food_form_view_model.dart';
import 'package:provider/provider.dart';

class AddFoodFormView extends StatefulWidget {
  const AddFoodFormView({Key? key}) : super(key: key);

  @override
  State<AddFoodFormView> createState() => _AddFoodFormViewState();
}

class _AddFoodFormViewState extends State<AddFoodFormView> {
  DanhMuc? _danhMucController;
  List<DanhMuc> listDanhMuc = <DanhMuc>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (listDanhMuc.isNotEmpty) {
      _danhMucController = listDanhMuc[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<AddFoodFormViewModel>(context);
    if (viewModel.intiialized) {
      return Scaffold(
        appBar: buildAppBar(size, context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              inputComponent("Tên món ăn"),
              inputComponent("Mô tả món ăn"),
              inputComponent("Chi tiết món ăn"),
              InputNUmberComponent("Giá tiền món ăn"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    labelText: "Danh mục sản phẩm",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<DanhMuc>(
                      value: _danhMucController ?? viewModel.danhMucs[0],
                      isDense: true,
                      onChanged: (DanhMuc? value) {
                        _danhMucController = value!;
                        setState(() {});
                      },
                      items: viewModel.danhMucs.map((DanhMuc value) {
                        return DropdownMenuItem<DanhMuc>(
                          value: value,
                          child: Text(value.loaiDanhMuc!),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      viewModel.Init(context);
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 2.0,
          ),
        ),
      );
    }
  }

  Widget InputNUmberComponent(String hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          label: Text('Giá món ăn'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }

  Widget inputComponent(String textHint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          label: Text(textHint),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
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

  Future<void> loadingDanhMucs(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        listDanhMuc = response.response as List<DanhMuc>;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
