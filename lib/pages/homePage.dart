import 'package:flutter/material.dart';
import '../utils/sign.dart';
import 'chartPage.dart';
import '../utils/style.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/sensorsUtil.dart';
import 'measuresPage.dart';

class HomePage extends StatefulWidget{
  final List _listaSensores = [];
  @override
  _HomePageState createState() => _HomePageState(_listaSensores);
}

class _HomePageState extends State<HomePage>{
  List _listaSensores;

  _HomePageState(this._listaSensores);

  Future<Map> search() async {
    List dados = await getSensors();
    print(dados);
    setState(() {
      _listaSensores = dados;
    });
  }

  Future<Null> refreshList() async {
    await search();
    return null;
  }

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context){
    return
    new Scaffold(
      appBar: AppBar(
        title: Text("iBarragem"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){
              Sign().signOut(context);
            }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.update),
        onPressed: search,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: DrawerMenu()// We'll populate the Drawer in the next step!
      ),
      body: RefreshIndicator(
          onRefresh: refreshList,
          child: Column(
            children: [
              new Calendar(
                isExpandable: true,
                onDateSelected: (date) {
                  print(date.toString());
                  // var year = date.year.toString();
                  // var month = date.month.toString();
                  // var day = date.day.toString(); 
                  // if(month.length == 1) month = '0'+month;
                  // if(day.length == 1) day = '0'+day;
                  // refreshList(year+'-'+month+'-'+day);
                },
                dayBuilder: (BuildContext context, DateTime day){
                  return 
                  InkWell(
                    highlightColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Center(child: 
                          Text(
                            day.day.toString(),
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  )
                  ;
                },
              ),
              _listaSensores.length == 0 ?
              Center(
                child: CircularProgressIndicator(),
              )
              :
              Container(
                child: new ListView.builder(
                  reverse: false,
                  itemBuilder: (BuildContext context, int index)=>Lista(this._listaSensores[index]),
                  itemCount: _listaSensores.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            ],
          )
        ),
    );
  }
}

class Lista extends StatelessWidget{
  final Map json;

  Lista(
    this.json
  );

  @override
  Widget build(BuildContext context) { 
    // print("JSON " + json.toString());
    return
      new InkWell(
        child:
        new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                  color: Colors.black12
                ),
            )
        ),
        padding: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      json["name"],
                      style: myStyle().getTextStyle(25.0, Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            json["medidas"].isEmpty ? Text("---",style: myStyle().getTextStyle(25.0, Colors.black)) 
            : 
            new Text(
              json["medidas"][0]["waterLevel"].toStringAsFixed(1),
              style: myStyle()
              .getTextStyle(
                25.0,
                json["medidas"][0]["waterLevel"] < json["levelMin"] ?
                Colors.grey 
                :
                  json["medidas"][0]["waterLevel"] > json["levelMax"] ?
                  Colors.blue
                  :
                  Colors.blueAccent
              ),
            ),
            json["medidas"].isEmpty ? 
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.opacity, color: Colors.grey)
            ) 
            : 
            new Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: json["medidas"][0]["waterLevel"] < json["levelMin"] ? 
                  Icon(Icons.opacity, color: Colors.grey)
                  :
                  json["medidas"][0]["waterLevel"] > json["levelMax"] ?
                    Icon(Icons.opacity, color: Colors.blue)
                    :
                    Icon(Icons.opacity, color: Colors.blueAccent)
                ,
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MeasuresPage(listaMedicoes: json["medidas"], nome: json["name"])),
        );
      },
    );
  }
}

class DrawerMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown
              ),
              accountName: new Text("John Doe"),
              accountEmail: null
            ),
            ListTile(
              title: Text('Gráficos'),
              trailing: Icon(FontAwesomeIcons.chartBar),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChartPage()),
                );
              },
            ),
            ListTile(
              title: Text('Alertas'),
              trailing: Icon(Icons.warning),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              title: Text('Relatórios'),
              trailing: Icon(FontAwesomeIcons.paperclip),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ],
        ),
      );
  }
}