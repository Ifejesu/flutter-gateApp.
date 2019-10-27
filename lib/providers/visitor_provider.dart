import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:gateapp/core/models/old_user.dart';

class VisitorProvider extends ChangeNotifier {
  List<VisitorModel> visitorModels = [];
  bool initialVisitorsLoaded = false;
  bool loadedFromApi = false;
  bool loadedFromPrefs = false;

  void addVisitorModel(VisitorModel model, {String jsonString}) async {
    print('printing model from provider');
    print('model.toString()');
    this.visitorModels.add(model);
    if (jsonString != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String newVisitorsString;
      print('What I have now');
      if (prefs.getString('visitors') != null){
        print(json.decode(prefs.getString('visitors')));
       newVisitorsString = json.encode(json.decode(prefs.getString('visitors')).add(json.decode(jsonString)));
      
      } else {
        newVisitorsString = '[$jsonString]';
      }
      prefs.setString('visitors', newVisitorsString);
    }
    notifyListeners();
  }

  void setVisitorModelsFromPrefs() async {
    if (this.loadedFromApi == false &&
        this.loadedFromPrefs == false &&
        this.visitorModels.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.get('visitors'));
      if (prefs.get('visitors') != null) {
        print('Am not null joor');
        dynamic jsonList = json.decode(prefs.get('visitors'));
        print(jsonList);
        jsonList.forEach((jsonObject) {
          print(jsonObject);
                    visitorModels.add(VisitorModel.fromJson(jsonObject));
        });
        loadedFromPrefs = true;
        notifyListeners();
        return;
      }
    }
    return;
  }

  void addVisitorModels(
    List<VisitorModel> models,
  ) {
    this.visitorModels.addAll(models);
    this.initialVisitorsLoaded = true;
    notifyListeners();
  }

  void setVisitorModels(List<VisitorModel> models, {String jsonString}) async {
    print('Loadddddddddedd from Api');
    this.visitorModels = models;
    this.loadedFromApi = true;
    if (jsonString != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('visitors', jsonString);
      print(prefs.get('visitors'));
    }

    notifyListeners();
  }

  void setInitialStatus(bool status) {
    initialVisitorsLoaded = status;
    notifyListeners();
  }
}

class VisitorModel {
  int id, user_id, home_id, status;
  String name, arrival_date, car_plate_no, purpose, image, time_in, time_out;

  VisitorModel(
      {this.id,
      this.name,
      this.arrival_date,
      this.car_plate_no,
      this.purpose,
      this.image,
      this.status,
      this.time_in,
      this.time_out,
      this.user_id,
      this.home_id});

  factory VisitorModel.fromJson(dynamic jsonModel) {
    return VisitorModel(
        id: jsonModel['id'],
        name: jsonModel['name'],
        arrival_date: jsonModel['arrival_date'],
        car_plate_no: jsonModel['car_plate_no'],
        purpose: jsonModel['purpose'],
        image: jsonModel['image'],
        status: jsonModel['status'],
        time_in: jsonModel['time_in'],
        time_out: jsonModel['time_out'],
        user_id: jsonModel['user_id'],
        home_id: jsonModel['home_id']);
  }
}
