import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:form_validator/form_validator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/strings.dart';
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
  List<String> availableList = ["true", "false"];
  List<String> typeList = ["empty", "filled"];
  Item? item;
  List<ItemSettings> itemsSettings = [];
  List<ExpandedTileController> controllers = [];

  @override
  void initState() {
    super.initState();
    item = widget.item;
    itemsSettings = item!.itemSettings;
    for (int i = 0; i < itemsSettings.length; i++) {
      controllers.add(ExpandedTileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final scale = byWithScale(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Редактирование",
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.accentColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: scale * 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Divider("Name: ", textSize: 16),
                RoundedInputField(
                  hint: item!.name,
                  callback: (String callback) {
                    if (item is DisposablePodEntity) {
                      item = (item as DisposablePodEntity).copyWith(name: callback);
                    } else if (item is Snus) {
                      item = (item as Snus).copyWith(name: callback);
                    }
                  },
                  validation: ValidationBuilder()
                      .minLength(5, Strings.min5Characters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                const _Divider("Image link: ", textSize: 16),
                RoundedInputField(
                  hint: item!.imageLink,
                  maxLength: 120,
                  callback: (String callback) {
                    if (item is DisposablePodEntity) {
                      item = (item as DisposablePodEntity).copyWith(imageLink: callback);
                    } else if (item is Snus) {
                      item = (item as Snus).copyWith(imageLink: callback);
                    }
                  },
                  validation: ValidationBuilder().minLength(10, Strings.min10Characters).url(Strings.onlyUrl).build(),
                ),
                const _Divider("Available: ", textSize: 16),
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
                      groupValue: item!.isAvailable ? "true" : "false",
                      onChanged: (value) {
                        final bool isAvailable = value as String == "true" ? true : false;
                        setState(() {
                          if (item is DisposablePodEntity) {
                            item = (item as DisposablePodEntity).copyWith(isAvailable: isAvailable);
                          } else if (item is Snus) {
                            item = (item as Snus).copyWith(isAvailable: isAvailable);
                          }
                        });
                      },
                      items: availableList,
                      itemBuilder: (item) => RadioButtonBuilder(item),
                    ),
                  ),
                ),
                const _Divider("Price: ", textSize: 16),
                RoundedInputField(
                  inputType: TextInputType.number,
                  hint: item!.price.toString(),
                  callback: (String callback) {
                    final double price = double.tryParse(callback) ?? item!.price;
                    if (item is DisposablePodEntity) {
                      item = (item as DisposablePodEntity).copyWith(oldPrice: widget.item.price);
                      item = (item as DisposablePodEntity).copyWith(price: price);
                    } else if (item is Snus) {
                      item = (item as Snus).copyWith(oldPrice: widget.item.price);
                      item = (item as Snus).copyWith(price: price)..copyWith(oldPrice: widget.item.price);
                    }
                  },
                  validation: ValidationBuilder()
                      .minLength(1, Strings.minCharacters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                const _Divider("ItemSettings: ", textSize: 16),
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
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const _Divider("Name: "),
                                  RoundedInputField(
                                    hint: itemsSettings[index].name,
                                    callback: (String callback) {
                                      itemsSettings[index] = itemsSettings[index].copyWith(name: callback);
                                    },
                                    validation: ValidationBuilder()
                                        .minLength(1, Strings.minCharacters)
                                        .maxLength(30, Strings.max30Characters)
                                        .build(),
                                  ),
                                  const _Divider("Image link: "),
                                  RoundedInputField(
                                    hint: itemsSettings[index].imageLink,
                                    maxLength: 120,
                                    callback: (String callback) =>
                                        itemsSettings[index] = itemsSettings[index].copyWith(imageLink: callback),
                                    validation: ValidationBuilder()
                                        .minLength(1, Strings.minCharacters)
                                        .phone(Strings.onlyUrl)
                                        .build(),
                                  ),
                                  const _Divider("Count: "),
                                  RoundedInputField(
                                    inputType: TextInputType.number,
                                    hint: itemsSettings[index].count.toString(),
                                    callback: (String callback) => itemsSettings[index] = itemsSettings[index]
                                        .copyWith(count: int.tryParse(callback) ?? itemsSettings[index].count),
                                    validation: ValidationBuilder()
                                        .minLength(1, Strings.minCharacters)
                                        .maxLength(30, Strings.max30Characters)
                                        .build(),
                                  ),
                                  const _Divider("Available:"),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: RadioGroup<String>.builder(
                                        activeColor: theme.mainTextColor,
                                        textStyle: TextStyle(color: theme.mainTextColor),
                                        spacebetween: 35,
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
                                  const _Divider("Type: "),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: RadioGroup<String>.builder(
                                        activeColor: theme.mainTextColor,
                                        textStyle: TextStyle(color: theme.mainTextColor),
                                        spacebetween: 35,
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
                                ],
                              ),
                              title: AutoSizeText(
                                itemsSettings[index].name,
                                style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              contentSeperator: 4,
                              theme: ExpandedTileThemeData(
                                headerColor: theme.cardColor,
                                headerRadius: 29.0,
                                contentRadius: 29,
                                contentBackgroundColor: theme.cardColor,
                                contentPadding: const EdgeInsets.all(4),
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
                  RoundedInputField(
                    inputType: TextInputType.number,
                    hint: (item as DisposablePodEntity).puffsCount.toString(),
                    callback: (String callback) {
                      item = (item as DisposablePodEntity)
                          .copyWith(puffsCount: int.tryParse(callback) ?? (item as DisposablePodEntity).puffsCount);
                    },
                    validation: ValidationBuilder()
                        .minLength(1, Strings.minCharacters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  )
                else if (widget.item is Snus)
                  RoundedInputField(
                    inputType: TextInputType.number,
                    hint: (item as Snus).strength.toString(),
                    callback: (String callback) {
                      item = (item as Snus).copyWith(strength: int.tryParse(callback) ?? (item as Snus).strength);
                    },
                    validation: ValidationBuilder()
                        .minLength(1, Strings.minCharacters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                MainRoundedButton(
                  text: "Update item",
                  color: theme.accentColor,
                  textStyle: TextStyle(color: theme.infoTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                  callback: () {
                    if (item is DisposablePodEntity) {
                      bloc.add(UpdateDisposableItemEvent(
                          (item as DisposablePodEntity).copyWith(itemSettings: itemsSettings)));
                    } else if (item is Snus) {
                      bloc.add(UpdateSnusItemEvent((widget.item as Snus).copyWith(itemSettings: itemsSettings)));
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
  }
}

class _Divider extends StatelessWidget {
  const _Divider(this.text, {Key? key, this.textSize = 14}) : super(key: key);
  final String text;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);
    return Row(
      children: [
        SizedBox(width: scale * 20),
        Text(text, style: TextStyle(color: theme.infoTextColor, fontSize: textSize)),
      ],
    );
  }
}
