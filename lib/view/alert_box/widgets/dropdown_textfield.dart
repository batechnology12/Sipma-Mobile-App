import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/searchable_dropdown-master/lib/dropdown_search.dart';

class DropdownTextFieldWidgets extends StatefulWidget {
  DropdownTextFieldWidgets(
      {super.key, required this.DropHintText, required this.list});

  final String DropHintText;
  final String list;

  @override
  State<DropdownTextFieldWidgets> createState() =>
      _DropdownTextFieldWidgetsState();
}

class _DropdownTextFieldWidgetsState extends State<DropdownTextFieldWidgets> {
  bool isEdSelected = false;

  List datas = [];

  @override
  Widget build(BuildContext context) {
    return Container(height: 50,
      child: DropdownSearch(
        // itemAsString: (Educationlistdata u) =>
        //     u.title,
    
        popupProps: PopupProps.menu(
          showSelectedItems: false,
          showSearchBox: true,
          itemBuilder: (context, item, isSelcted) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'data',
                    //item.title,
                    style: primaryfont.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  for (int i = 0; i < datas.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          // print(
                          //     "-<->-<->-<->-<->changes<->-<->-<->-<->-<->");
                          // setState(
                          //   () {
                          //     datas
                          //         .(
                          //             false);
                          //     isEdSelected =
                          //         true;
                          //     education =
                          //         "${item.title} ${item.educationlist[i].name}";
                          //     edHintText =
                          //         "${item.title} ${item.educationlist[i].name}";
                          //     educationController
                          //             .text =
                          //         "${item.title} ${item.educationlist[i].name}";
                          //     // requiremtsSelected = null;
                          //   },
                          // );
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          // color: Colors.red,
                          child: Text(widget.list,
                              // item
                              //     .educationlist[
                              //         i]
                              //     .name,
                              style: primaryfont
                                  .copyWith(
                                      fontSize:
                                          13),
                              ),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
          menuProps: MenuProps(borderRadius: BorderRadius.circular(10)),
          searchFieldProps: const TextFieldProps(),
        ),
        items: datas,
    
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: widget.DropHintText,
            hintStyle:
                TextStyle(color: isEdSelected ? Colors.black : Colors.black45),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        // onChanged: (value) {
        //   setState(
        //     () {
        //       authController
        //           .isEducationSelected(false);
        //       education = value!;
        //       educationController.text =
        //           value.title;
        //       // requiremtsSelected = null;
        //     },
        //   );
        // },
      ),
    );
  }
}
