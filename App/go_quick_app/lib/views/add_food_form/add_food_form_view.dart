import 'dart:developer';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/amplifyconfiguration.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/add_food_form/add_food_form_view_model.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view_model.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddFoodFormView extends StatefulWidget {
  const AddFoodFormView({Key? key}) : super(key: key);

  @override
  State<AddFoodFormView> createState() => _AddFoodFormViewState();
}

class _AddFoodFormViewState extends State<AddFoodFormView> {
  DanhMuc? _danhMucController;
  List<DanhMuc> listDanhMuc = <DanhMuc>[];
  List<PickedFile> listImage = <PickedFile>[];
  TextEditingController? _tenMonAn;
  TextEditingController? _mota;
  TextEditingController? _chiTietMonAn;
  final picker = ImagePicker();
  TextEditingController? _giaTien;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (listDanhMuc.isNotEmpty) {
      _danhMucController = listDanhMuc[0];
    }
    _tenMonAn = TextEditingController();
    _mota = TextEditingController();
    _chiTietMonAn = TextEditingController();
    _giaTien = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<AddFoodFormViewModel>(context);
    if (viewModel.intiialized) {
      return WillPopScope(
        onWillPop: () async {
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAllFoodView());
          viewModel.clear();
          return true;
        },
        child: Scaffold(
          appBar: buildAppBar(size, context, viewModel),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                inputComponent("Tên món ăn", _tenMonAn!),
                inputComponent("Mô tả món ăn", _mota!),
                inputComponent("Chi tiết món ăn", _chiTietMonAn!),
                InputNUmberComponent("Giá tiền món ăn", _giaTien!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await chooseFile();
                            },
                            child: Text('Chọn file'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              for (var item in listImage)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(
                                    File(item.path),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    onPressed: () async {
                      if (validate(context, viewModel)) {
                        viewModel.thucPham.ten = _tenMonAn?.text;
                        viewModel.thucPham.moTa = _mota?.text;
                        viewModel.thucPham.chiTiet = _chiTietMonAn?.text;
                        viewModel.thucPham.giaTien =
                            _giaTien != null && _giaTien?.text != null
                                ? double.tryParse(_giaTien!.text)
                                : 0;
                        viewModel.thucPham.danhMuc =
                            _danhMucController ?? viewModel.danhMucs[0];
                        viewModel.thucPham.isDeleted = false;
                        viewModel.thucPham.trangThai = "enough";
                        if (await uploadImage(viewModel)) {
                          viewModel.thucPham.urlHinhAnh =
                              viewModel.getUrlHinhAnh;
                          await viewModel.createThucPham(context);
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("thất bại")));
                        }
                      }
                    },
                    child: Text(
                      'THÊM MÓN ĂN MỚI',
                    ),
                  ),
                ),
              ],
            ),
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

  Widget InputNUmberComponent(
      String hintText, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
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
      Size size, BuildContext context, AddFoodFormViewModel viewModel) {
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
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAllFoodView());
          viewModel.clear();
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

  Future<void> chooseFile() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Image")));
      return;
    } else {
      listImage.add(pickedFile);
      setState(() {});
    }
  }

  Future<bool> uploadImage(AddFoodFormViewModel viewModel) async {
    bool ketQua = false;
    for (var i = 0; i < listImage.length; i++) {
      var uuid = Uuid();
      final key = DateTime.now().toString() + uuid.v4();
      final file = File(listImage[i].path);
      try {
        final UploadFileResult result = await Amplify.Storage.uploadFile(
            local: file,
            key: key,
            onProgress: (progress) {
              print("Fraction completed: " +
                  progress.getFractionCompleted().toString());
            });
        String url = await getUrl(result.key);
        viewModel.urlHinhAnh.add(url);
      } on StorageException catch (e) {
        print('Error uploading image: $e');
        break;
      }
      if (i == listImage.length - 1) {
        ketQua = true;
      }
    }
    return ketQua;
  }

  Future<String> getUrl(String keyFile) async {
    try {
      final result = await Amplify.Storage.getUrl(key: keyFile);
      return result.url;
    } catch (e) {
      throw e;
    }
  }

  bool validate(BuildContext context, AddFoodFormViewModel viewModel) {
    if (_tenMonAn == null || _tenMonAn!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Tên món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else if (_mota == null || _mota!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Mô tả món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else if (_chiTietMonAn == null || _chiTietMonAn!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Chi tiết món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else if (_chiTietMonAn == null || _chiTietMonAn!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Mô tả món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else if (_giaTien == null || _giaTien!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Giá tiền món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else if (listImage == null || listImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Hình ảnh món ăn không được trống",
        style: TextStyle(color: Colors.red),
      )));
      return false;
    } else {
      return true;
    }
  }
}
