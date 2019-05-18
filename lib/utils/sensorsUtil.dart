import 'package:barragem/utils/session.dart';

Future getSensors() async {
  // var date = new DateTime.now();
  // var ano = date.year.toString();
  // var mes = date.month.toString();
  // if(mes.length == 1) mes = '0'+mes;
  // var dia = date.day.toString();
  // if(dia.length == 1) dia = '0'+dia;
  // var dateEnvio = ano+'-'+mes+'-'+dia;
  var dateEnvio = '2019-05-11';
  var url = mainUrl+"/getMeasures";

  var r = await Session().post(url, {"date":dateEnvio, "token":token});
  print(r);
  if(r["status"] == "success"){
    return r["data"];
  }
  else if(r["status"] == "none"){
    // return r["data"];
    return [];
  }
  else if(r["status"] == "error"){
    // return r["data"];
    return [];
  }
  else{
    print("erro");
  }

  /*var date1 = new DateTime.now();
  var date2 = DateTime.parse("2019-05-18 20:18:04Z");
  var date3 = DateTime.parse("2019-05-18 20:15:04Z");

  return [
    {
      "name":"Monitor Cano 1",
      "medidas":[
        {
          "waterLevel": 59.0,
          "dateTime": date1
        },
        {
          "waterLevel": 59.0,
          "dateTime": date2
        },
        {
          "waterLevel": 59.0,
          "dateTime": date3
        }
      ],
      "levelMin":5.0,
      "levelMax":8.0
    },
    {
      "name":"Monitor Cano 2",
      "medidas":[]
    }
  ];*/
}