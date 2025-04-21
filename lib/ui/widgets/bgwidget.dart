import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../tools/screen_size.dart';

class Bgwidget extends StatelessWidget {
  Widget childwid;
   Bgwidget({super.key,required this.childwid});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Assets.images.bgbottomcurved.image(fit: BoxFit.fill,
                  height: ScreenSize.getheight(577),
                  width: ScreenSize.getWidth(360)),
            ),
            AppBar(
              centerTitle: true,
              leading: null,
              backgroundColor: Colors.transparent,
              title: Text("KESCO Bill Fetch",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
              actions: [

              ],

            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              height: ScreenSize.height-85,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: MediaQuery.of(context).size.height - 85,
              ),
            ),
            Positioned(

                left: 0,
                right: 0,
                bottom: -104,
                child: Assets.images.bgelectric.image(
                    width:ScreenSize.width,
                    height: ScreenSize.height-45,
                    fit: BoxFit.cover
                )),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              height: ScreenSize.height-85,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x00ffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: MediaQuery.of(context).size.height - 85,
                child: childwid,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
