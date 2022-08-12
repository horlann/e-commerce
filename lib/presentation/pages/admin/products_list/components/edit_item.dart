import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_validator/form_validator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
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
  List<String> availableList = [Strings.trueString, Strings.falseString];
  List<String> typeList = [Strings.empty, Strings.filled];
  late Item item;
  List<ItemSettings> itemsSettings = [];
  List<ExpandedTileController> controllers = [];

  @override
  void initState() {
    super.initState();
    item = widget.item;
    itemsSettings = item.itemSettings;
    for (int i = 0; i < itemsSettings.length; i++) {
      controllers.add(ExpandedTileController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminItemBloc bloc = BlocProvider.of<AdminItemBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.reduct,
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.mainTextColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: adaptiveWidth(300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: adaptiveHeight(10)),
                const _Divider(Strings.nameItem + ":", textSize: 16),
                RoundedInputField(
                  hint: item.name,
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
                const _Divider(Strings.imageLinkItem + ":", textSize: 16),
                RoundedInputField(
                  hint: item.imageLink,
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
                const _Divider(Strings.availableItem + ":", textSize: 16),
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
                      groupValue: item.isAvailable ? Strings.trueString : Strings.falseString,
                      onChanged: (value) {
                        final bool isAvailable = value as String == Strings.trueString ? true : false;
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
                const _Divider(Strings.priceItem + ":", textSize: 16),
                RoundedInputField(
                  inputType: TextInputType.number,
                  hint: item.price.toStringAsFixed(0),
                  callback: (String callback) {
                    final double price = double.tryParse(callback) ?? item.price;
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
                const _Divider(Strings.itemSettings + ":", textSize: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Column(
                    children: [
                      if (itemsSettings.isNotEmpty)
                        ListView.builder(
                          itemCount: itemsSettings.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: adaptiveWidth(0.22),
                                children: [
                                  if (!controllers[index].isExpanded)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(29)),
                                        child: Material(
                                          color: theme.cardColor,
                                          child: InkWell(
                                            onTap: () {
                                              itemsSettings.removeAt(index);
                                              bloc.add(const InitItemsEvent());
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: adaptiveHeight(60),
                                              width: adaptiveWidth(60),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(29),
                                              ),
                                              child: const Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox.shrink()
                                ],
                              ),
                              child: ExpandedTile(
                                onTap: () => setState(() {}),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const _Divider(Strings.nameItem + ":"),
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
                                    const _Divider(Strings.imageLinkItem + ":"),
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
                                    const _Divider(Strings.countItem + ":"),
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
                                    const _Divider(Strings.availableItem + ":"),
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
                                          groupValue: itemsSettings[index].isAvailable == true
                                              ? Strings.trueString
                                              : Strings.falseString,
                                          onChanged: (value) => setState(() {
                                            itemsSettings[index] = itemsSettings[index].copyWith(
                                                isAvailable: value as String == Strings.trueString ? true : false);
                                          }),
                                          items: availableList,
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
                              ),
                            );
                          }),
                        ),
                      MainRoundedButton(
                          text: Strings.addConfigurationButton,
                          textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                          color: theme.mainTextColor,
                          callback: () {
                            controllers.add(ExpandedTileController());
                            itemsSettings.add(ItemSettings(
                              count: 0,
                              isAvailable: false,
                              name: '',
                              isPopular: false,
                              imageLink: "https://i.ibb.co/2qQqzdR/e.png",
                            ));
                            setState(() {});
                          },
                          theme: theme),
                    ],
                  ),
                ),
                if (widget.item is DisposablePodEntity)
                  Column(
                    children: [
                      const _Divider(Strings.puffsItem + ":"),
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
                      ),
                    ],
                  )
                else if (widget.item is Snus)
                  Column(
                    children: [
                      const _Divider(Strings.strengthItem + ":"),
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
                    ],
                  ),
                MainRoundedButton(
                  text: Strings.updateItemButton,
                  textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                  color: theme.mainTextColor,
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
                SizedBox(height: adaptiveHeight(10)),
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

    return Row(
      children: [
        SizedBox(width: adaptiveWidth(20), height: adaptiveHeight(30)),
        Text(text, style: theme.fontStyles.regular16.copyWith(color: theme.mainTextColor)),
      ],
    );
  }
}
