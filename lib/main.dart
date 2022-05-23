import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_version/src/loading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GithubActions Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SF GithubActions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            }
            final packageInfo = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Version: ${packageInfo.version} Build: ${packageInfo.buildNumber}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      color: const Color(0xFFff5558),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Uploaded from CICD pipeline',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      color: const Color(0xFFff5558),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
