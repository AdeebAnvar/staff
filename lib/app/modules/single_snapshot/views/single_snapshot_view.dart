import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/single_snapshot_controller.dart';

class SingleSnapshotView extends GetView<SingleSnapshotController> {
  const SingleSnapshotView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleSnapshotView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SingleSnapshotView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
