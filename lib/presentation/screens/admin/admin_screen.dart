import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/admin/components/admin_panel.dart';
import 'package:kurilki/presentation/screens/admin/components/orders_list.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return BlocProvider(
      create: (_) => AdminBloc(getIt.call(), getIt.call())..add(const InitDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Admin Panel", style: TextStyle(color: theme.backgroundColor)),
          backgroundColor: theme.accentColor,
        ),
        body: Column(
          children: [
            const Expanded(child: OrdersList()),
            Expanded(
              child: BlocBuilder<AdminBloc, AdminState>(
                buildWhen: (previous, current) => previous != current && current is DataLoadedState,
                builder: ((context, state) {
                  if (state is InProgressLoadingState) {
                    return Center(child: CircularProgressIndicator(color: theme.accentColor));
                  } else if (state is DataLoadedState) {
                    return AdminPanel(categories: state.categories);
                  } else {
                    return const Text('error');
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
