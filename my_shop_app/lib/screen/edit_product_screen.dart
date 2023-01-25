//We need here stateful widget because ,so many time he she will edit the product but not submit that so ,it better to manage it in appwise statemanagment

import 'package:flutter/material.dart';
import 'package:my_shop_app/Providers/product.dart';

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

  //We need key to interact this the widget ,it mostly used in Form widget

  final _formKey = GlobalKey<FormState>();

  //creating varible Product in which we have to set the values one by one because we cannot reassign the final variable in of product
  var _editedProduct =
      Product(id: '', title: '', discription: '', price: 0, imgUrl: '');

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

  void _onSubmit() {
    //We have to save the inputs in Form inputTextField by refering to .save() method present in form which excessed using _formKey.currentState

    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.save))
        ],
      ),
      body: Form(

          //Attached the key to Form which has access to form state

          key: _formKey,

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

                    onSaved: (newValue) {
                      //OverWriting the existing Product

                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: newValue!,
                          discription: _editedProduct.discription,
                          price: _editedProduct.price,
                          imgUrl: _editedProduct.imgUrl);
                    },
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
                    onSaved: (newValue) {
                      //OverWriting the existing Product

                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          discription: _editedProduct.discription,
                          price: double.parse(newValue!),
                          imgUrl: _editedProduct.imgUrl);
                    },
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
                    onSaved: (newValue) {
                      //OverWriting the existing Product

                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.id,
                          discription: newValue!,
                          price: _editedProduct.price,
                          imgUrl: _editedProduct.imgUrl);
                    },
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

                          // Saving the input WhenEver done is pressed

                          onFieldSubmitted: (_) => _onSubmit(),

                          onSaved: (newValue) {
                            //OverWriting the existing Product

                            _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.id,
                                discription: _editedProduct.discription,
                                price: _editedProduct.price,
                                imgUrl: newValue!);
                          },
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
