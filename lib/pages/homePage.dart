import 'package:flutter/material.dart';
import '../utils/sensorsUtil.dart';
import '../utils/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Sensor> listaSensores = new List();

  Future getList() async {
    return await getSensors(null);
  }

  _SensorsPageState() {
    getList().then((lis) => setState(() {
      listaSensores = lis;
    }));
  }

  Future<Null> refreshList() async {
    await getList().then((lis) => setState(() {
      //print(lis);
      listaSensores = lis;
    }));
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return
    new Scaffold(
      appBar: AppBar(
        title: Text("iBarragem"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: refreshList,
          child: listaSensores.length == 0 ?
          new Center(
            child: CircularProgressIndicator(),
          )
          :
          new Container(
            child: new ListView.builder(
              reverse: false,
              itemBuilder: (BuildContext context, int index) => Lista(
                this.listaSensores[index].id,
                this.listaSensores[index].nome,
                this.listaSensores[index].measures
              ),
              itemCount: listaSensores.length,
            ),
          ),
        ),
    );
  }
}

class Lista extends StatelessWidget{
  final String id;
  final String name;
  final List<Measure> measures;

  Lista(
    this.id,
    this.name,
    this.measures
  );

  @override
  Widget build(BuildContext context) { 
    // if(measures.isEmpty){
    //   return SizedBox();
    // }
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
        //padding: new EdgeInsets.all(30.0),
        padding: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
        child: Row(
          children: [
            // _buildBattery(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      name,
                      style: myStyle().getTextStyle(25.0, Colors.black87),
                    ),
                  ),
                  _buildBattery(),
                ],
              ),
            ),
            measures.isEmpty ? Text("---",style: myStyle().getTextStyle(25.0, Colors.black)) 
            : 
            new Text(
              measures[0].temperatureC.toStringAsFixed(1),
              style: myStyle()
              .getTextStyle(
                25.0,
                measures[0].temperatureC < 15 ?
                Colors.blueAccent 
                :
                  measures[0].temperatureC > 30 ?
                  Colors.red
                  :
                  Colors.black
              ),
            ),
            measures.isEmpty ? 
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(FontAwesomeIcons.thermometerThreeQuarters, color: Colors.grey)
            ) 
            : 
            new Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: measures[0].temperatureC < 15 ? 
                  Icon(Icons.ac_unit, color: Colors.blueAccent[700])
                  :
                  measures[0].temperatureC > 30 ?
                    Icon(FontAwesomeIcons.fire, color: Colors.red)
                    :
                    Icon(FontAwesomeIcons.thermometerThreeQuarters, color: Colors.deepOrange)
                ,
            ),
            measures.isEmpty ? Text("---",style: myStyle().getTextStyle(25.0, Colors.black)) 
            : 
            new Text(
              measures[0].humidityPct.toStringAsFixed(1),
              // TODO: VERIFICAR SE OS VALORES AQUI ESTAO CERTOS 
              style: myStyle()
              .getTextStyle(
                25.0, 
                measures[0].humidityPct < 80 ? Colors.black : Colors.red
              ),
            ),
            measures.isEmpty ? 
            Icon(Icons.opacity, color: Colors.blueAccent)
            : 
            new Icon(Icons.opacity, color: Colors.blueAccent),
          ],
        ),
      ),
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => MeasuresPage(listaMedicoes: measures, nome: name, id: id)),
        // );
      },
    );
  }

  Widget _buildBattery() {
    if(measures.isEmpty){
      return 
      Icon(
          FontAwesomeIcons.times,
          color: Colors.red,
          size: 20.0,
        )
      ;
    }
    if (measures[0].batteryPct > 66.66) {
      return 
        Icon(
          FontAwesomeIcons.batteryFull,
          color: Colors.green,
          size: 20.0,
        )
      ;
    }
    else if(measures[0].batteryPct > 50.00 && measures[0].batteryPct <= 66.66){
      return 
        Icon(
          FontAwesomeIcons.batteryThreeQuarters,
          color: Colors.limeAccent[700],
          size: 20.0,
        )
      ;
    }
    else if(measures[0].batteryPct > 33.33 && measures[0].batteryPct <= 50.00){
      return 
        Icon(
          FontAwesomeIcons.batteryHalf,
          color: Colors.amber,
          size: 20.0,
        )
      ;
    }
    else if(measures[0].batteryPct <= 33.33){
      return 
        Icon(
          FontAwesomeIcons.batteryQuarter,
          color: Colors.red,
          size: 20.0,
        )
      ;
    }
    else if(measures[0].batteryPct <= 1){
      return 
        Icon(
          FontAwesomeIcons.times,
          color: Colors.red,
          size: 20.0,
        )
      ;
    }
    return Text("");
  }
}