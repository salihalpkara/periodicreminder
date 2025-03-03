import 'package:flutter/material.dart';
import 'LocalNotifyManager.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

var baslik;
var icerik;
var sure;

final baslikCon = TextEditingController();
final icerikCon = TextEditingController();
final sureCon = TextEditingController();

class TestNotifyScreen extends StatefulWidget {
  @override
  _TestNotifyScreenState createState() => _TestNotifyScreenState();
}

class _TestNotifyScreenState extends State<TestNotifyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print("Notification Received: ${notification.id}");
  }

  onNotificationClick(String payload) async {
    await LaunchApp.openApp(
        androidPackageName: "com.stormgain.mobile",
        iosUrlScheme: "stormgain://",
        openStore: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            "Periyodik Hatırlatma Servisi",
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 8.0, 9.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: baslikCon,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(36, 0, 216, 101),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: "Bildirimin başlığı ne olsun?",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(250, 0, 216, 101))),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: icerikCon,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(36, 0, 216, 101),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: "Bildirimin içeriği ne olsun?",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(250, 0, 216, 101))),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
                child: TextField(
                  controller: sureCon,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(36, 0, 216, 101),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: "Kaç dakika sonra hatırlatayım?",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(250, 0, 216, 101))),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 120,
                      height: 38,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(250, 0, 216, 101),
                        ),
                        onPressed: () {
                          setState(() {
                            baslik = baslikCon.text != ""
                                ? baslikCon.text
                                : "Periyodik Hatırlatma Servisi";
                            icerik = icerikCon.text != ""
                                ? icerikCon.text
                                : "Yapman gereken bir iş var!";
                            sure = sureCon.text != "" ? sureCon.text : "240";
                          });
                        },
                        child: Text(
                          "Bilgileri Kaydet",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Container(),
                height: 20,
              ),
              SizedBox(
                width: 120,
                height: 38,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(250, 0, 216, 101),
                  ),
                  onPressed: () async {
                    // await localNotifyManager.showNotification();
                    await localNotifyManager.showscheduleNotification();
                    await localNotifyManager.showNotification();
                  },
                  child: Text(
                    "Gönder",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (baslik != null && icerik != null && sure != null)
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.grey, height: 1.4),
                            children: [
                          TextSpan(text: "Bildirimin başlığı, "),
                          TextSpan(
                            text: "${baslik}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(250, 0, 216, 101)),
                          ),
                          TextSpan(text: ";\n"),
                          TextSpan(text: "içeriği, "),
                          TextSpan(
                            text: "${icerik}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(250, 0, 216, 101)),
                          ),
                          TextSpan(text: " olarak ayarlandı.\n"),
                          TextSpan(text: "Bildirim "),
                          TextSpan(
                            text: "${sure}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(250, 0, 216, 101)),
                          ),
                          TextSpan(text: " dakika sonra gönderilecek.\n"),
                        ]))
                ],
              ),
              SizedBox(
                width: 130,
                height: 38,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(250, 0, 216, 101),
                  ),
                  onPressed: () async {
                    await LaunchApp.openApp(
                        androidPackageName: "com.stormgain.mobile",
                        iosUrlScheme: "stormgain://",
                        openStore: false);
                  },
                  child: Text(
                    "Uygulamayı aç",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
