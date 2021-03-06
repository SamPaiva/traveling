import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/components/app_bar.dart';
import 'package:mobile/components/custom_drawer.dart';
import 'package:mobile/components/hotels_carousel.dart';
import 'package:mobile/pages/home/home_controller.dart';
import 'package:mobile/pages/login/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Modular.get<HomeController>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha a opção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Text(
                    'Criar Conta',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: CustomAppBar(
        hotels: this.homeController.hotels,
        showDialog: _showMyDialog,
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'O que você está procurando?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            // DestinationCarousel(destinations: this.controller.destination),
            (this.homeController.hotels.length != 0)
                ? HotelCarousel(hotels: this.homeController.hotels)
                : Center(
                    child: Text('Nenhum hotel Cadastrado'),
                  )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: (homeController.hotels != null)
              ? _buildBody()
              : Center(
                  child: CircularProgressIndicator(),
                ),
          // bottomNavigationBar: BottomBar(
          //     currentIndex: this.controller.currentIndex,
          //     changePage: this.controller.changePage),
        );
      },
    );
  }
}
