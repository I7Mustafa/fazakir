import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);
  static const routeName = '/contact_us';

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  openWhatsApp() async {
    var whatsapp = "01024573438";
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مركز المساعدة")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: FittedBox(
              fit: BoxFit.none,
              child: Image.asset(
                "assets/images/logo.png",
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "مرحبا بك في تطبيق فذكر ، حرصا منا على الاستفادة الكاملة من التطبيق وعدم مواجهة أي مشكلة خلال استخدامك للتطبيق وكذلك لتلقي الاقتراحات لتطوير التطبيق  ، يمكنك ارسال مشكلتك وسيقوم مصمم التطبيق بالرد عليك لحل المشكلة فورا ، نعتذر في حالة تأخر الرد ولكن سنقوم بالرد وحل المشكلة فورا تقبل الله منا ومنكم صالح الاعمال",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () async {
              await openWhatsApp();
            },
            title: Text("اضغط هنا للتواصل معنا "),
            leading: Icon(
              Icons.mail,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}