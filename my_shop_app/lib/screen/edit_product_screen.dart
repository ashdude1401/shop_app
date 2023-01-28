//We need here stateful widget because ,so many time he she will edit the product but not submit that so ,it better to manage it in appwise statemanagment

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
import '../Providers/products.dart';

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

    //We can use data from route in init state

    //function called when focus changes

    super.initState();
  }

  var _isInt = true;
  var _isLoading = false;
  var intiValues = {
    'id': '',
    'title': '',
    'discription': '',
    'price': '',
    'imgUrl': '',
  };
  @override
  void didChangeDependencies() {
    //Runs befor build is exicuted

    if (_isInt == true) {
      //Run only one time as didChageDependencies run many time

      final productId = ModalRoute.of(context)?.settings.arguments;
      print("Product ID is $productId");

      if (productId != null) {
        //checking for whether we are editing the product or adding new product as if we are adding ,we will not get the productId as we havent passed productId when user clicks on '+' button on manege product screen

        _editedProduct = Provider.of<Products>(context, listen: false)
            .items
            .firstWhere((prod) => prod.id == productId);

        intiValues = {
          'title': _editedProduct.title,
          'discription': _editedProduct.discription,
          'price': _editedProduct.price.toString(),
          // 'imgUrl': product.imgUrl
          'imgUrl': '',
        };
        _imageUrlController.text = _editedProduct.imgUrl;
      }
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _isInt = false;
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

    final isValid = _formKey.currentState?.validate();

    // ignore: unrelated_type_equality_checks

    if (isValid == false) {
      return;
    }
    _formKey.currentState?.save();

    //Here we do not have ser listen to false because we only want to invoke the methode and don't want to listen to the changes (i.e we don't want to rebuild if something changes. Provider is same a setState (listen:true) it rebuilds the parent widget)

    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id == '') {
      Provider.of<Products>(context, listen: false)
          .addItem(_editedProduct)
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (ctx) {
             return  AlertDialog(
                title:const  Text("An error has ocurred "),
                content: const Text("Something went wrong"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:const Text("Okay")),
                ],
              );
            });
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });

      //poping screen only after all the products gets added in database
    } else {
      Provider.of<Products>(context, listen: false)
          .updateItem(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
              onPressed: () => {_onSubmit()}, icon: const Icon(Icons.save))
        ],
      ),
      body: Form(

          //Attached the key to Form which has access to form state

          key: _formKey,

          //Here we have used form instead of manual text field because as you know mnaual inputTextFeild we have to everything manually form input storing to validation ,but form manages these things internally

          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          //It is connected to Form behind scence

                          initialValue: intiValues['title'],

                          decoration: const InputDecoration(
                            //Hint text

                            hintText: 'Product Title',
                          ),
                          validator: (value) {
                            //validates the data every key stroke ,it can configured by setting auto validate true in form or ,write logic in on submitted fucntion

                            if (value == null) {
                              return "Enter the title";
                            }
                            if (value == "") {
                              return "Enter the title";
                            }
                            return null;
                          },

                          //It controlles the icon on rightBottom may be tick ,next,submitt

                          textInputAction: TextInputAction.next,

                          onSaved: (newValue) {
                            //OverWriting the existing Product

                            if (newValue != null) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: newValue,
                                  discription: _editedProduct.discription,
                                  price: _editedProduct.price,
                                  imgUrl: _editedProduct.imgUrl,
                                  isFavoraite: _editedProduct.isFavoraite);
                            }
                            // print(_editedProduct.title);
                          },
                        ),
                        TextFormField(
                          initialValue: intiValues['price'],

                          //It is connected to Form behind scence

                          decoration: const InputDecoration(
                            //Hint text

                            hintText: 'Price',
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
                                imgUrl: _editedProduct.imgUrl,
                                isFavoraite: _editedProduct.isFavoraite);
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Please Enter the Price";
                            }
                            if (double.tryParse(value) == null) {
                              return "Enter a valid number";
                            }
                            if (double.parse(value) <= 0) {
                              return "Price cannot be empty";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          //setting up the initial values

                          initialValue: intiValues['discription'],

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

                          validator: (value) {
                            if (value == null) {
                              return "Discription cannot be empty";
                            }
                            if (value.length <= 10) {
                              return "Enter a discription greater than 10 words";
                            }
                            return null;
                          },

                          onSaved: (newValue) {
                            //OverWriting the existing Product

                            _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                discription: newValue!,
                                price: _editedProduct.price,
                                imgUrl: _editedProduct.imgUrl,
                                isFavoraite: _editedProduct.isFavoraite);
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
                                // initialValue: intiValues['imgUrl'],we cannot have controller and intial values same time we can configure the intial value using imgUrlcontroller

                                decoration: const InputDecoration(
                                  hintText: 'Image URL',
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,

                                // Saving the input WhenEver done is pressed

                                onFieldSubmitted: (_) => _onSubmit(),

                                validator: (value) {
                                  if (!((value?.endsWith("jpg"))! ||
                                      (value?.startsWith("https"))! ||
                                      (value?.startsWith("http"))!)) {
                                    return "Enter a valid image url";
                                  }
                                  return null;
                                },

                                onSaved: (newValue) {
                                  //OverWriting the existing Product

                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      title: _editedProduct.title,
                                      discription: _editedProduct.discription,
                                      price: _editedProduct.price,
                                      imgUrl: newValue!,
                                      isFavoraite: _editedProduct.isFavoraite);
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
