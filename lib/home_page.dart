import 'package:flutter/material.dart';
import 'package:xo/game_logic.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String activeplayer = 'X';
  bool gameover = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
                activeColor: const Color(0xfffee440),
                title: const Text(
                  'Two players',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                value: isSwitched,
                onChanged: (bool newvalue) {
                  setState(() {
                    isSwitched = newvalue;
                  });
                }),
            Text(
              "It's $activeplayer turn",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 55,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                    crossAxisCount: 3,
                    children: List.generate(
                        9,
                        (index) => InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: gameover ? null : () => _onTap(index),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Center(
                                  child: Text(
                                    Player.playerX.contains(index)
                                        ? 'X'
                                        : Player.playerO.contains(index)
                                            ? 'O'
                                            : '',
                                    style: TextStyle(
                                        color: Player.playerX.contains(index)
                                            ? Colors.red
                                            : Colors.black,
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )))),
            Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playerX = [];
                  Player.playerO = [];
                  activeplayer = 'X';
                  gameover = false;
                  turn = 0;
                  result = '';
                });
              },
              icon: const Icon(
                Icons.restart_alt_sharp,
                color: Color(0xff141738),
                size: 30,
              ),
              label: const Text(
                'Restart',
                style: TextStyle(color: Color(0xff141738), fontSize: 25),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor)),
            )
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGAme(index, activeplayer);
      update();
      if (!isSwitched && !gameover && turn!=9 ) {
        await game.autoPlay(activeplayer);
        update();
      }
    }
  }

  void update() {
    setState(() {

      activeplayer = (activeplayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerplayer =game.checkwinner();
      if(turn==9 && !gameover && winnerplayer ==''){
        result = 'it\'s Draw !';
      }
      else if (winnerplayer !=''){
        gameover = true;
        result='$winnerplayer is the winner';


      }
    });
  }
}
