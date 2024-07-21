import 'package:flutter/material.dart';
import 'package:open_dual_view/open_dual_view.dart';

class PackageListScreen extends StatelessWidget {
  const PackageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: OpenDualView.getAvailablePackagesName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (!snapshot.hasData) {
            return const Text("No Items");
          } else {
            final resultList = snapshot.data!;
            return ListView.builder(
              itemCount: resultList.length,
              itemBuilder: (context, index) {
                final item = resultList[index];
                return ListTile(
                  title: Text(item),
                );
              },
            );
          }
        },
      ),
    );
  }
}
