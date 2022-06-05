import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/views/manage_food/manage_food_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageFoodView extends StatefulWidget {
  const ManageFoodView({Key? key}) : super(key: key);

  @override
  State<ManageFoodView> createState() => _ManageFoodViewState();
}

class _ManageFoodViewState extends State<ManageFoodView> {
  bool isLoading = false;
  int selectIndex = 0;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageFoodViewModel>(context);
    viewModel.Init(context);
    if (viewModel.danhmucs != null) {
      isLoading = false;
      setState(() {});
    } else {
      isLoading = true;
      setState(() {});
    }
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
                strokeWidth: 2.0,
              ),
            ),
          )
        : DefaultTabController(
            length: viewModel.danhmucs!.length,
            child: Scaffold(
              appBar: buildAppBar(size, context, viewModel),
              body: Column(
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      child: TabBarView(
                        children: [
                          for (var item in viewModel.danhmucs!)
                            ListView.builder(
                              itemCount: item.thucphams == null
                                  ? 0
                                  : item.thucphams!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Image.network(
                                                      item.thucphams!
                                                          .elementAt(index)
                                                          .thucPham!
                                                          .urlHinhAnh!
                                                          .elementAt(0)
                                                          .toString(),
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                      height: size.height * 0.1,
                                                      width: size.width * 0.3,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.thucphams!
                                                                .elementAt(
                                                                    index)
                                                                .thucPham!
                                                                .ten
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            item.thucphams!
                                                                .elementAt(
                                                                    index)
                                                                .thucPham!
                                                                .giaTien
                                                                .toString(),
                                                          ),
                                                          Text(
                                                            "Còn lại: ${item.thucphams!.elementAt(index).soLuong.toString()}",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InputCountFood(
                                                isUpdate: isUpdate,
                                                size: size,
                                                idChiTietThucPham: item
                                                    .thucphams!
                                                    .elementAt(index)
                                                    .maChiTietThucPham!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                  isUpdate
                      ? Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () async {
                                    await viewModel.CancelUpdateSoLuong(
                                        context);
                                    setState(() {
                                      isUpdate = !isUpdate;
                                    });
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.05,
                                    child: const Center(
                                      child: Text(
                                        "HỦY",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: MaterialButton(
                                  onPressed: () async {
                                    await viewModel.SaveUpdate(context);
                                    setState(() {
                                      isUpdate = false;
                                    });
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.05,
                                    child: const Center(
                                      child: Text(
                                        "LƯU",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }

  getFormatedDate(_date) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    return inputFormat.format(_date);
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManageFoodViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          for (var item in viewModel.danhmucs!)
            Tab(
              text: item.loaiDanhMuc,
            )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            viewModel.BackupDanhMuc();
            isUpdate = !isUpdate;
            setState(() {});
          },
          icon: const Icon(
            Icons.system_update_alt,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () async {
            await viewModel.newChiTietThucPhamTrongNgay(context);
          },
          icon: const Icon(
            Icons.replay_circle_filled_rounded,
            color: Colors.white,
          ),
        ),
      ],
      title: Column(
        children: [
          const Text(
            'Quản Lý Món Ăn',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            "ngày: ${getFormatedDate(DateTime.now())}",
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

class InputCountFood extends StatelessWidget {
  const InputCountFood({
    Key? key,
    required this.isUpdate,
    required this.size,
    required this.idChiTietThucPham,
  }) : super(key: key);

  final bool isUpdate;
  final Size size;
  final int idChiTietThucPham;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageFoodViewModel>(context);
    return Flexible(
      flex: 1,
      child: !isUpdate
          ? Container()
          : Container(
              width: size.width * 0.15,
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    viewModel.CapNhatSoLuong(
                        int.parse(value), idChiTietThucPham);
                  } else {
                    viewModel.CapNhatSoLuong(0, idChiTietThucPham);
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
