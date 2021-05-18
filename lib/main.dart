import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:pets_app/api.dart';
import 'package:pets_app/pet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  List pets = new List<Pet>();
  int imgIndex = 0;
  @override
  void initState(){
    super.initState();
    setState((){
      imgIndex = imgIndex < pets.length - 1 ? imgIndex + 1 : imgIndex;
    });
  }
  void _prevImg() {
    setState(() {
     // imgIndex = imgIndex > 0 ? imgIndex - 1 : 0;
    });
  }

  void _nextImg() {
    setState(() {
     //imgIndex = imgIndex < pets.length - 1 ? imgIndex + 1 : imgIndex;
    });
  }

  _getPets() {
    API.getPets().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        pets = list.map((model) => Pet.fromJson(model)).toList();
      });
    });
  }

  _BuildListViewState() {
    _getPets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Pets"),
        ),
        body: getBody());
  }

  listPetsName() {
    return ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pets[index].picture),
          );
        });
  }


  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
    child:  Container(
      height: size.height,
      child: TinderSwapCard(
        totalNum: 10,
        maxWidth: size.width,
        maxHeight: size.height * 0.75,
        minWidth: size.width * 0.75,
        minHeight: size.height * 0.6,
          cardBuilder:(context, index) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [ 
            BoxShadow( 
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2)
         ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              width:  size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(pets[index].picture),
                fit: BoxFit.cover)
              ),),
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors:[
                    Colors.black.withOpacity(0.15),
                    Colors.blue.withOpacity(0)
                  ],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter)),
                  child: Column(children: [
                    Row(children: [
                      Container(
                        width: size.width * 0.72,
                        child: Column(children: [
                          Row(children: [
                             //Text(data)
                          ],)
                        ],)
                      )
                    ],)
                  ],),

              ),
          ],
        ), 
      ), 
      ), ),
    ),
    );
  }
  // listaPets() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(
  //           pets[imgIndex].name + " | " + pets[imgIndex].price.toString(),
  //           style: TextStyle(fontSize: 20.0),
  //         ),
  //       ),
  //       Center(
  //         child: Stack(children: <Widget>[
  //           Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(25.0),
  //                 image: DecorationImage(
  //                     image: NetworkImage(pets[imgIndex].picture),
  //                     fit: BoxFit.cover)),
  //             height: 400.0,
  //             width: 300.0,
  //           )
  //         ]),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           RaisedButton(
  //             child: Text('Prev'),
  //             onPressed: _prevImg,
  //             elevation: 5.0,
  //             color: Colors.green,
  //           ),
  //           SizedBox(width: 10.0),
  //           RaisedButton(
  //             child: Text('Next'),
  //             onPressed: _nextImg,
  //             elevation: 5.0,
  //             color: Colors.blue,
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }
}
