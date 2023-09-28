import 'package:flutter/material.dart';
import 'package:notprojem/ana_ekran.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Center(
              child: Text('Faith Notes',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),),
            ),

          ),
        ),
      ),
      backgroundColor: const Color(0xFF036249),

      body:

      Container(
          constraints: const BoxConstraints.expand(),

          child: Column(
              children:<Widget>
              [
                const SizedBox(
                  width: 200.0,
                  height: 160.0,
                ),
                const Center(
                  child:

                  Text('Faith Notes\'a Hoşgeldiniz', textAlign: TextAlign.center, style:
                  TextStyle(fontFamily:'Pacifico',fontSize: 40,)),),

                const SizedBox(
                  width: 50.0,
                  height: 50.0,
                ),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround ,//rowdaki verilerin boşluklu olarak sıralanmasını sağlar.
                  crossAxisAlignment:CrossAxisAlignment.center,// rowdaki verileri yatayda nasıl duracağını ayarladım.

                  children:[
                    ElevatedButton(onPressed:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AnaEkran()),);

                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      child:
                        const Text('Notlarım', style:
                        TextStyle(fontFamily:'Pacifico',fontSize: 20)),),],),
              ]
          )
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height= size.height;
    double width= size.width;

    var path= Path();
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}
