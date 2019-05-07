import 'package:flutter/material.dart';
import 'session.dart';

Future getSensors(String dataParam) async {
  var date = new DateTime.now();
  var ano = date.year.toString();
  var mes = date.month.toString();
  if(mes.length == 1) mes = '0'+mes;
  var dia = date.day.toString();
  if(dia.length == 1) dia = '0'+dia;

  var dateEnvio;

  if(dataParam == null){
    // dateEnvio = '2018-10-21';
    // dateEnvio = '2019-3-15';
    dateEnvio = ano+'-'+mes+'-'+dia;
  }
  else{
    dateEnvio = dataParam;
    // print("Param " + dataParam);
  }

  // print("Envio " + dateEnvio);
  List<Sensor> lista = new List();

  var r = await Session().post("http://ec2-54-207-28-154.sa-east-1.compute.amazonaws.com:8000/getMeasures", {"date":dateEnvio, "token":token});
  print(r);
  if(r["status"] == "success"){
    lista = montarLista(r["data"]);

    return lista;
  }
  else if(r["status"] == "none"){
    lista = montarLista(r["data"]);

    return lista;
  }
  else if(r["status"] == "error"){
    print("erro " + r["msg"]);
    lista = [];
    return lista;
  }
  else{
    print("erro");
  }
}

montarLista(var content){
  SensorsList sensores = SensorsList.fromJson(content);

  return sensores.sensores;
}

class SensorsList {
  final List<Sensor> sensores;

  SensorsList({
    this.sensores,
  });

  factory SensorsList.fromJson(List<dynamic> parsedJson) {

    List<Sensor> sensores = new List<Sensor>();
    sensores = parsedJson.map((i)=>Sensor.fromJson(i)).toList();

    return new SensorsList(
       sensores: sensores,
    );
  }
}

class Sensor {
  final String id;
  final String nome;
  final List<Measure> measures;

  Sensor({
    this.id,
    this.nome,
    this.measures,
  });

  factory Sensor.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['medidas'] as List;

    List<Measure> measuresList = list.map((i) => Measure.fromJson(i)).toList();

    return Sensor(
      id:parsedJson['uuid'],
      nome:parsedJson['name'],
      measures:measuresList,
    );

  }
}

class Measure {
  final temperatureC;
  final humidityPct;
  final batteryPct;
  DateTime time;

  Measure({
    this.temperatureC,
    this.humidityPct,
    this.batteryPct,
    this.time
  });

  factory Measure.fromJson(Map<String, dynamic> parsedJson){
    //DateTime t = DateTime.now();
    if(!parsedJson.containsKey('temperatureC')) 
      return Measure(temperatureC: 0.0, humidityPct: 0.0, batteryPct: 0.0, time: DateTime.now());

    return Measure(
      temperatureC:parsedJson['temperatureC'],
      humidityPct:parsedJson['humidityPct'],
      batteryPct:parsedJson['batteryPct'],
      time: DateTime.parse(parsedJson['timestamp'])
    );
  }
}