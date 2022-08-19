import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_validator/form_validator.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:kurilki/common/const/const.dart';
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
  final List<String> _availableList = [Strings.trueString, Strings.falseString];
  late Item _item;
  List<ItemSettings> _itemsSettings = [];
  final List<ExpandedTileController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _itemsSettings = _item.itemSettings;
    for (int i = 0; i < _itemsSettings.length; i++) {
      _controllers.add(ExpandedTileController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllers.clear();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            color: theme.mainTextColor,
            onPressed: () {
              if (_item is DisposablePodEntity) {
                bloc.add(
                    UpdateDisposableItemEvent((_item as DisposablePodEntity).copyWith(itemSettings: _itemsSettings)));
              } else if (_item is Snus) {
                bloc.add(UpdateSnusItemEvent((_item as Snus).copyWith(itemSettings: _itemsSettings)));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: adaptiveWidth(300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: adaptiveHeight(5)),
                const _Divider(Strings.nameItem + ":", textSize: 16),
                RoundedInputField(
                  border: Border.all(color: theme.mainTextColor, width: 1),
                  initialValue: _item.name,
                  callback: (String callback) {
                    if (_item is DisposablePodEntity) {
                      _item = (_item as DisposablePodEntity).copyWith(name: callback);
                    } else if (_item is Snus) {
                      _item = (_item as Snus).copyWith(name: callback);
                    }
                  },
                  validation: ValidationBuilder()
                      .minLength(5, Strings.min5Characters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                const _Divider(Strings.imageLinkItem + ":", textSize: 16),
                RoundedInputField(
                  border: Border.all(color: theme.mainTextColor, width: 1),
                  initialValue: _item.imageLink,
                  maxLength: 120,
                  callback: (String callback) {
                    if (_item is DisposablePodEntity) {
                      _item = (_item as DisposablePodEntity).copyWith(imageLink: callback);
                    } else if (_item is Snus) {
                      _item = (_item as Snus).copyWith(imageLink: callback);
                    }
                  },
                  validation: ValidationBuilder().minLength(10, Strings.min10Characters).url(Strings.onlyUrl).build(),
                ),
                const _Divider(Strings.availableItem + ":", textSize: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    border: Border.all(color: theme.mainTextColor, width: 1),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioGroup<String>.builder(
                      activeColor: theme.mainTextColor,
                      textStyle: TextStyle(color: theme.mainTextColor),
                      spacebetween: 40,
                      groupValue: _item.isAvailable ? Strings.trueString : Strings.falseString,
                      onChanged: (value) {
                        final bool isAvailable = value as String == Strings.trueString ? true : false;
                        setState(() {
                          if (_item is DisposablePodEntity) {
                            _item = (_item as DisposablePodEntity).copyWith(isAvailable: isAvailable);
                          } else if (_item is Snus) {
                            _item = (_item as Snus).copyWith(isAvailable: isAvailable);
                          }
                        });
                      },
                      items: _availableList,
                      itemBuilder: (item) => RadioButtonBuilder(item),
                    ),
                  ),
                ),
                const _Divider(Strings.priceItem + ":", textSize: 16),
                RoundedInputField(
                  border: Border.all(color: theme.mainTextColor, width: 1),
                  inputType: TextInputType.number,
                  initialValue: _item.price.toStringAsFixed(0),
                  callback: (String callback) {
                    final double price = double.tryParse(callback) ?? _item.price;
                    if (_item is DisposablePodEntity) {
                      _item = (_item as DisposablePodEntity).copyWith(oldPrice: widget.item.price);
                      _item = (_item as DisposablePodEntity).copyWith(price: price);
                    } else if (_item is Snus) {
                      _item = (_item as Snus).copyWith(oldPrice: widget.item.price);
                      _item = (_item as Snus).copyWith(price: price)..copyWith(oldPrice: widget.item.price);
                    }
                  },
                  validation: ValidationBuilder()
                      .minLength(1, Strings.minCharacters)
                      .maxLength(30, Strings.max30Characters)
                      .build(),
                ),
                if (widget.item is DisposablePodEntity)
                  Column(
                    children: [
                      const _Divider(Strings.puffsItem + ":"),
                      RoundedInputField(
                        border: Border.all(color: theme.mainTextColor, width: 1),
                        inputType: TextInputType.number,
                        initialValue: (_item as DisposablePodEntity).puffsCount.toString(),
                        callback: (String callback) {
                          _item = (_item as DisposablePodEntity).copyWith(
                              puffsCount: int.tryParse(callback) ?? (_item as DisposablePodEntity).puffsCount);
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
                        border: Border.all(color: theme.mainTextColor, width: 1),
                        inputType: TextInputType.number,
                        initialValue: (_item as Snus).strength.toString(),
                        callback: (String callback) {
                          _item =
                              (_item as Snus).copyWith(strength: int.tryParse(callback) ?? (_item as Snus).strength);
                        },
                        validation: ValidationBuilder()
                            .minLength(1, Strings.minCharacters)
                            .maxLength(30, Strings.max30Characters)
                            .build(),
                      ),
                    ],
                  ),
                const _Divider(Strings.itemSettings + ":", textSize: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    border: Border.all(color: theme.mainTextColor, width: 1),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Column(
                    children: [
                      if (_itemsSettings.isNotEmpty)
                        ListView.builder(
                          itemCount: _itemsSettings.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: adaptiveWidth(0.22),
                                children: [
                                  if (!_controllers[index].isExpanded)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(29)),
                                        child: Material(
                                          color: theme.cardColor,
                                          child: InkWell(
                                            onTap: () {
                                              _itemsSettings.removeAt(index);
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
                                      initialValue: _itemsSettings[index].name,
                                      callback: (String callback) {
                                        _itemsSettings[index] = _itemsSettings[index].copyWith(name: callback);
                                      },
                                      validation: ValidationBuilder()
                                          .minLength(1, Strings.minCharacters)
                                          .maxLength(30, Strings.max30Characters)
                                          .build(),
                                    ),
                                    const _Divider(Strings.imageLinkItem + ":"),
                                    RoundedInputField(
                                      initialValue: _itemsSettings[index].imageLink,
                                      maxLength: 120,
                                      callback: (String callback) =>
                                          _itemsSettings[index] = _itemsSettings[index].copyWith(imageLink: callback),
                                      validation: ValidationBuilder().minLength(1, Strings.minCharacters).build(),
                                    ),
                                    const _Divider(Strings.countItem + ":"),
                                    RoundedInputField(
                                      inputType: TextInputType.number,
                                      initialValue: _itemsSettings[index].count.toString(),
                                      callback: (String callback) {
                                        final int count = int.tryParse(callback) ?? _itemsSettings[index].count;
                                        if (count == 0) {
                                          _itemsSettings[index] = _itemsSettings[index].copyWith(isAvailable: false);
                                          setState(() {});
                                        }
                                        _itemsSettings[index] = _itemsSettings[index].copyWith(count: count);
                                      },
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
                                          groupValue: _itemsSettings[index].isAvailable == true
                                              ? Strings.trueString
                                              : Strings.falseString,
                                          onChanged: (value) => setState(() {
                                            _itemsSettings[index] = _itemsSettings[index].copyWith(
                                                isAvailable: value as String == Strings.trueString ? true : false);
                                          }),
                                          items: _availableList,
                                          itemBuilder: (item) => RadioButtonBuilder(item),
                                        ),
                                      ),
                                    ),
                                    const _Divider(Strings.isPopular + ":"),
                                    RadioGroup<String>.builder(
                                      activeColor: theme.mainTextColor,
                                      textStyle: TextStyle(color: theme.mainTextColor),
                                      spacebetween: 40,
                                      groupValue: _itemsSettings[index].isPopular == true
                                          ? Strings.trueString
                                          : Strings.falseString,
                                      onChanged: (value) => setState(() {
                                        _itemsSettings[index] = _itemsSettings[index]
                                            .copyWith(isPopular: value as String == Strings.trueString ? true : false);
                                      }),
                                      items: _availableList,
                                      itemBuilder: (item) => RadioButtonBuilder(item),
                                    ),
                                  ],
                                ),
                                title: AutoSizeText(
                                  _itemsSettings[index].name.isEmpty
                                      ? Strings.emptyConfiraguration
                                      : _itemsSettings[index].name,
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
                                controller: _controllers[index],
                              ),
                            );
                          }),
                        ),
                      SizedBox(
                        height: adaptiveHeight(60),
                        child: MainRoundedButton(
                            text: Strings.addConfigurationButton,
                            textStyle: theme.fontStyles.regular16.copyWith(color: theme.whiteTextColor),
                            color: theme.mainTextColor,
                            callback: () {
                              _controllers.add(ExpandedTileController());
                              _itemsSettings.add(ItemSettings(
                                count: 0,
                                isAvailable: false,
                                name: '',
                                isPopular: false,
                                imageLink: Const.whiteImage,
                              ));
                              setState(() {});
                            },
                            theme: theme),
                      ),
                    ],
                  ),
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
