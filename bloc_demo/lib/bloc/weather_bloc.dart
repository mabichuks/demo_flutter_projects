import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bloc_demo/model/weather.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event,) async* {
    if(event is GetWeather) {
      yield* _mapWeatherLoadingEventToState(event);
      yield* _mapWeatherLoadedEventToState(event);
    }

  }

  Stream<WeatherState> _mapWeatherLoadingEventToState(WeatherEvent event) async* {
    yield WeatherLoading();
  }

  Stream<WeatherState> _mapWeatherLoadedEventToState(WeatherEvent event) async* {

    GetWeather ev = event;

    final weather = await _fetchWeather(ev.cityName);
    yield WeatherLoaded(weather);
  }

  Future<Weather> _fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () => Weather(
      cityName: cityName,
      temperature: 20 + Random().nextInt(15) + Random().nextDouble()
    ));
  }
}
