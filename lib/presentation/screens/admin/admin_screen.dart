import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/admin/components/admin_panel.dart';

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
      create: (_) => AdminBloc(getIt.call())..add(const InitDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Admin Panel", style: TextStyle(color: theme.backgroundColor)),
          backgroundColor: theme.accentColor,
        ),
        body: BlocBuilder<AdminBloc, AdminState>(
          builder: ((context, state) {
            if (state is InProgressLoadingState) {
              return Center(child: CircularProgressIndicator(color: theme.accentColor));
            } else if (state is DataLoadedState) {
              return AdminPanel(categories: state.categories);
            } else if (state is AdminFailureState) {
              return const Center(child: SizedBox(child: Text("Something went wrong")));
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
