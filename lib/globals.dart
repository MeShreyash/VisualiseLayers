import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapsapp/globals.dart';
import 'package:flutter/material.dart';

import 'components/filter.dart';

Map<String, Set<Marker>> categoryMarker = {};
List<Category>? selectedCategoryList = [];
