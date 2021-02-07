import 'package:equatable/equatable.dart';

class SplashPageData extends Equatable {
  final String image;
  final String text;

  SplashPageData({this.image, this.text});

  @override
  List<Object> get props => [this.image,this.text];
}
