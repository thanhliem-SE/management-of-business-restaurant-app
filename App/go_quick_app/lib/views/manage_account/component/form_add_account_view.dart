import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_account/manage_account_view.dart';
import 'package:go_quick_app/views/manage_account/manage_account_view_model.dart';
import 'package:provider/provider.dart';

class FormAddAccountView extends StatefulWidget {
  const FormAddAccountView({Key? key}) : super(key: key);

  @override
  State<FormAddAccountView> createState() => _FormAddAccountViewState();
}

class _FormAddAccountViewState extends State<FormAddAccountView> {
  TextEditingController? _tenNhanVien, _soDienThoai, _tenTaiKhoan, _matKhau;
  List<String> quyen = ["QUANLY", "PHUCVU", "CHEBIEN", "THUNGAN"];
  String quyenController = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tenNhanVien = TextEditingController();
    _soDienThoai = TextEditingController();
    _tenTaiKhoan = TextEditingController();
    _matKhau = TextEditingController();
    quyenController = quyen[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageAccountViewModel>(context);
    viewModel.quyenList[0].quyen;
    return WillPopScope(
      onWillPop: () async {
        NavigationHelper.pushReplacement(
            context: context, page: const ManageAccountView());
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  inputComponent("Tên nhân viên", _tenNhanVien!),
                  InputNUmberComponent("Số điện thoại", _soDienThoai!),
                  inputComponent("Tên tài khoản", _tenTaiKhoan!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        labelText: "Quyền",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: quyenController,
                          isDense: true,
                          onChanged: (String? value) {
                            quyenController = value!;
                            setState(() {});
                          },
                          items: quyen.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  inputComponent("Mật khẩu", _matKhau!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        onPressed: () async {
                          var kq = validate(context);
                          if (kq) {
                            NhanVien nhanVien = new NhanVien();
                            nhanVien.tenNhanVien = _tenNhanVien?.text;
                            nhanVien.soDienThoai = _soDienThoai?.text;
                            TaiKhoan taiKhoan = new TaiKhoan();
                            taiKhoan.tenTaiKhoan = _tenTaiKhoan?.text;
                            taiKhoan.matKhau = _matKhau?.text;
                            taiKhoan.quyen = quyenController;
                            nhanVien.taiKhoan = taiKhoan;
                            await viewModel.createNhanVien(context, nhanVien);
                          }
                        },
                        child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: Center(
                                child: Text(
                              "Thêm nhân viên mới",
                              style: TextStyle(fontSize: 18.0),
                            )))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validate(BuildContext context) {
    if (_tenNhanVien == null || _tenNhanVien?.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Tên nhân viên không được trống!",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    }
    if (_soDienThoai == null || _soDienThoai?.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Số điện thoại không được trống!",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    }
    if (_tenTaiKhoan == null || _tenTaiKhoan?.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Tên tài khoản không được trống!",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    }
    if (_matKhau == null || _matKhau?.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Mật khẩu không được trống!",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    }
    return true;
  }

  Widget InputNUmberComponent(
      String hintText, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          label: Text(hintText),
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

  Widget inputComponent(
    String textHint,
    TextEditingController _controller,
  ) {
    bool isValidate = true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (String value) {
          if (value.isEmpty) {
            isValidate = false;
          } else {
            isValidate = true;
          }
          setState(() {});
        },
        controller: _controller,
        decoration: InputDecoration(
          label: Text(textHint),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isValidate ? Colors.grey : Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManageAccountViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Thêm nhân viên mới',
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
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAccountView());
        },
      ),
    );
  }
}
