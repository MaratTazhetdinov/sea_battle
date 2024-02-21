import 'dart:async';

import 'package:boilerplate_annotations/boilerplate_annotations.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sea_battle/code_kit/code_kit_part.dart';
import 'package:sea_battle/l10n/l10n.dart';
import 'package:sea_battle/parts/user/user_part.dart';
import 'package:sea_battle/ui_kit/input_fields/header_text_input_field.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';

part 'bloc/auth_bloc.dart';
part 'bloc/auth_event.dart';
part 'bloc/auth_state.dart';
part 'screens/auth_screen.dart';
part 'repository/i_auth_repository.dart';
part 'repository/auth_repository.dart';
part 'data_provider/i_auth_data_provider.dart';
part 'data_provider/firebase_auth_data_provider.dart';
part 'widgets/sign_in_widget.dart';
part 'widgets/sign_up_widget.dart';
part 'auth_part.g.dart';
