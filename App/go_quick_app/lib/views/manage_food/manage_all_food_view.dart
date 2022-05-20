import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/add_food_form/add_food_form_view.dart';
import 'package:go_quick_app/views/confirm_food/confirm_add_food_view.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/manage_food/manage_food_view.dart';
import 'package:go_quick_app/views/manage_food/manager_all_food_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageAllFoodView extends StatefulWidget {
  const ManageAllFoodView({Key? key}) : super(key: key);

  @override
  State<ManageAllFoodView> createState() => _ManageAllFoodViewState();
}

class _ManageAllFoodViewState extends State<ManageAllFoodView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageAllFoodViewModel>(context);
    if (viewModel.isInit) {
      return WillPopScope(
        onWillPop: () async {
          viewModel.clear();
          NavigationHelper.pushReplacement(
              context: context, page: const HomeView());
          return true;
        },
        child: DefaultTabController(
          length: viewModel.danhmucs.length,
          child: Scaffold(
            appBar: buildAppBar(size, context, viewModel),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      for (var item in viewModel.danhmucs)
                        RefreshIndicator(
                          color: kPrimaryColor,
                          onRefresh: () async {
                            await viewModel.Init(context);
                          },
                          child: ListView.builder(
                            itemCount: item.thucPhamList?.length,
                            itemBuilder: (context, index) {
                              ThucPham thucPham = item.thucPhamList![index];
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
                                        quyen: viewModel.quyen,
                                      ),
                                    );
                                    viewModel.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
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
                                        Column(
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
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                )
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

  AppBar buildAppBar(
      Size size, BuildContext context, ManageAllFoodViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          for (var item in viewModel.danhmucs)
            Tab(
              text: item.loaiDanhMuc,
            )
        ],
      ),
      actions: [
        ['QUANLY'].contains(viewModel.quyen)
            ? IconButton(
                onPressed: () async {
                  NavigationHelper.push(
                      context: context,
                      page: ConfirmAddFoodView(
                        quyen: viewModel.quyen,
                      ));
                  viewModel.clear();
                },
                icon: Icon(Icons.checklist_rtl_outlined),
              )
            : Container(),
        IconButton(
          onPressed: () async {
            NavigationHelper.push(
                context: context, page: const AddFoodFormView());
            viewModel.clear();
          },
          icon: Icon(Icons.add_box_rounded),
        ),
      ],
      title: Column(
        children: [
          Text(
            'Quản lý món ăn',
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
              context: context, page: const HomeView());
        },
      ),
    );
  }
}
