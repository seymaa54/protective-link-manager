import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ble_app/login_screen.dart';


//SplashScreen'ın durumunu tutan ve
// animasyonlarla ilgilenen bir sınıftır.
class SplashScreen extends StatefulWidget {
  static const String routeName='/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
 /* SingleTickerProviderStateMixin: Animasyon kontrolcüsünün nasıl
  sağlanacağını belirleyen bir mixin (katmanlama) sınıfıdır.
  */
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamed(context, LoginScreen.routeName);
      }
    });
  }
  /*
  initState(): Stateful widget'ın durumu başlatıldığında çalışan bir metoddur.
SystemChrome.setEnabledSystemUIMode: Uygulama arayüz modunu belirler (bu durumda tam ekran immersive modunu açar).
AnimationController: Bir animasyon kontrolcüsü oluşturur.
_animation: Başlangıçtan bitişe kadar olan bir sayı dizisindeki değerleri içeren bir animasyon nesnesi.
_controller.forward(): Animasyonu başlatır.
_controller.addStatusListener: Animasyon durumunu dinler ve tamamlandığında belirtilen sayfa (LoginScreen) rotasına yönlendirir
   */

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose(); // super.dispose() ekledik
  }
/*
initState(): Stateful widget'ın durumu başlatıldığında çalışan bir metoddur.
SystemChrome.setEnabledSystemUIMode: Uygulama arayüz modunu belirler (bu durumda tam ekran immersive modunu açar).
AnimationController: Bir animasyon kontrolcüsü oluşturur.
_animation: Başlangıçtan bitişe kadar olan bir sayı dizisindeki değerleri içeren bir animasyon nesnesi.
_controller.forward(): Animasyonu başlatır.
_controller.addStatusListener: Animasyon durumunu dinler ve tamamlandığında belirtilen sayfa (LoginScreen) rotasına yönlendirir
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.pink, Colors.yellow,Colors.black54],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter BLE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 40,
                ),
              ),
              Icon(Icons.bluetooth_audio,color: Colors.black54,
              size: 80,),
            ],
          ),
        ),
      ),
    );
  }
}


