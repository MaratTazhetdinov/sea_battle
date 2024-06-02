import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:boilerplate_annotations/boilerplate_annotations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_battle/code_kit/code_kit_part.dart';
import 'package:sea_battle/l10n/l10n.dart';
import 'package:sea_battle/parts/auth/auth_part.dart';
import 'package:sea_battle/parts/game_board/game_board_part.dart';
import 'package:sea_battle/parts/game_session/game_session_part.dart';
import 'package:sea_battle/parts/router/router_part.gr.dart';
import 'package:sea_battle/parts/ship/ship_part.dart';
import 'package:sea_battle/ui_kit/ui_kit_part.dart';

part 'screens/ships_alignment_screen.dart';
part 'widgets/ship_picker_widget.dart';
part 'widgets/alignment_board_widget.dart';
part 'widgets/ship_widget.dart';
part 'models/draggable_ship.dart';
part 'bloc/ships_alignment_bloc.dart';
part 'bloc/ships_alignment_event.dart';
part 'bloc/ships_alignment_state.dart';
part 'models/ship_counter.dart';
part 'logic/ships_alignment_logic.dart';
part 'ships_alignment_part.g.dart';
