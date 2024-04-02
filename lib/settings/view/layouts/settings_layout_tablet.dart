import 'package:flutter/material.dart';

// Packages
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project
import 'package:multidisplay/experimental/experimental.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/tracking/tracking.dart';

class SettingsLayoutTablet extends StatelessWidget {
  const SettingsLayoutTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Row(
              children: [
                Spacer(),
                Icon(Icons.person, semanticLabel: 'login_profile'),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text('Login'),
                ),
              ],
            ),
            onTap: () async {},
            /* trailing: const SizedBox(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child:
                    Icon(Icons.login_outlined, semanticLabel: 'login_button'),
              ),
            ),*/
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Home",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return ListTile(
                title: const Text('Match Theme with System Default'),
                isThreeLine: true,
                subtitle: const Text(
                  'Automatically switch theme based on system default',
                ),
                trailing: Switch(
                  value: AdaptiveTheme.of(context).mode.isSystem,
                  onChanged: (value) {
                    if (value) {
                      // Switch to system settings
                      AdaptiveTheme.of(context).setSystem();
                      // Align cubit with the new theme.
                      ThemeData theme = AdaptiveTheme.of(context).theme;
                      context.read<ThemeCubit>().toggleToTheme(theme);
                    } else {
                      // Align cubit with the current theme.
                      ThemeData theme = AdaptiveTheme.of(context).theme;
                      context.read<ThemeCubit>().toggleToTheme(theme);
                      if (state.selectedTheme.isDark) {
                        AdaptiveTheme.of(context).setLight();
                      } else {
                        AdaptiveTheme.of(context).setDark();
                      }
                      context.read<ThemeCubit>().toggleTheme();
                    }
                  },
                ),
              );
            },
          ),
          BlocConsumer<ThemeCubit, ThemeState>(
            listener: (context, state) {
              if (context.read<ThemeCubit>().currentThemeData() !=
                  AdaptiveTheme.of(context).theme) {
                context.read<ThemeCubit>().toggleTheme();
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return ListTile(
                title: const Text('Dark Theme'),
                isThreeLine: true,
                subtitle: const Text(
                  'Toggle between Light Theme and Dark Theme',
                ),
                trailing: Switch(
                  value: state.selectedTheme.isDark,
                  onChanged: (AdaptiveTheme.of(context).mode.isSystem)
                      ? null // Disable if set to system
                      : (switchToDark) {
                          /// If theme is light, themeSwitchToDark is true
                          /// If theme is dark, themeSwitchToDark is false
                          /// state doesn't change between these
                          //final themeSwitchToDark = state.selectedTheme.isLight;

                          /// This value is AFTER the switch has been pressed.
                          /// If isDark was true and then the switch was tapped,
                          /// the user wants to switch to a Light Theme. switchToDark
                          /// will return false (the new value), NOT the value of context.read<ThemeCubit>().isDark;
                          if (switchToDark) {
                            AdaptiveTheme.of(context).setDark();
                          } else {
                            AdaptiveTheme.of(context).setLight();
                          }

                          context.read<ThemeCubit>().toggleTheme();
                        },
                ),
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.clockType != current.clockType,
            builder: (context, state) {
              return ListTile(
                  title: const Text('Use Military Time'),
                  isThreeLine: true,
                  subtitle: const Text(
                    'AM/PM vs Military',
                  ),
                  trailing: Switch(
                      value: state.clockType.isMilitary,
                      onChanged: (_) =>
                          context.read<HomeCubit>().toggleClockType()));
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Weather",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Change City'),
            isThreeLine: true,
            subtitle: const Text(
              'Change City used for weather',
            ),
            onTap: () async {
              final city = await Navigator.of(context).push(SearchPage.route());
              if (!context.mounted) return;
              await context.read<WeatherCubit>().fetchWeather(city);
            },
            trailing: const SizedBox(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Icon(Icons.search, semanticLabel: 'Search'),
              ),
            ),
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) =>
                previous.temperatureUnits != current.temperatureUnits,
            builder: (context, state) {
              return ListTile(
                title: const Text('Temperature Units'),
                isThreeLine: true,
                subtitle: const Text(
                  'Use metric measurements for temperature units.',
                ),
                trailing: Switch(
                  value: state.temperatureUnits.isCelsius,
                  onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
                ),
              );
            },
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) =>
                previous.autoRefresh != current.autoRefresh,
            builder: (context, state) {
              return ListTile(
                title: const Text('Auto Refresh data every 300 seconds'),
                isThreeLine: true,
                subtitle: const Text(
                  'Use metric measurements for temperature units.',
                ),
                trailing: Switch(
                  value: state.autoRefresh,
                  onChanged: (_) =>
                      context.read<WeatherCubit>().toggleAutoRefresh(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Tracking",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<TrackingCubit, TrackingState>(
            buildWhen: (previous, current) =>
                previous.reorderable != current.reorderable,
            builder: (context, state) {
              return ListTile(
                title: const Text('Allow Reordering'),
                isThreeLine: true,
                subtitle: const Text(
                  'Allow Tracking Sections to be reordered',
                ),
                trailing: Switch(
                  value: state.reorderable,
                  onChanged: (_) =>
                      context.read<TrackingCubit>().toggleReorder(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Experimental",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('View Widgets'),
            isThreeLine: true,
            subtitle: const Text(
              'Widget Library',
            ),
            onTap: () async {
              Navigator.of(context).push(ExperimentalPage.route());
            },
            trailing: const SizedBox(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Icon(Icons.widgets, semanticLabel: 'Experimental'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
