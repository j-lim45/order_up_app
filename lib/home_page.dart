import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
  
}


// Returns a container or a listing of a product with info such as product name, price, and quantity
InkWell get containerProduct {
  return InkWell(
    child: Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
      width: 150, height: 150,
      child: Column(
        children: [
          Image.network('https://imartgrocersph.com/wp-content/uploads/2020/09/Chippy-Barbecue-27g.png', width: 80, height: 90,),
          Text("Chippy"),
          Text("P20"),
          Text("HELLo")
      ],)
    )
    , onTap: () => {},
  );
}

  class _AppHomePage extends State<AppHomePage> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // this should work but it doesnt
        home: Scaffold(

          // App Bar
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Hello")
          ),

          // Body of the column of product listings
          body: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    containerProduct,
                    containerProduct
                ],)
              ]
            ,)
          ,)
        )
      );
    }
  }

