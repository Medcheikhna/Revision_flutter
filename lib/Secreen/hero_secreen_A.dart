import 'package:flutter/material.dart';
import 'package:newtest/Secreen/hero_secreen_B.dart';


import 'package:flutter/material.dart';

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key});


  @override

  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();

}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _animation;

  @override

  void initState() {

    super.initState();

    _controller = AnimationController(

      duration: Duration(seconds: 2), // Set animation duration

      vsync: this, // Provide a ticker provider for animations

    );

    _animation = Tween<double>(

      begin: 0,

      end: 1,

    ).animate(_controller); // Create animation using controller

    // Start the animation

    _controller.forward();

  }

  @override

  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: _animation,

      builder: (context, child) {

        return Opacity(

          opacity: _animation.value,

          child: Container(

            width: 200 * _animation.value,

            height: 200 * _animation.value,

            color: Colors.blue,

            child: Center(

              child: Text(

                'Hello',

                style: TextStyle(

                  fontSize: 24 * _animation.value,

                  color: Colors.white,

                ),

              ),

            ),

          ),

        );

      },

    );

  }

  @override

  void dispose() {

    _controller.dispose(); // Dispose animation controller to release resources

    super.dispose();

  }

}




//=========================================================
// class HeroSecreenA extends StatelessWidget {
//   const HeroSecreenA({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (_) => const HeroScreenB(),
//             ));
//           },
//           child: Hero(
//             tag: 'heroTag',
//             child: Container(
//               width: 100,
//               height: 100,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
