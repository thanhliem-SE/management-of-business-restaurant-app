import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/confirm_food/confirm_add_food_view_model.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';
import 'package:go_quick_app/views/manage_food/manager_all_food_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmAddFoodView extends StatefulWidget {
  final String quyen;
  ConfirmAddFoodView({Key? key, required this.quyen}) : super(key: key);

  @override
  State<ConfirmAddFoodView> createState() => _ConfirmAddFoodViewState();
}

class _ConfirmAddFoodViewState extends State<ConfirmAddFoodView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ConfirmAddFoodViewModel>(context);
    if (viewModel.isInit) {
      return WillPopScope(
        onWillPop: () async {
          viewModel.clear();
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAllFoodView());
          return true;
        },
        child: Scaffold(
          appBar: buildAppBar(size, context, viewModel),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  color: kPrimaryColor,
                  onRefresh: () async {
                    await viewModel.Init(context);
                  },
                  child: ListView.builder(
                    itemCount: viewModel.thucPhamChuaDuyets.length,
                    itemBuilder: (context, index) {
                      ThucPham thucPham =
                          viewModel.getThucPhamChuaDuyets[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            NavigationHelper.push(
                              context: context,
                              page: DetailFoodView(
                                thucPham: thucPham,
                                quyen: widget.quyen,
                              ),
                            );
                            viewModel.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            thucPham.urlHinhAnh![0],
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
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
                                            width: size.width * 0.2,
                                            height: size.height * 0.1,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                thucPham.ten!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                'mô tả: ${thucPham.moTa}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                NumberFormat('###,###').format(
                                                        thucPham.giaTien) +
                                                    'đ',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () async {
                                          await viewModel.duyetThucPham(
                                              context, thucPham);
                                        },
                                        child: Text("Duyệt"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent,
                                        ),
                                        onPressed: () async {
                                          await viewModel.xoaThucPham(
                                              context, thucPham);
                                        },
                                        child: Text("Từ chối"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
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

  AppBar buildAppBar(
      Size size, BuildContext context, ConfirmAddFoodViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Danh sách thực phẩm cần duyệt',
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
          viewModel.clear();
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAllFoodView());
        },
      ),
    );
  }
}
