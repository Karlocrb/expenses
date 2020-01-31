import 'package:expenses/category_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  final Rect buttonRect;

  const AddPage({Key key, this.buttonRect}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String category;
  int value = 0;
  String dateStr = "hoy";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Gastos',
            style: TextStyle(color: Colors.grey),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                color: Colors.grey,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
        body: _body(),
      ),
    ]
    );
  }

  Widget _body() {
     var h = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        _categorySelector(),
        _currentValue(),
        _numPad(),
        SizedBox( height: h - widget.buttonRect.top),
        _submited(),
      ],
    );
  }

  Widget _categorySelector() {
    return Container(
      height: 80.0,
      child: CategorySelectionWidget(
        categories: {
          "Mas x Menos": Icons.shopping_cart,
          "Pricemart": FontAwesomeIcons.beer,
          "Feria": FontAwesomeIcons.hamburger,
          "Farmacia": FontAwesomeIcons.wallet,
          "Veterinaria": FontAwesomeIcons.carAlt,
          "Restaurant": FontAwesomeIcons.infinity,
          "Mac Donalds": FontAwesomeIcons.infinity,
          "Plaza": FontAwesomeIcons.infinity,
          "Megasuper": FontAwesomeIcons.infinity,
          "Pali": FontAwesomeIcons.infinity,
          "Gasolina": FontAwesomeIcons.infinity,
          "EL Rey": FontAwesomeIcons.infinity,
          "Ins Auto": FontAwesomeIcons.infinity,
          "Ins Casa": FontAwesomeIcons.infinity,
        },
        onValueChanged: (newCategory) => category = newCategory,
      ),
    );
  }

  Widget _currentValue() {
    var realValue = value / 100.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        "\₡${realValue.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

/*
                     *Teclado Numerico*
*/

  Widget _numPad() {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.biggest.height / 4;

        return Table(
          border: TableBorder.all(
            color: Colors.grey,
            width: 1.0,
          ),
          children: [
            TableRow(children: [
              _num("1", height),
              _num("2", height),
              _num("3", height),
            ]),
            TableRow(children: [
              _num("4", height),
              _num("5", height),
              _num("6", height),
            ]),
            TableRow(children: [
              _num("7", height),
              _num("8", height),
              _num("9", height),
            ]),
            TableRow(children: [
              _num(",", height),
              _num("0", height),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = value ~/ 10;
                  });
                },
                child: Container(
                  height: height,
                  child: Center(
                    child: Icon(
                      Icons.backspace,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        );
      }),
    );
  }

  Widget _num(String text, double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, //Tamano total de la Grilla del Num
      onTap: () {
        setState(() {
          if (text == ",") {
            value = value * 100;
          } else {
            value = value * 10 + int.parse(text);
          }
        });
      },
      child: Container(
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _submited() {
      return Positioned(
        top: widget.buttonRect.top,
        bottom: 0,
        left: 0,
        right: 0,
        child: Builder(builder: (BuildContext context) {
          return Container(
            height: widget.buttonRect.top,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: MaterialButton(
              child: Text(
                'Agregar Gastos',
                style: TextStyle(color: Colors.white,
                fontSize: 20),
              ),
              onPressed: () {
                if (value > 0 && category != null) {
                  /*
                              *Grabacion de Registros*
         */
                  Firestore.instance.collection('gastos').document().setData({
                    "category": category,
                    "value": value / 100,
                    "month": DateTime.now().month,
                    "day": DateTime.now().day,
                  });
                  Navigator.of(context).pop();
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Seleccione el valor y la categoria')));
                }
              },
            ),
          );
        }),
      );
    }
  }

