import 'package:flutter/material.dart';
import 'package:resty/services/products_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST'),
      ),
      body: FutureBuilder(
        future: ProductsService.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('${snapshot.data[index]['name']}'),
                  subtitle: Text('${snapshot.data[index]['cost']}'),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length,
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
