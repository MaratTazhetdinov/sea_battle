part of '../settings_part.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final locale = context.l10n;
    final items = L10n.languages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Language'),
                  DropdownButton<Locale>(
                      value: items['English'],
                      items: items.entries
                          .map(
                            (entry) => DropdownMenuItem<Locale>(
                              value: entry.value,
                              child: Text(entry.key),
                            ),
                          )
                          .toList(),
                      onChanged: (_) {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
