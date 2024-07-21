import 'package:flutter/material.dart';
import 'package:open_dual_view/open_dual_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> packageNameList = [];

  @override
  void initState() {
    super.initState();
    loadPackageNames();
  }

  loadPackageNames() async {
    packageNameList.addAll(await OpenDualView.getAvailablePackagesName());
    if (mounted) {
      setState(() {});
    }
  }

  String t = "Error Will Show here";
  bool isOpen = false;

  setT(String t) {
    setState(() {
      this.t = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Dual View App Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t),
              FilledButton(
                onPressed: () async {
                  final result = await OpenDualView.openInDualView(
                    packageName: 'com.google.android.apps.maps',
                  );
                  if (result.result) {
                    setT('OK');
                  } else {
                    setT(result.message ?? "Error");
                  }
                },
                child: const Text('Open Google Map'),
              ),
              FilledButton(
                onPressed: () async {
                  final result = await OpenDualView.openInDualView(
                    uri: 'google.streetview:cbll=46.414382,10.013988',
                  );
                  if (result.result) {
                    setT('OK');
                  } else {
                    setT(result.message ?? "Error");
                  }
                },
                child: const Text('Open Google Map in Street View'),
              ),
              FilledButton(
                onPressed: () async {
                  final result = await OpenDualView.openInDualView(
                    uri: 'https://www.youtube.com/@flutterdev',
                  );
                  if (result.result) {
                    setT('OK');
                  } else {
                    setT(result.message ?? "Error");
                  }
                },
                child: const Text('Open Flutter Youtbe Channel'),
              ),
              FilledButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/packageNameList'),
                child: const Text("Get Package Name List"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
