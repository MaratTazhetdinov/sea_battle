part of '../settings_part.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.l10n;
    final items = L10n.languages;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locale.language),
                      DropdownButton<Locale>(
                          value: state.locale,
                          items: items.entries
                              .map(
                                (entry) => DropdownMenuItem<Locale>(
                                  value: entry.value,
                                  child: Text(entry.key),
                                ),
                              )
                              .toList(),
                          onChanged: (locale) {
                            if (locale case final loc?) {
                              context.readSettingsBloc.add(LocaleSet(loc));
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locale.theme),
                      DropdownButton<ThemeStyle>(
                          value: state.theme,
                          items: ThemeStyle.values
                              .map(
                                (theme) => DropdownMenuItem<ThemeStyle>(
                                  value: theme,
                                  child: Text(switch (theme) {
                                    ThemeStyle.light => locale.light,
                                    ThemeStyle.dark => locale.dark,
                                  }),
                                ),
                              )
                              .toList(),
                          onChanged: (theme) {
                            if (theme case final th?) {
                              context.readSettingsBloc.add(ThemeSet(th));
                            }
                          }),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
