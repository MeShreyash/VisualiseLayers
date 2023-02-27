import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../models/menu_category.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Category>? selectedCategoryList = [];

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<Category>(
      context,
      hideSelectedTextCount: false,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Category',
      height: 500,
      listData: CategoryList,
      selectedListData: selectedCategoryList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (Category, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return Category.name!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedCategoryList = List.from(list!);
        });
        Navigator.pop(context);
      },

      /// uncomment below code to create custom choice chip
      /* choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.blue[300] : Colors.grey[500]),
          ),
        );
      }, */
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final list = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(
                      allTextList: CategoryList,
                      selectedCategoryList: selectedCategoryList,
                    ),
                  ),
                );
                if (list != null) {
                  setState(() {
                    selectedCategoryList = List.from(list);
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Page",
                style: TextStyle(color: Colors.white),
              ),
            ),
            // TextButton(
            //   onPressed: _openFilterDialog,
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.blue),
            //   ),
            //   child: const Text(
            //     "Filter Dialog",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   // color: Colors.blue,
            // ),
            // TextButton(
            //   onPressed: openFilterDelegate,
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.blue),
            //   ),
            //   child: const Text(
            //     "Filter Delegate",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   // color: Colors.blue,
            // ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          if (selectedCategoryList == null || selectedCategoryList!.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No Category selected'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedCategoryList![index].name!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedCategoryList!.length,
              ),
            ),
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.allTextList, this.selectedCategoryList})
      : super(key: key);
  final List<Category>? allTextList;
  final List<Category>? selectedCategoryList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 10, 10),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              elevation: 0,
              label: const Text('Add Layer'),
              icon: const Icon(Icons.download_rounded),
              backgroundColor: Color.fromARGB(255, 0, 70, 102).withOpacity(0.2),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FilterListWidget<Category>(
          themeData: FilterListThemeData(context),
          hideSelectedTextCount: true,
          listData: CategoryList,
          selectedListData: selectedCategoryList,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
          choiceChipLabel: (item) {
            /// Used to print text on chip
            return item!.name;
          },
          // choiceChipBuilder: (context, item, isSelected) {
          //   return Container(
          //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //       color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          //     )),
          //     child: Text(item.name),
          //   );
          // },
          validateSelectedItem: (list, val) {
            ///  identify if item is selected or not
            return list!.contains(val);
          },
          onItemSearch: (Category, query) {
            /// When search query change in search bar then this method will be called
            ///
            /// Check if items contains query
            return Category.name!.toLowerCase().contains(query.toLowerCase());
          },
        ),
      ),

      //ADD NEW LAYER BUTTON
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   label: const Text('Add Layer'),
      //   icon: const Icon(Icons.create),
      //   splashColor: Colors.white38,
      //   backgroundColor: Colors.pink,
      // ),
    );
  }
}

class Category {
  final String? name;
  final String? avatar;
  Category({this.name, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<Category> CategoryList = [
  Category(name: "Abigail", avatar: "Category.png"),
  Category(name: "Audrey", avatar: "Category.png"),
  Category(name: "Ava", avatar: "Category.png"),
  Category(name: "Bella", avatar: "Category.png"),
  Category(name: "Bernadette", avatar: "Category.png"),
  Category(name: "Carol", avatar: "Category.png"),
  Category(name: "Claire", avatar: "Category.png"),
  Category(name: "Deirdre", avatar: "Category.png"),
  Category(name: "Donna", avatar: "Category.png"),
  Category(name: "Dorothy", avatar: "Category.png"),
  Category(name: "Faith", avatar: "Category.png"),
  Category(name: "Gabrielle", avatar: "Category.png"),
  Category(name: "Grace", avatar: "Category.png"),
  Category(name: "Hannah", avatar: "Category.png"),
  Category(name: "Heather", avatar: "Category.png"),
  Category(name: "Irene", avatar: "Category.png"),
  Category(name: "Jan", avatar: "Category.png"),
  Category(name: "Jane", avatar: "Category.png"),
  Category(name: "Julia", avatar: "Category.png"),
  Category(name: "Kylie", avatar: "Category.png"),
  Category(name: "Lauren", avatar: "Category.png"),
  Category(name: "Leah", avatar: "Category.png"),
  Category(name: "Lisa", avatar: "Category.png"),
  Category(name: "Melanie", avatar: "Category.png"),
  Category(name: "Natalie", avatar: "Category.png"),
  Category(name: "Olivia", avatar: "Category.png"),
  Category(name: "Penelope", avatar: "Category.png"),
  Category(name: "Rachel", avatar: "Category.png"),
  Category(name: "Ruth", avatar: "Category.png"),
  Category(name: "Sally", avatar: "Category.png"),
  Category(name: "Samantha", avatar: "Category.png"),
  Category(name: "Sarah", avatar: "Category.png"),
  Category(name: "Theresa", avatar: "Category.png"),
  Category(name: "Una", avatar: "Category.png"),
  Category(name: "Vanessa", avatar: "Category.png"),
  Category(name: "Victoria", avatar: "Category.png"),
  Category(name: "Wanda", avatar: "Category.png"),
  Category(name: "Wendy", avatar: "Category.png"),
  Category(name: "Yvonne", avatar: "Category.png"),
  Category(name: "Zoe", avatar: "Category.png"),
];
