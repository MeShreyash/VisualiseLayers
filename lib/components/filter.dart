import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Category>? selectedCategoryList = [];

  Future<void> openFilterDelegate() async {
    await FilterListDelegate.show<Category>(
      context: context,
      list: CategoryList,
      selectedListData: selectedCategoryList,
      theme: FilterListDelegateThemeData(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.white,
          selectedColor: Colors.red,
          selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
          textColor: Colors.blue,
        ),
      ),
      // enableOnlySingleSelection: true,
      onItemSearch: (Category, query) {
        return Category.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (Category) => Category!.name,
      emptySearchChild: const Center(child: Text('No Category found')),
      // enableOnlySingleSelection: true,
      searchFieldHint: 'Search Here..',
      suggestionBuilder: (context, Category, isSelected) {
        return ListTile(
          title: Text(Category.name!),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          selected: isSelected,
        );
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedCategoryList = list;
        });
      },
    );
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<Category>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Categories',
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
        title: Text("Choose Categories"),
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
            TextButton(
              onPressed: _openFilterDialog,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Dialog",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
            TextButton(
              onPressed: openFilterDelegate,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Delegate",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
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
    );
  }
}

class Category {
  final String name;
  final String type;
  final String? avatar;
  Category({required this.name, required this.type, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<Category> CategoryList = [
  Category(name: "Restaurant", type: 'restaurant',avatar: 'assets/mapicons/restaurants.png'),
  Category(name: "School", type: 'school',avatar: 'assets/mapicons/schools.png'),
  Category(name: "Hospital", type: 'hospital',avatar: 'assets/mapicons/health-medical.png'),
  Category(name: "Hotels", type: 'lodging',avatar: 'assets/mapicons/hotels.png'),
  Category(name: "Bar", type: 'bar',avatar: 'assets/mapicons/bars.png'),
  Category(name: "Locality", type: 'locality',avatar: 'assets/mapicons/local-services.png'),
];
/// Another example of [FilterListWidget] to filter list of strings
/*
 FilterListWidget<String>(
    listData: [
      "One",
      "Two",
      "Three",
      "Four",
      "five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten"
    ],
    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
    onApplyButtonClick: (list) {
      Navigator.pop(context, list);
    },
    choiceChipLabel: (item) {
      /// Used to print text on chip
      return item;
    },
    validateSelectedItem: (list, val) {
      ///  identify if item is selected or not
      return list!.contains(val);
    },
    onItemSearch: (text, query) {
      return text.toLowerCase().contains(query.toLowerCase());
    },
  )
*/