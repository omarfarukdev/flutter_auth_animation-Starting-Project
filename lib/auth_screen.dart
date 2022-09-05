import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
// if we want to show oue sign up then we set is true
   bool _isShowSignup = false;
   late AnimationController _animationController;
   late Animation<double> _animationTextRotate;

   void setUpAnimation(){
     _animationController=AnimationController(vsync: this,duration: defaultDuration);
     _animationTextRotate=Tween<double>(begin: 0,end: 90).animate(_animationController);
   }

   void updateView(){
     setState(() {
       _isShowSignup=!_isShowSignup;
     });
     _isShowSignup? _animationController.forward():_animationController.reverse();
   }

   @override
  void initState() {
    // TODO: implement initState
     setUpAnimation();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //If provide us screen height and width
    final _size= MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              //lets animate the transition
              // login
              AnimatedPositioned(
                duration: defaultDuration,
                // We use 88% width for login
                width: _size.width*0.88, // 88%
                height: _size.height,
                left: _isShowSignup? -_size.width*0.76 : 0,
                child: Container(
                  color: login_bg,
                  child: LoginForm(),
                ),
              ),

              // Sign up
              // Now as you can see the logo and the socal icon are not in center
              AnimatedPositioned(
                duration: defaultDuration,
                height: _size.height,
                width: _size.width*0.88,
                left: _isShowSignup? _size.width*0.12 : _size.width*0.88,
                child: Container(
                  color: signup_bg,
                  child: SignUpForm(),
                ),
              ),


              //lets add the logo
              // As you can see our logo is not on center
              // On sign up form the logo is not in center
              // lets make it
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height*0.1,
                left: 0,
                right: _isShowSignup? _size.width*0.06:_size.width*0.06,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white60,
                  child: AnimatedSwitcher(
                    duration: defaultDuration,
                    child: _isShowSignup? SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: signup_bg,):SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: login_bg,),
                  ),
                ),
              ),

              // Its not center
              // We shift it 6% to rigth because our this signup bar take 12% width
              // Same gose to socal
              //Also lets make it animated
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width,
                bottom: _size.height*0.1, //10%
                right: _isShowSignup? _size.width*0.06:_size.width*0.06, // Now it's center

                child: SocalButtns(),
              ),

              //Login Text
              // Login text bone
              AnimatedPositioned(
                duration: defaultDuration,
                // When our sign up shows we want our login text to left center
                bottom: _isShowSignup? _size.height/2-80:_size.height * 0.3, // 30%
                left: _isShowSignup?0: _size.width * 0.44 - 80,
                // width of out text container is 160 so 160/2 = 80
                // 0.88/2 = 0.44 (Width of our login is 88%)
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSignup?20: 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignup? Colors.white: Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * pi / 180,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){
                        if(_isShowSignup){
                          updateView();
                        }
                        else{
                          // Login
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: defpaultPadding*0.75),
                        width: 160,
                        //color: Colors.red,
                        child: Text("Log In".toUpperCase(),

                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Sign Up Text
              AnimatedPositioned(
                duration: defaultDuration,
                // When our sign up shows we want our login text to left center
                // As you can see Sign up text not on center
                bottom: !_isShowSignup? _size.height/2-80 // now width is ti's height
                    :_size.height * 0.3, // 30%
                right: _isShowSignup?_size.width * 0.44 - 80:0,
                // width of out text container is 160 so 160/2 = 80
                // 0.88/2 = 0.44 (Width of our login is 88%)
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: !_isShowSignup?20: 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignup? Colors.white: Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: (90-_animationTextRotate.value )* pi / 180,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        if(_isShowSignup){
                          // Sign Up
                        }
                        else{
                          updateView();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: defpaultPadding*0.75),
                        width: 160,
                        //color: Colors.red,
                        child: Text("Sing Up".toUpperCase(),

                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
