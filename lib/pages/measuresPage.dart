import 'package:flutter/material.dart';
import '../utils/style.dart';
import '../utils/sensorsUtil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:intl/intl.dart';

class MeasuresPage extends StatefulWidget {
  final List listaMedicoes;
  final String nome;

  MeasuresPage({Key key, @required this.listaMedicoes, this.nome}) : super(key: key);

  @override
  _MeasuresPageState createState() {
    print(listaMedicoes);
    return new _MeasuresPageState(listaMedicoes: listaMedicoes, nome: nome);
  }
}

class _MeasuresPageState extends State<MeasuresPage> {
  List listaMedicoes;
  String nome;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  _MeasuresPageState({Key key, @required this.listaMedicoes,this.nome});

  // Future getList(date) async {
  //   //DataRetrieval().getList();
  //   return await getSensors(date);
  // }

  // Future<Null> refreshList(date) async {

  //   await getList(date).then((lis) => setState(() {
  //     var index = lis.indexWhere((item) => item.nome == nome);
  //     print(index);
  //     lis = lis[index].measures;
  //     print(lis);
  //     listaMedicoes = lis;
  //   }));

  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    // print("aaa " + listaMedicoes[0]["dateTime"].toString());
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: BackButtonIcon(),
          ),
          centerTitle: true,
          title: new Text(
              nome,
              textAlign: TextAlign.center,
              style: myStyle().getTextStyle(23.0, Colors.white)
          ),
          backgroundColor: Colors.lightBlueAccent,
          actions: <Widget>[
            new PopupMenuButton(
              // onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return itens.map((ItensDoMenu item) {
                  return new PopupMenuItem(
                    value: item,
                    child: new ListTile(
                      title: item.title,
                      leading: item.icon,
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: new Container(
          // child: new ListView.builder(
          //   reverse: false,
          //   itemBuilder: (BuildContext context, int index) => ListaMedicoes(
          //     listaMedicoes[index].time == null ? null : listaMedicoes[index].time,
          //     listaMedicoes[index].waterLevelC,
          //     listaMedicoes[index].humidityPct
          //   ),
          //   itemCount: listaMedicoes.length,
          // ),
          child: Column(
            children: [
              // new Calendar(
              //   isExpandable: true,
              //   onDateSelected: (date) {
              //     print(date.toString());
              //     var year = date.year.toString();
              //     var month = date.month.toString();
              //     var day = date.day.toString(); 
              //     if(month.length == 1) month = '0'+month;
              //     if(day.length == 1) day = '0'+day;
              //     refreshList(year+'-'+month+'-'+day);
              //   },
              //   dayBuilder: (BuildContext context, DateTime day){
              //     return 
              //     InkWell(
              //       // onTap: () {
              //       //   refreshList(day.toString());
              //       // },//=> print("OnTap $day"),
              //       highlightColor: Colors.white,
              //       child: Padding(
              //         padding: EdgeInsets.all(5.0),
              //         child: new Container(
              //           decoration: new BoxDecoration(
              //             border: new Border.all(color: Colors.black38),
              //             borderRadius: BorderRadius.circular(50.0)
              //           ),
              //           child: Center(child: 
              //             Text(
              //               day.day.toString(),
              //               style: TextStyle(color: Colors.green),
              //             ),
              //           ),
              //         ),
              //       )
              //     )
              //     ;
              //   },
              // ),

              listaMedicoes.length == 0 ? 
              Center(child: Text("Ainda não existem medidas desse dia"),)
              :
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) => ListaMedicoes(
                    listaMedicoes[index]["dateTime"] == null ? DateTime.now() : listaMedicoes[index]["dateTime"],
                    listaMedicoes[index]["waterLevel"],
                  ),
                  itemCount: listaMedicoes.length,
                ),
              ),
            ]
          ),
        ),
    );
  }
}

class ListaMedicoes extends StatelessWidget{
  final DateTime hora;
  final num waterLevel;

  ListaMedicoes(
    this.hora,
    this.waterLevel,
  );

  @override
  Widget build(BuildContext context) { 
    // String formattedDate = DateFormat('kk:mm').format(hora);
    return
      new InkWell(
        child:
        new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                  color: Colors.black12, 
                  //width: 5.0
                ),
            )
        ),
        //padding: new EdgeInsets.all(30.0),
        padding: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      hora.hour.toString().length == 1 ? '0'+hora.hour.toString()+':'+hora.minute.toString() : hora.hour.toString()+':'+hora.minute.toString(),                             
                      style: myStyle().getTextStyle(25.0, Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            new Text(
              waterLevel.toStringAsFixed(1),
              style: myStyle().getTextStyle(
                25.0, 
                Colors.black
              ),
            ),
            new Padding(
                padding: EdgeInsets.only(right: 10.0),
                //child: Icon(waterLevel < 15 ? Icons.ac_unit : waterLevel > 30 ? FontAwesomeIcons.fire : FontAwesomeIcons.thermometerThreeQuarters, color: Colors.black),
                child: Icon(Icons.opacity, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class ItensDoMenu {
  final int val;
  final Text title;
  final Icon icon;
  const ItensDoMenu({this.val, this.title, this.icon});
}

const List<ItensDoMenu> itens = <ItensDoMenu>[
  const ItensDoMenu(
    val: 1,
    title: const Text('Warnings'),
    icon: const Icon(Icons.warning)
  ),
  const ItensDoMenu(
    val: 2,
    title: const Text('Gerar Relatório'),
    icon: const Icon(Icons.insert_drive_file)
  ),
  // const ItensDoMenu(
  //   val: 3,
  //   title: const Text('Calendário'),
  //   icon: const Icon(FontAwesomeIcons.calendar),
  // ),
];