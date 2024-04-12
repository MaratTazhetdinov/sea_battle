import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:boilerplate_annotations/boilerplate_annotations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_battle/parts/game_board/game_board_part.dart';

part 'data_providers/i_game_session_data_provider.dart';
part 'data_providers/fb_db_game_session_data_provider.dart';
part 'models/game_session.dart';
part 'models/dto/dto_game_session.dart';
part 'screens/game_session_screen.dart';
part 'models/dto/dto_game_board.dart';
part 'repositories/i_game_session_repository.dart';
part 'repositories/game_session_repository.dart';
part 'bloc/game_session_bloc.dart';
part 'bloc/game_session_event.dart';
part 'bloc/game_session_state.dart';

part 'game_session_part.g.dart';
