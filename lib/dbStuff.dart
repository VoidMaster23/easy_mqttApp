import 'package:mongo_dart/mongo_dart.dart';

class dbStuff {
  static String url;
  static String brokerAddr;

  static void getUrl() async {
    var db = Db(
        "mongodb://edson23:IeatPie321now@easymqttremote-shard-00-00.bev3o.mongodb.net:27017,easymqttremote-shard-00-01.bev3o.mongodb.net:27017,easymqttremote-shard-00-02.bev3o.mongodb.net:27017/why?ssl=true&replicaSet=atlas-3ays16-shard-0&authSource=admin&retryWrites=true&w=majority");
    await db.open();
    var collection = db.collection('liveBroker');
    // Use the Object ID of your broker
    await collection
        .findOne(where
            .id(ObjectId.parse("5f949ab4fb9cb4424f5f770a"))) // EDIT THIS PLS
        .then((broker) {
      url = broker["URL"];
      brokerAddr = broker["Broker"];
      print("Connected to broker @ $brokerAddr");
      print("Using URL $url");
    });
  }
}
