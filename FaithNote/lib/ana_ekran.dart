import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notprojem/kutular/kutular.dart';
import 'package:notprojem/main.dart';
import 'package:notprojem/modeller/not_modeli.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {

  final baslikKontrol = TextEditingController();
  final aciklamaKontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F3130),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF036249),
            child: Center(
              child: Text('Faith Notes',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,

      body: ValueListenableBuilder<Box<NotModeli>>(
        valueListenable: Kutular.getData().listenable(),
        builder: (context, box, _){
          var data = box.values.toList().cast<NotModeli>();
          return ListView.builder(
              itemCount: box.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Card(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data[index].baslik.toString() , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            Spacer(),
                            InkWell(
                                onTap: (){
                                  delete(data[index]);
                                },
                                child: Icon(Icons.delete, color: Colors.red,)),
                            SizedBox(width: 20,),
                            InkWell(
                                onTap: (){
                                  _diyalogDuzelt(data[index], data[index].baslik.toString(), data[index].aciklama.toString());
                                },
                                child: Icon(Icons.edit, color: const Color(0xFF036249),))
                          ],
                        ),
                        Text(data[index].aciklama.toString() , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            _diyalogGoster();
          },
      child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotModeli notModeli)async{
    await notModeli.delete();
  }

  Future<void> _diyalogDuzelt(NotModeli notModeli , String baslik, String aciklama)async{

    baslikKontrol.text = baslik;
    aciklamaKontrol.text = aciklama;
    return showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            title:  Text("Not Düzenle"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: baslikKontrol,
                    decoration: InputDecoration(
                        hintText: 'Başlık Giriniz..',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: aciklamaKontrol,
                    decoration: InputDecoration(
                        hintText: 'Notunuzu Giriniz..',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Kapat")),

              TextButton(onPressed: ()async{
                notModeli.baslik = baslikKontrol.text.toString();
                notModeli.aciklama = aciklamaKontrol.text.toString();

                notModeli.save();

                baslikKontrol.clear();
                aciklamaKontrol.clear();

                // kutu.
                Navigator.pop(context);
              }, child: Text("Düzelt")),
            ],
          );
        }
    );
  }

  Future<void> _diyalogGoster()async{

    return showDialog(
      context: context,
      builder:(context){
        return AlertDialog(
          title:  Text("Not Ekle"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: baslikKontrol,
                  decoration: InputDecoration(
                    hintText: 'Başlık Giriniz..',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: aciklamaKontrol,
                  decoration: InputDecoration(
                      hintText: 'Notunuzu Giriniz..',
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Kapat")),

            TextButton(onPressed: (){
              final veri = NotModeli(baslik: baslikKontrol.text,
                  aciklama: aciklamaKontrol.text);

              final kutu = Kutular.getData();
              kutu.add(veri);
              veri.save();

              print(kutu);
              baslikKontrol.clear();

              aciklamaKontrol.clear();
              // kutu.
              Navigator.pop(context);
            }, child: Text("Ekle")),
          ],
        );
      }
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
