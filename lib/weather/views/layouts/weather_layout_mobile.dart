import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherLayoutMobile extends StatelessWidget {
  const WeatherLayoutMobile({super.key});

  @override
  Widget build(BuildContext context) {
    //WeatherCubit weatherCubit = context.read<WeatherCubit>();

    // The state is reevaluated every minute. This is to allow refresh rate
    // to be calculated based on timer constants.
    const ticksPerMinute = (60 / TimerBloc.defaultDuration);

    return SafeArea(
      child: BlocConsumer<TimerBloc, TimerState>(
          buildWhen: (previous, current) =>
              (previous.duration % ticksPerMinute == 0) ||
              (previous is TimerRunPause && current is TimerRunInProgress),
          listener: (timerContext, timerState) {
            TimerBloc timerBloc = timerContext.read<TimerBloc>();
            WeatherCubit weatherCubit = timerContext.read<WeatherCubit>();
            switch (timerState) {
              case TimerInitial _:
                weatherCubit.refreshWeather(current: true);
                timerBloc.add(
                    const TimerStarted(duration: TimerBloc.defaultDuration));

              case TimerRunComplete _:
                if (!weatherCubit.state.autoRefresh) {
                  break; // Break if autoRefresh is disabled.
                }
                timerBloc.add(
                    const TimerStarted(duration: TimerBloc.defaultDuration));
              case TimerRunInProgress _:
                // Each tick is 30 seconds so 2 * 30 = every minute.
                if (timerState.duration % (ticksPerMinute) != 0) {
                  break; // To increase efficiency, check only every new minute
                }
                weatherCubit.handlePeriodicRefresh();
              default:
                break;
            }
          },
          builder: (timerContext, timerState) {
            TimerBloc timerBloc = timerContext.read<TimerBloc>();
            WeatherCubit weatherCubit = timerContext.read<WeatherCubit>();

            final currentWeatherWidget = PullToRefreshCard(
              gradientPreset: GradientPreset.lighten,
              onRefresh: () {
                timerBloc.add(const TimerStarted(duration: defaultDuration));
                return context.read<WeatherCubit>().refreshWeather(all: true);
              },
              child: const CurrentWeatherWidget(),
            );

            const hourlyWeatherWidget = PullToRefreshCard(
              gradientPreset: GradientPreset.lighten,
              child: HourlyForecastWidget(),
            );

            final dailyWeatherWidget = PullToRefreshCard(
              gradientPreset: GradientPreset.lighten,
              child: DailyForecastPopulated(
                forecast: weatherCubit.state.dailyForecast,
                units: weatherCubit.state.temperatureUnits,
              ),
            );

            return _WeatherLayoutMobileView(
                currentWeatherWidget: currentWeatherWidget,
                hourlyWeatherWidget: hourlyWeatherWidget,
                dailyWeatherWidget: dailyWeatherWidget);
          }),
    );
  }
}

class _WeatherLayoutMobileView extends StatelessWidget {
  const _WeatherLayoutMobileView({
    required this.currentWeatherWidget,
    required this.hourlyWeatherWidget,
    required this.dailyWeatherWidget,
  });

  final Widget currentWeatherWidget;
  final Widget hourlyWeatherWidget;
  final Widget dailyWeatherWidget;

  @override
  Widget build(BuildContext context) {
    const cardPadding = EdgeInsets.all(4.0);

    /// Layout :
    /// |---------------------|
    /// |        200px        |
    /// |---------------------|
    /// |        500px        |
    /// |                     |
    /// |---------------------|
    /// |        300px        |
    /// |---------------------|

    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 200,
          child: Padding(padding: cardPadding, child: currentWeatherWidget),
        ),
        SizedBox(
          height: 500,
          child: Padding(padding: cardPadding, child: hourlyWeatherWidget),
        ),
        SizedBox(
          height: 300,
          child: Padding(padding: cardPadding, child: dailyWeatherWidget),
        ),
      ],
    );
  }
}
