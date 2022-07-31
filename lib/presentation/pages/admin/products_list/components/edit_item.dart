import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
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
  List<String> typeList = ["empty", "filled"];
  double price = 0;
  List<String> tags = [];
  List<ItemSettings> itemsSettings = [];

  List<ExpandedTileController> controllers = [];

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    //category = widget.item.category;
    imageLink = widget.item.imageLink;
    isAvailable = widget.item.isAvailable ? "true" : "false";
    price = widget.item.price;
    tags = widget.item.tags;
    itemsSettings = widget.item.itemSettings;
    for (int i = 0; i < itemsSettings.length; i++) {
      controllers.add(ExpandedTileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: scale * 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scale * 10),
              Row(
                children: [
                  SizedBox(width: scale * 20),
                  Text(
                    "Name: ",
                    style: TextStyle(color: theme.infoTextColor, fontSize: 16),
                  ),
                ],
              ),
              RoundedInputField(
                hint: name,
                callback: (String callback) => name = callback,
              ),
              SizedBox(height: scale * 10),
              /*RoundedInputField(
                hint: category,
                callback: (String callback) => category = callback,
              ),
              SizedBox(height: scale * 10),*/
              Row(
                children: [
                  SizedBox(width: scale * 20),
                  Text(
                    "Image link: ",
                    style: TextStyle(color: theme.infoTextColor, fontSize: 16),
                  ),
                ],
              ),
              RoundedInputField(
                hint: imageLink,
                callback: (String callback) => imageLink = callback,
              ),
              SizedBox(height: scale * 10),
              Row(
                children: [
                  SizedBox(width: scale * 20),
                  Text(
                    "Available: ",
                    style: TextStyle(color: theme.infoTextColor, fontSize: 16),
                  ),
                ],
              ),
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
              Row(
                children: [
                  SizedBox(width: scale * 20),
                  Text(
                    "Price: ",
                    style: TextStyle(color: theme.infoTextColor, fontSize: 16),
                  ),
                ],
              ),
              RoundedInputField(
                inputType: TextInputType.number,
                hint: price.toString(),
                callback: (String callback) => price = double.tryParse(callback) ?? price,
              ),
              SizedBox(height: scale * 10),
              Row(
                children: [
                  SizedBox(width: scale * 20),
                  Text(
                    "ItemSettings: ",
                    style: TextStyle(color: theme.infoTextColor, fontSize: 16),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.secondBackgroundColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Column(
                  children: [
                    if (itemsSettings.isNotEmpty)
                      ListView.builder(
                        itemCount: itemsSettings.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return ExpandedTile(
                            content: Container(
                              color: theme.secondBackgroundColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: scale * 20),
                                      Text(
                                        "Name: ",
                                        style: TextStyle(color: theme.infoTextColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  RoundedInputField(
                                    hint: itemsSettings[index].name,
                                    callback: (String callback) {
                                      itemsSettings[index] = itemsSettings[index].copyWith(name: callback);
                                    },
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: scale * 20),
                                      Text(
                                        "Image Link: ",
                                        style: TextStyle(color: theme.infoTextColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  RoundedInputField(
                                    hint: itemsSettings[index].imageLink,
                                    callback: (String callback) =>
                                        itemsSettings[index] = itemsSettings[index].copyWith(imageLink: imageLink),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: scale * 20),
                                      Text(
                                        "Count: ",
                                        style: TextStyle(color: theme.infoTextColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  RoundedInputField(
                                    inputType: TextInputType.number,
                                    hint: itemsSettings[index].count.toString(),
                                    callback: (String callback) => itemsSettings[index] = itemsSettings[index]
                                        .copyWith(count: int.tryParse(callback) ?? itemsSettings[index].count),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: scale * 20),
                                      Text(
                                        "Available: ",
                                        style: TextStyle(color: theme.infoTextColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
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
                                        groupValue: itemsSettings[index].isAvailable == true ? "true" : "false",
                                        onChanged: (value) => setState(() {
                                          itemsSettings[index] = itemsSettings[index]
                                              .copyWith(isAvailable: value as String == "true" ? true : false);
                                        }),
                                        items: availableList,
                                        itemBuilder: (item) => RadioButtonBuilder(item),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: scale * 20),
                                      Text(
                                        "Type: ",
                                        style: TextStyle(color: theme.infoTextColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
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
                                        groupValue:
                                            itemsSettings[index].type == ItemSettingsType.empty ? "empty" : "filled",
                                        onChanged: (value) => setState(() {
                                          itemsSettings[index] = itemsSettings[index].copyWith(
                                              type: value as String == "empty"
                                                  ? ItemSettingsType.empty
                                                  : ItemSettingsType.filled);
                                        }),
                                        items: typeList,
                                        itemBuilder: (item) => RadioButtonBuilder(item),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: scale * 5),
                                ],
                              ),
                            ),
                            title: AutoSizeText(
                              itemsSettings[index].name,
                              style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            theme: ExpandedTileThemeData(
                              headerColor: theme.cardColor,
                              headerRadius: 29.0,
                              contentBackgroundColor: theme.cardColor,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                            controller: controllers[index],
                          );
                        }),
                      ),
                    MainRoundedButton(
                        text: "Add configuration",
                        color: theme.accentColor,
                        textStyle: TextStyle(color: theme.infoTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                        callback: () {
                          controllers.add(ExpandedTileController());
                          itemsSettings.add(ItemSettings(
                              count: 0, imageLink: '', isAvailable: false, name: '', type: ItemSettingsType.empty));
                          setState(() {});
                        },
                        theme: theme),
                  ],
                ),
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
                  itemSettings: itemsSettings,
                  puffsCount: (widget.item as DisposablePodEntity).puffsCount,
                  uuid: (widget.item as DisposablePodEntity).uuid,
                ))
              else if (widget.item is Snus)
                EditSnusItem(
                  item: Snus(
                    imageLink: imageLink,
                    isAvailable: isAvailable == "true" ? true : false,
                    name: name,
                    category: widget.item.category,
                    id: widget.item.id,
                    oldPrice: widget.item.price,
                    price: price,
                    tags: [],
                    itemSettings: itemsSettings,
                    strength: (widget.item as Snus).strength,
                    uuid: (widget.item as Snus).uuid,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
