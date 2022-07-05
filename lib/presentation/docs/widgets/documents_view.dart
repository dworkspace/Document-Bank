import 'package:flutter/cupertino.dart';

class DocumentsView extends StatefulWidget {
  const DocumentsView({Key? key}) : super(key: key);

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 1.2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/citizenship_front.png",
              fit: BoxFit.cover,
              height: 100.0,
            ),
          ),
        );
      },
    );
  }
}
