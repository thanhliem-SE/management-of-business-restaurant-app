import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
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
  bool isLoading = false;
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageAllFoodViewModel>(context);
    viewModel.Init(context);
    if (viewModel.danhmucs != null) {
      isLoading = false;
      setState(() {});
    } else {
      isLoading = true;
      setState(() {});
    }
    return isLoading
        ? Scaffold(
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
                    flex: 1,
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
                                                            style: TextStyle(
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                ],
              ),
            ),
          );
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManageAllFoodViewModel viewModel) {
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
            NavigationHelper.push(
                context: context, page: const ManageFoodView());
          },
          icon: Icon(Icons.update),
        ),
      ],
      title: Column(
        children: [
          Text(
            'Quản Lý Danh Sách Món Ăn',
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
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
