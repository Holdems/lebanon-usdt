import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var _values = RangeValues(0, 5);
  final _labels = [10,100,1000,10000,100000,9999999];

  //1000000

  static final RangeThumbSelector _customRangeThumbSelector = (
    TextDirection textDirection,
    RangeValues values,
    double tapValue,
    Size thumbSize,
    Size trackSize,
    double dx,
  ) {
    final double start = (tapValue - values.start).abs();
    final double end = (tapValue - values.end).abs();
    return start < end ? Thumb.start : Thumb.end;
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(thumbSelector: _customRangeThumbSelector),
            child: RangeSlider(
              divisions: 6,
                labels: RangeLabels(_labels[0].toString(), _values.end.toString()),
                values: _values,
                min: 0,
                max: 5,
                onChanged: (RangeValues values) {
                  setState(() {
                    // if (values.end - values.start >= 20) {
                    //   _values = values;
                    // } else {
                    //   if (_values.start == values.start) {
                    //     _values = RangeValues(_values.start, _values.start + 20);
                    //   } else {
                    //     _values = RangeValues(_values.end - 20, _values.end);
                    //   }
                    // }
                    _values = values;
                  });
                }),
          )
        ],
      ),
    );
  }
}
