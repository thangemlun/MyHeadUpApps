import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/mvvm/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {

  var homePageViewModel = HomePageViewModel();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(future: homePageViewModel.authenticateUser(),
        builder: (context, snap) {
      		return ChangeNotifierProvider(create: (_) => homePageViewModel,
          	child: Consumer<HomePageViewModel>(builder: (context, model, child) {
              return model.page;
            })
          );
        });
  }

}