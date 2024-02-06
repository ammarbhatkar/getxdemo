import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:getxdemo/getx_apna_tution/chapter3_statemanagemt/movie_model.dart';

class MyMovie extends StatelessWidget {
  MyMovie({super.key});
  var movie = Movie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text("${movie.name}"),
            ),
            ElevatedButton(
              onPressed: () {
                movie.name.value = "vivek";
              },
              child: Text("icrement"),
            ),
          ],
        ),
      ),
    );
  }
}
