import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../game/logic/game_cubit.dart';
import '../../game/ui/game_screen.dart';

class LobbyScreen extends HookWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: "Player 1");
    // Randomize room default for quick testing
    final roomController = useTextEditingController(text: "room_1");

    return Scaffold(
      appBar: AppBar(title: const Text('Zevenslag Lobby')),
      body: BlocConsumer<GameCubit, GameUiState>(
        listener: (context, state) {
          if (state is GameActive) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const GameScreen()));
          }
          if (state is GameError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is GameConnecting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome to Zevenslag",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Your Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: roomController,
                      decoration: const InputDecoration(
                        labelText: "Room ID",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: () {
                        context.read<GameCubit>().connect(
                          roomController.text.trim(),
                          nameController.text.trim(),
                        );
                      },
                      child: const Text("Enter Room"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
