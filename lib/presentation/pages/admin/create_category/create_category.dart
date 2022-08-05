import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_event.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_state.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKey = GlobalKey<FormState>();
  String _category = "";
  late final AdminCategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cоздать категорию",
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.accentColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: BlocBuilder<AdminCategoryBloc, AdminCategoryState>(
        builder: ((context, state) {
          if (state is InProgressLoadingState) {
            return Center(child: CircularProgressIndicator(color: theme.accentColor));
          } else if (state is CreateCategoryState) {
            return Container(
              color: theme.backgroundColor,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: adaptiveWidth(300),
                    child: Column(
                      children: [
                        SizedBox(height: adaptiveHeight(10)),
                        RoundedInputField(
                          hint: Strings.categoryItem,
                          callback: (String callback) => _category = callback,
                          validation: ValidationBuilder()
                              .minLength(1, Strings.minCharacters)
                              .maxLength(20, Strings.max20Characters)
                              .build(),
                        ),
                        SizedBox(height: adaptiveHeight(10)),
                        MainRoundedButton(
                          text: "Create category",
                          color: theme.accentColor,
                          textStyle: TextStyle(color: theme.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                          callback: () {
                            if (_formKey.currentState!.validate() && _category.isNotEmpty) {
                              categoryBloc.add(SaveCategoryEvent(_category));
                            }
                          },
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        }),
      ),
    );
  }
}
