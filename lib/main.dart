import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestHttp extends StatefulWidget {
  final String url, method;

  TestHttp({String url, method}):url = url, method = method;

  @override
  State<StatefulWidget> createState() => TestHttpState();
}//TestHttp

class ListTestHttp extends StatelessWidget {
  final Widget _title;
  final Widget _content;

  ListTestHttp({Widget title,content}): _title = title, _content = content;

  Widget _construct() {
    if (_title != null && _content != null) {
      return Column(children: <Widget>[_title, Expanded(child: _content)],);
    }

    return _content;
  }//_construct

  @override
  Widget build(BuildContext context) {
    return Container(child: _construct(), height: 80.0, padding: EdgeInsets.all(10.0),);
  }//build
}//ListTestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();

  String _url, _method, _body;
  int _status;

  @override
  void initState() {
    _url = widget.url;
    _method = widget.method;

    super.initState();
  }//initState


  Widget build(BuildContext context) {
    return Form(key: _formKey, child: SingleChildScrollView(child: Column(
      children: <Widget>[
        ListTestHttp(
            content: TextFormField(initialValue: _url, validator: (value){if (value.isEmpty) return 'API url isEmpty';}, onSaved: (value){_url = value;}, autovalidate: true),
            title: Text('API url', style: TextStyle(fontSize: 20.0,color: Colors.blue))
        ),
        ListTestHttp(
            content: TextFormField(initialValue: _method, validator: (value){if (value.isEmpty) return 'API method isEmpty';}, onSaved: (value){_method = value;}, autovalidate: true),
            title: Text('API method', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
        ),
        SizedBox(height: 20.0),
        RaisedButton(
          child: Text('Send request'),
          onPressed: () async {
            if(_formKey.currentState.validate()) {
              _formKey.currentState.save();

              try {
                var response = await http.get('$_url$_method');

                _status = response.statusCode;
                _body = response.body;


                print("Response status: ${_status}");
                print("Response body: ${_body}");

              } catch (error) {
                print(error);
              }

              setState(() {
              });


            }
          }
        ),
        SizedBox(height: 20.0),

        Text('Response status', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
        Text(_status == null ? '' :_status.toString()),

        SizedBox(height: 20.0),

        Text('Response body', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
        Text(_body == null ? '' : _body),
      ],
    )));
  }//build
}//TestHttpState

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Test HTTP API')),
            body: new TestHttp(url: 'https://json.flutter.su', method: '/echo')
        )
    )
);