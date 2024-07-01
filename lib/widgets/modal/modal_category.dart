import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/colors/global_colors.dart';

class ModalCategory extends StatefulWidget {
  const ModalCategory({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<ModalCategory> createState() => _ModalCategoryState();
}

class _ModalCategoryState extends State<ModalCategory> {
  // -- Local Variable -- //
  bool isNewCategory = false;

  // -- Local Controller -- //
  TextEditingController categoryController = TextEditingController();

  // -- Form Key -- //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // -- List for Category -- //
  final List<String> items = [
    'Agen Grosir',
    'Angkringan',
    'Arisan',
    'Bengkel',
    'Butik',
    'Distributor',
    'Percetakan/Printing',
    'Kerajinan',
    'Swalayan',
    'Warung',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: isNewCategory ? 200 : 700,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: GlobalColors.garisColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isNewCategory == false)
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            FeatherIcons.x,
                            size: 20,
                            color: GlobalColors.fourthColor,
                          ),
                        ),
                      )
                    else
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isNewCategory = false;
                            });
                          },
                          child: Icon(
                            FeatherIcons.arrowLeft,
                            size: 20,
                            color: GlobalColors.fourthColor,
                          ),
                        ),
                      ),
                    Text(
                      isNewCategory ? 'Tambah kategori' : 'Kategori',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: GlobalColors.textColor,
                      ),
                    ),
                    isNewCategory
                        ? Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  items.add(categoryController.text);
                                  setState(() {
                                    isNewCategory = false;
                                  });
                                }
                              },
                              child: Icon(
                                FeatherIcons.check,
                                size: 20,
                                color: GlobalColors.mainColor,
                              ),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isNewCategory = true;
                                });
                              },
                              child: Icon(
                                FeatherIcons.plus,
                                size: 20,
                                color: GlobalColors.mainColor,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              color: GlobalColors.garisColor,
              height: 1,
            ),
            if (isNewCategory == false)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          items[index],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: GlobalColors.textColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            widget.controller.text = items[index];
                          });
                        },
                      );
                    },
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.category_outlined,
                        color: GlobalColors.fourthColor,
                      ),
                      labelText: 'Kategori toko',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: GlobalColors.fourthColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: GlobalColors.mainColor, width: 1.5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: GlobalColors.garisColor, width: 1.5),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: GlobalColors.textColor,
                    ),
                    onChanged: (value) {
                      if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                        categoryController.text = value.substring(0, value.length - 1);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kategori tidak boleh kosong';
                      } else if (value.contains(RegExp(r'[0-9]'))) {
                        return 'Kategori tidak boleh mengandung angka';
                      } else if (value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]+-=_{}'))) {
                        return 'Kategori tidak boleh mengandung karakter khusus';
                      } else if (items.contains(value)) {
                        return 'Kategori sudah ada';
                      }
                      return null;
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
