import 'package:equatable/equatable.dart';

class SplashPageData extends Equatable {
  final String image;
  final String text;
  final String step;

  SplashPageData({this.image, this.text, this.step});

  @override
  List<Object> get props => [this.image,this.text, this.step];
}
