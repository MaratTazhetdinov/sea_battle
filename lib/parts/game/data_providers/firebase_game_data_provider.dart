part of '../game_part.dart';

class FirebaseGameDataProvider extends IGameDataProvider {
  final DatabaseReference firebaseDatabaseReference;

  FirebaseGameDataProvider({required this.firebaseDatabaseReference});

  static const path = 'games';

  @override
  Stream<DtoGame> get dtoGame => firebaseDatabaseReference
      .child('path')
      .onChildChanged
      .map((event) => DtoGame());

  @override
  void giveUp() {
    // TODO: implement giveUp
    FirebaseDatabase.instance.ref();
  }

  @override
  void shoot() {
    // TODO: implement shoot
  }

  @override
  void startGame() {
    // TODO: implement startGame
  }
}
