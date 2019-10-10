import 'package:flutter/material.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/pages/section_seven/add_visitor.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/routes/routes.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/providers/providers.dart';

void main() => runApp(GateMan());

class GateMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'GateMan App',
        initialRoute: '/splash',
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          primarySwatch: GateManColors.primarySwatchColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: GateManColors.textColor,
                displayColor: GateManColors.textColor,
              ),
          fontFamily: 'OpenSans',
        ),
        // home: ManageAddress(),
        home:AddVisitor(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
