import 'package:mongo_dart/mongo_dart.dart';

/// Class that handles the single direct Database ineraction
class dbStuff {
  static String url;
  static String brokerAddr;

  ///Async method to get the URL of the broker
  static void getUrl() async {
    var db = Db("YOUR DB CONNECTION STRING HERE");
    await db.open();
    var collection = db.collection('liveBroker');
    // Use the Object ID of your broker
    await collection
        .findOne(where
            .id(ObjectId.parse("YOUR BROKER ENTRY ID HERE"))) // EDIT THIS PLS
        .then((broker) {
      url = broker["URL"];
      brokerAddr = broker["Broker"];
      print("Connected to broker @ $brokerAddr");
      print("Using URL $url");
    });
  }
}
