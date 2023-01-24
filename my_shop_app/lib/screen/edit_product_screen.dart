//We need here stateful widget because ,so many time he she will edit the product but not submit that so ,it better to manage it in appwise statemanagment

import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //To get the input url entered by the user to privew after a stroke is hit

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    //function called when focus changes
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Form(

          //Here we have used form instead of manual text field because as you know mnaual inputTextFeild we have to everything manually form input storing to validation ,but form manages these things internally

          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                //It is connected to Form behind scence

                decoration: const InputDecoration(
                  //Hint text

                  hintText: 'Title',
                ),

                //It controlles the icon on rightBottom may be tick ,next,submitt

                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                //It is connected to Form behind scence

                decoration: const InputDecoration(
                  //Hint text

                  hintText: 'Number',
                ),

                //It controlles the icon on rightBottom may be tick ,next,submitt

                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                //It is connected to Form behind scence

                decoration: const InputDecoration(
                  //Hint text

                  hintText: 'Discription',
                ),

                //It controlles the icon on rightBottom may be tick ,next,submitt

                textInputAction: TextInputAction.newline,

                //will show enter button

                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.orange,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(
                            child: Text("Enter Image URL"),
                          )
                        : FittedBox(
                            clipBehavior: Clip.antiAlias,
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(33),
                              child: Image.network(
                                _imageUrlController.text,
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Image URL',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
