import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/edit_disposable_item.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/edit_snus_item.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class EditItem extends StatefulWidget {
  const EditItem({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  String name = "";
  //String category = "";
  String imageLink = "";
  String isAvailable = "true";
  List<String> availableList = ["true", "false"];
  double price = 0;
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    //category = widget.item.category;
    imageLink = widget.item.imageLink;
    isAvailable = widget.item.isAvailable ? "true" : "false";
    price = widget.item.price;
    tags = widget.item.tags;
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: scale * 200,
          child: Column(
            children: [
              SizedBox(height: scale * 10),
              RoundedInputField(
                hint: name,
                callback: (String callback) => name = callback,
              ),
              SizedBox(height: scale * 10),
              /*RoundedInputField(
                hint: category,
                callback: (String callback) => category = callback,
              ),*/
              SizedBox(height: scale * 10),
              RoundedInputField(
                hint: imageLink,
                callback: (String callback) => imageLink = callback,
              ),
              SizedBox(height: scale * 10),
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioGroup<String>.builder(
                    activeColor: theme.mainTextColor,
                    textStyle: TextStyle(color: theme.mainTextColor),
                    spacebetween: 40,
                    groupValue: isAvailable,
                    onChanged: (value) => setState(() {
                      isAvailable = value as String;
                    }),
                    items: availableList,
                    itemBuilder: (item) => RadioButtonBuilder(item),
                  ),
                ),
              ),
              SizedBox(height: scale * 10),
              RoundedInputField(
                inputType: TextInputType.number,
                hint: price.toString(),
                callback: (String callback) => price = double.tryParse(callback) ?? price,
              ),
              SizedBox(height: scale * 10),
              if (widget.item is DisposablePodEntity)
                EditDisposableItem(
                    item: DisposablePodEntity(
                  category: widget.item.category,
                  id: widget.item.id,
                  imageLink: imageLink,
                  isAvailable: isAvailable == "true" ? true : false,
                  name: name,
                  oldPrice: widget.item.price,
                  price: price,
                  tags: [],
                  itemSettings: (widget.item as DisposablePodEntity).itemSettings,
                  puffsCount: (widget.item as DisposablePodEntity).puffsCount,
                  uuid: (widget.item as DisposablePodEntity).uuid,
                ))
              else if (widget.item is Snus)
                EditSnusItem(
                  item: Snus(
                    category: widget.item.category,
                    id: widget.item.id,
                    imageLink: imageLink,
                    isAvailable: isAvailable == "true" ? true : false,
                    name: name,
                    oldPrice: widget.item.price,
                    price: price,
                    tags: [],
                    strength: (widget.item as Snus).strength,
                    uuid: (widget.item as Snus).uuid,
                    itemSettings: [], //TODO itemSettings
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
