import 'package:flutter/material.dart';
import 'package:on_edir/Model/store.dart';
import 'package:on_edir/constants.dart';

class StoreItem extends StatelessWidget {
  Store store;
  StoreItem({Key key,@required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: mainColor,border: Border(bottom: BorderSide(color: secondColor))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.network(store.img_url,width: 120,height: 120,fit: BoxFit.cover,),
              const SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.only(top:15),
                child: Column(children: [
                  Text(store.itemName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  SizedBox(width: 200,child: Text(store.itemDescription)),
                  ],),
              )
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text(store.dateTime,style: TextStyle(fontSize: 13),)],)
            
          ],
        ),
      ),
    );
  }
}
