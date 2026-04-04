
import 'package:hm_flutter_base/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginBackgroundWidget extends StatelessWidget {
    final Widget child;
    const LoginBackgroundWidget({super.key,  required this.child});

    @override
    Widget build(BuildContext context) {
        return Container(
            color: AppTheme.baseTheme.primaryColor,
            width: double.infinity,
            height: double.infinity,
                child: Stack(
                    children: [
                        Positioned(child: _CirculosDecoration(), top: 90,left: 30,),
                        Positioned(child: _CirculosDecoration(), top: 0,left: 200,),
                        Positioned(child: _CirculosDecoration(), top: -50,right: -20,),
                        Positioned(child: _CirculosDecoration(), top: -50,left: 10,),
                        Positioned(child: _CirculosDecoration(), top: 620,right: 20,),

                        _HeaderIcon(),
                        child,
                        
                        
                    ],
                ),
        );
    }
}


class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 30),
            child: Icon( Icons.person_pin, color: Colors.white, size:70),
        )
    );
  }
}

class _CirculosDecoration extends StatelessWidget {
  const _CirculosDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromRGBO(255, 255, 25, 0.05)
        ),
    );
  }
}