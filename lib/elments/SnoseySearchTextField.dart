import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/SnoseyLanguages.dart';

class SnoseySearchTextField extends TypeAheadField {
  SnoseySearchTextField({
    required TextEditingController controller,
    required VoidCallback onEditingComplete,
    required Function(String) onChanged,
    required GetStorage storage,
    required String searchKey,
    required InputDecoration inputDecoration,
  }) : super(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: inputDecoration.copyWith(
                prefixIcon: GestureDetector(
                  onTap: () async {
                    if (controller.text.isNotEmpty) {
                      controller.text = "";
                      onChanged("");
                    }
                  },
                  child: Icon(
                    controller.text.isEmpty ? Icons.search : Icons.close,
                    color: Get.theme.colorScheme.onSurface.withOpacity(.5),
                    size: 20,
                  ),
                ),
                hintText: SnoseyLanguagesKeys.searchHint.toString().tr,
              ),
              controller: controller,
              maxLines: 1,
              onSubmitted: (text) {
                if (storage.hasData(searchKey)) {
                  if (text.isNotEmpty) {
                    List<dynamic> recent = storage.read(searchKey)!;
                    if (recent.contains(text)) {
                      recent.remove(text);
                      recent.insert(0, text);
                      if (recent.length > 5) {
                        recent.removeLast();
                      }
                    } else {
                      recent.insert(0, text);
                      if (recent.length > 5) {
                        recent.removeLast();
                      }
                    }
                    storage.write(searchKey, recent);
                    storage.save();
                  } else {
                    controller.text = '';
                  }
                } else {
                  if (text.isNotEmpty) {
                    List<dynamic> recent = [];
                    recent.add(text);
                    storage.write(searchKey, recent);
                    storage.save();
                  }
                }
              },
              onEditingComplete: onEditingComplete,
              onChanged: onChanged,
            ),
            suggestionsCallback: (pattern) {
              if (storage.hasData(searchKey)) {
                List<dynamic> list = storage.read(searchKey);
                return list
                    .where((element) => element.toString().contains(pattern));
              } else
                return [];
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.access_time_rounded),
                title: Text(suggestion as String),
              );
            },
            hideOnEmpty: true,
            hideOnLoading: true,
            onSuggestionSelected: (suggestion) {
              String selected = suggestion as String;
              controller.text = selected;
              if (storage.hasData(searchKey)) {
                List<dynamic> recent = storage.read(searchKey)!;
                if (recent.contains(selected)) {
                  recent.remove(selected);
                  recent.insert(0, selected);
                } else {
                  recent.insert(0, selected);
                  if (recent.length > 5) {
                    recent.removeLast();
                  }
                }
                storage.write(searchKey, recent);
                storage.save();
              }
            });
}
