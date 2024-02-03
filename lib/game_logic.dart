import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension COntainsall on List {
  bool Containsall(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void playGAme(int index, String activeplayer) {
    if (activeplayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  checkwinner() {
    String winner = '';

    if (Player.playerX.Containsall(0, 1, 2) ||
        Player.playerX.Containsall(3, 4, 5) ||
        Player.playerX.Containsall(6, 7, 8) ||
        Player.playerX.Containsall(0, 3, 6) ||
        Player.playerX.Containsall(1, 4, 7) ||
        Player.playerX.Containsall(2, 5, 8) ||
        Player.playerX.Containsall(0, 4, 8) ||
        Player.playerX.Containsall(2, 4, 6) ) {
      winner='X';
    }
    else if (Player.playerO.Containsall(0, 1, 2) ||
        Player.playerO.Containsall(3, 4, 5) ||
        Player.playerO.Containsall(6, 7, 8) ||
        Player.playerO.Containsall(0, 3, 6) ||
        Player.playerO.Containsall(1, 4, 7) ||
        Player.playerO.Containsall(2, 5, 8) ||
        Player.playerO.Containsall(0, 4, 8) ||
        Player.playerO.Containsall(2, 4, 6) ) {
      winner='O';
    }
    else {
      winner='';
    }
    return winner;

  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptycells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptycells.add(i);
      }
    }
    Random random = Random();
    int randomindex = random.nextInt(emptycells.length);
    index = emptycells[randomindex];
    playGAme(index, activePlayer);
  }
}
