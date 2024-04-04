
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneylover/services/currency_service.dart';
import 'package:moneylover/utils/utils.dart';

class AddCurrencyScreen extends StatefulWidget {
  const AddCurrencyScreen({super.key});

  @override
  State<AddCurrencyScreen> createState() => _AddCurrencyScreenState();
}

class _AddCurrencyScreenState extends State<AddCurrencyScreen> {
  Uint8List? _file;
  bool _isLoading = false;

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _exchangeRateController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _countryController.dispose();
  }

  _selectImage(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Create a new currency"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });

                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  void postCurrency() async{
    setState(() {
      _isLoading = true;
    });

    try{
      String res = await CurrencyService().uploadCurrency(_nameController.text, _countryController.text, _file!, double.parse(_exchangeRateController.text));
      if(res == "ss"){
        showSankBar("Posted", context);
        clearImage();
      }else{
        showSankBar(res, context);
      }
    }catch(e){
      showSankBar(e.toString(), context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ?
        Center(
          child: IconButton(
            icon: Icon(Icons.upload, color: Colors.white,),
            onPressed: () => _selectImage(context),
          ),
        )
        :
        SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Post Current"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: clearImage,
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _isLoading ? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.only(bottom: 0)),
                    const Divider(),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Name currently",
                
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _countryController,
                      decoration: const InputDecoration(
                        hintText: "Country name",

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _exchangeRateController,
                      decoration: const InputDecoration(
                        hintText: "Exchange Rate",

                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Flexible(child: Container()),
                   ElevatedButton(
                       onPressed: () => postCurrency(),

                       child: Text("Upload")
                   )
                  ],
                ),
              ),


            )
        )
    ;
  }
}
