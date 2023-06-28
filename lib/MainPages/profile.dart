import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todosapp/Provider/todosprovider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final todosProvider = Provider.of<TodoProvider>(context);
    int sliderValue = todosProvider.finishedTodos.length;
    int maxSliderValue = todosProvider.originalTodos.length;
    int unfinished = todosProvider.unfinishedTodos.length;
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              "Hendry Linata",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Task finished: $sliderValue',
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final stuff in todosProvider.stuff)
                Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.316,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(stuff.label,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        Text(
                          '${todosProvider.doneNumber(stuff.label)}',
                          style: TextStyle(color: stuff.color, fontSize: 60),
                        ),
                        const Text('Finished',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SliderTheme(
                  data: const SliderThemeData(
                    thumbShape: RoundSliderThumbShape(disabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                    disabledActiveTrackColor: Colors.green,
                    disabledInactiveTrackColor: Colors.grey,
                  ),
                  child: Slider(
                      min: 0,
                      max: maxSliderValue.toDouble(),
                      value: sliderValue.toDouble(),
                      onChanged: null),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  unfinished == 0
                      ? 'All tasks done'
                      : 'You still have $unfinished task(s) to do',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
