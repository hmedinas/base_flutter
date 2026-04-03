import 'package:flutter/material.dart';

class CardContainerWidget extends StatelessWidget {
        final Widget child;
    const CardContainerWidget({super.key, required this.child });

    @override
    Widget build(BuildContext context) {
        return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: _createCardShape(),
                child: this.child,
            ),
            );
    }
    // MEtodo
    BoxDecoration _createCardShape() {
            return BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: Offset(0,0)
                    )
                ]
                
        );
    }
}