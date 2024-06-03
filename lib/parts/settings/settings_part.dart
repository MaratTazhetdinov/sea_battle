import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_battle/l10n/l10n.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'screens/settings_screen.dart';
part 'bloc/settings_bloc.dart';
part 'bloc/settings_state.dart';
part 'bloc/settings_event.dart';
part 'data_providers/i_settings_data_provider.dart';
part 'data_providers/shared_pref_data_provider.dart';
part 'repositories/i_settings_repository.dart';
part 'repositories/settings_repository.dart';
