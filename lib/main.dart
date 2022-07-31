import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(

        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;// x axis
  double y = 0.0;// y axis
  double oldx =0.0,oldy=0.0;
  var oldtime  =DateTime.now();
  var newtime = DateTime.now();
  double speed = 0.0;
  double oldspeed = 0.0;
  double acss = 0.0; //Acceleration


  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    //oldtime = newtime;

    setState(() {
      x = details.position.dx;
      y = details.position.dy;
      newtime = DateTime.now();
      if((newtime.millisecond-oldtime.millisecond).abs()>=1) {
        // calc speed
        speed = ((oldx - x).abs()*(oldx - x).abs() + (oldy - y).abs()*(oldy - y).abs()) ;
        speed = sqrt(speed);

         speed = speed   / (oldtime.millisecond - newtime.millisecond).abs();

         acss = (speed-oldspeed) /(oldtime.millisecond - newtime.millisecond).abs();
         oldspeed = speed;
        oldtime= newtime;
        oldx = x;
        oldy = y;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.maxFinite, double.maxFinite)),
      child: MouseRegion(
        onEnter: _incrementEnter,
        onHover: _updateLocation,
        onExit: _incrementExit,
        child: Container(
          color: Colors.lightBlueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // x axis
              SfRadialGauge(
                  enableLoadingAnimation: true, animationDuration: 2000,
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0,maximum: 1000,

                      ranges: <GaugeRange>[
                        GaugeRange(startValue: 0,endValue: 250,color: Colors.blue,startWidth: 0,endWidth: 2.5,),
                        GaugeRange(startValue: 250,endValue: 500,color: Colors.green,startWidth: 2.5,endWidth: 5),
                        GaugeRange(startValue: 500,endValue: 750,color: Colors.orange,startWidth: 5,endWidth: 7.5),
                        GaugeRange(startValue: 750,endValue: 1000,color: Colors.red,startWidth: 7.5,endWidth: 10)],
                      pointers: <GaugePointer>[NeedlePointer(value:x, )],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(widget: Container(child:
                        Text(x.toStringAsFixed(2)+'X' ,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                            angle: x,positionFactor: 0.5)],
                      onAxisTapped: (dynamic value) {
                        setState(() {
                          x = value;
                        });
                      },
                    )]

              ),
              // y axis
              SfRadialGauge(

                  enableLoadingAnimation: true, animationDuration: 2000,
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0,maximum: 1000,

                      ranges: <GaugeRange>[
                        GaugeRange(startValue: 0,endValue: 250,color: Colors.blue,startWidth: 0,endWidth: 2.5,),
                        GaugeRange(startValue: 250,endValue: 500,color: Colors.green,startWidth: 2.5,endWidth: 5),
                        GaugeRange(startValue: 500,endValue: 750,color: Colors.orange,startWidth: 5,endWidth: 7.5),
                        GaugeRange(startValue: 750,endValue: 1000,color: Colors.red,startWidth: 7.5,endWidth: 10)],
                      pointers: <GaugePointer>[NeedlePointer(value:y, )],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(widget: Container(child:
                        Text(y.toStringAsFixed(2)+'Y' ,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                            angle: y,positionFactor: 0.5)],
                      onAxisTapped: (dynamic value) {
                        setState(() {
                          y = value;
                        });
                      },
                    )]

              ),
              // speed and Acceleration
              Column(
                children: [
                  // speed
                  SfRadialGauge(

                      enableLoadingAnimation: true, animationDuration: 2000,
                      axes: <RadialAxis>[
                        RadialAxis(minimum: 0,maximum: 50,

                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0,endValue: 35,color: Colors.blue,startWidth: 0,endWidth: 2.5,),
                            GaugeRange(startValue: 35,endValue: 75,color: Colors.green,startWidth: 2.5,endWidth: 5),
                            GaugeRange(startValue: 75,endValue: 122,color: Colors.orange,startWidth: 5,endWidth: 7.5),
                            GaugeRange(startValue: 122,endValue: 150,color: Colors.red,startWidth: 7.5,endWidth: 10)],
                          pointers: <GaugePointer>[NeedlePointer(value:speed, )],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text(speed.toStringAsFixed(2)+'px/ms' ,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                                angle: speed,positionFactor: 0.5)],
                          onAxisTapped: (dynamic value) {
                            setState(() {
                              speed = value;
                            });
                          },
                        )]

                  ),

                  SfRadialGauge(
                      //Acceleration
                      enableLoadingAnimation: true, animationDuration: 2000,
                      axes: <RadialAxis>[
                        RadialAxis(minimum: -150,maximum: 150,

                          ranges: <GaugeRange>[
                            GaugeRange(startValue: -150,endValue: -75,color: Colors.blue,startWidth: 0,endWidth: 2.5,),
                            GaugeRange(startValue: -75,endValue: 0,color: Colors.green,startWidth: 2.5,endWidth: 5),
                            GaugeRange(startValue: 0,endValue: 75,color: Colors.orange,startWidth: 5,endWidth: 7.5),
                            GaugeRange(startValue: 75,endValue: 150,color: Colors.red,startWidth: 7.5,endWidth: 10)],
                          pointers: <GaugePointer>[NeedlePointer(value:acss, )],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text(acss.toStringAsFixed(2)+'px/ms2' ,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))),
                                angle: acss,positionFactor: 0.5)],
                          onAxisTapped: (dynamic value) {
                            setState(() {
                              acss = value;
                            });
                          },
                        )]

                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
