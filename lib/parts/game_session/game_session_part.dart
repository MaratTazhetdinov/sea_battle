import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_database/firebase_database.dart';

part 'data_providers/i_game_session_data_provider.dart';
part 'data_providers/firebase_database_game_session_data_provider.dart';
part 'models/game_session.dart';
part 'models/cell.dart';
part 'models/dto/dto_game_session.dart';
part 'screens/game_session_screen.dart';
part 'models/game_board.dart';
part 'models/dto/dto_game_board.dart';
part 'models/dto/dto_cell.dart';

part 'game_session_part.g.dart';
