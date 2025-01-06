abstract class ImageAssets{
  static final Map<String,String> _images ={
    'icon_google' : 'assets/images/icon_google.png',
  };

  static String getImageAssets(String images){
    return _images[images]!;
  }
}