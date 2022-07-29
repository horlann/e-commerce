import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';
import 'package:kurilki/presentation/pages/admin/widgets/admin_panel.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class CreateNewItem extends StatelessWidget {
  const CreateNewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return BlocBuilder<AdminBloc, AdminState>(
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
      //   ),
    );
  }
}
