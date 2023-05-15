import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interview_test/pojo/Userdetailspojo.dart';
import 'package:http/http.dart' as http;
import 'package:interview_test/utils/Network.dart';
import 'package:interview_test/utils/StringConstants.dart';

class Userdetailscreen extends StatefulWidget {
  // String name,username,email,streetname,streetsuite,streetcity,streetzipcode,latitude,longitude,phonenumber,websitename,companyname;
  int id;
  Userdetailscreen({super.key, required this.id});

  @override
  UserdetailscreenState createState() => UserdetailscreenState();
}

class UserdetailscreenState extends State<Userdetailscreen> {
  Userdetailspojo? userdetailspojo;
  double lat = 0.0;
  double long = 0.0;
  late LatLng placelatlong;

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
   late CameraPosition _kGooglePlex;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("User id:-" + widget.id.toString());
    getdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: userdetailspojo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      StringConstants.userdetails,
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.height / 100 * 2.5),
                      textAlign: TextAlign.center,
                    )),
                    Row(
                      children: [
                        Text(
                          StringConstants.id,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.id.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.name,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.id.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.username,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.username.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.email,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.email.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.address,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 100 * 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userdetailspojo!.address!.street.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              2.5),
                                ),
                                Text(
                                  userdetailspojo!.address!.suite.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              2.5),
                                ),
                                Text(
                                  userdetailspojo!.address!.city.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              2.5),
                                ),
                                Text(
                                  userdetailspojo!.address!.zipcode.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              2.5),
                                ),
                              ],
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.phonenumber,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.phone.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.websitename,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.website.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          StringConstants.companyname,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                        Text(
                          userdetailspojo!.company!.name.toString(),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /
                                  100 *
                                  2.5),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/100*3),
                      height: (MediaQuery.of(context).size.height / 100) * 25,
                      width: double.infinity,
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> getdetails() async {
    var jsonResponse = null;
    var response = await http.get(
      Uri.parse(Network.baseurl + Network.users + "/" + widget.id.toString()),
    );
    jsonResponse = json.decode(response.body);
    print("jsonResponse:-$jsonResponse");
    if (response.statusCode == 200) {
      setState(() {
        userdetailspojo = Userdetailspojo.fromJson(jsonResponse);
        setState(() {
          _kGooglePlex = CameraPosition(
            target: LatLng(double.parse(userdetailspojo!.address!.geo!.lat.toString()), double.parse(userdetailspojo!.address!.geo!.lng.toString())),
            zoom: 14.4746,
          );
        });
      });
    } else {
      var snackbar = SnackBar(content: Text("Something is wrong!"));
      ScaffoldMessenger.of(this.context).showSnackBar(snackbar);
    }
  }
}
