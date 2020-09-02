import 'dart:async';
import 'package:bloc_pattern/counter_event.dart';

class CounterBloc{
  int _counter = 8;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc(){
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event){
    if (event is DuplicateEvent){
      _counter = _counter * 2;
      _inCounter.add(_counter);
    } 
    else if (event is IncrementEvent){
      _counter ++;
      _inCounter.add(_counter);
    } 
    else if (event is DecrementEvent) {
      _counter --;
      _inCounter.add(_counter);
    }
  }

  void dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }
}