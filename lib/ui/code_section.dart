import 'package:dart_pad_widget/dart_pad_widget.dart';
import 'package:flutter/material.dart';
import 'package:json2dart_gen/converter/json2dart_gen.dart';

class CodeSection extends StatefulWidget {
  const CodeSection({Key? key}) : super(key: key);

  @override
  State<CodeSection> createState() => _CodeSectionState();
}

class _CodeSectionState extends State<CodeSection> {
  final jsonHintText =
      '{\n  "id": 1,\n  "name": "Ahmet Çelik",\n  "exp": 0.7,\n  "isOnline": true,\n  "account": [\n    {\n    "key": "twitter",\n    "username": "ahm3tcelik72",\n    "createAt": "2018-04-23T18:25:43.511Z"\n    }\n  ],\n  "address": {\n    "country": "Turkey",\n    "city": "Batman"\n  }\n}';

  final classNameController = TextEditingController();
  final jsonController = TextEditingController();

  String codeResult = '';

  @override
  void initState() {
    classNameController.text = 'User';
    jsonController.text = jsonHintText;
    codeResult = Converter.convert('User', jsonHintText);
    super.initState();
  }

  void onClickConvert() {
    if (jsonController.text.trim().isNotEmpty &&
        classNameController.text.trim().isNotEmpty) {
      final code =
          Converter.convert(classNameController.text, jsonController.text);

      setState(() {
        codeResult = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildJsonField(),
                const SizedBox(height: 12),
                _buildClassNameField(),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onClickConvert,
                  child: const Text('Convert'),
                )
              ],
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: _buildEditor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildEditor(BuildContext context) {
    return DartPad(
      key: Key(DateTime.now().toString()),
      embeddingChoice: EmbeddingChoice.inline,
      darkMode: false,
      nullSafety: true,
      runImmediately: false,
      width: MediaQuery.of(context).size.width * .7,
      height: 800,
      code: codeResult,
    );
  }

  TextField _buildClassNameField() {
    return TextField(
      controller: classNameController,
      enableSuggestions: false,
      decoration: const InputDecoration(
        hintText: 'Class Name',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  TextField _buildJsonField() {
    return TextField(
      controller: jsonController,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: jsonHintText,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      minLines: 4,
      maxLines: 300,
    );
  }
}
