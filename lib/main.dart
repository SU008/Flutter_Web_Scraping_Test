import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Scraping Demo',
      home: WebScrapingScreen(),
    );
  }
}

class WebScrapingScreen extends StatefulWidget {
  @override
  _WebScrapingScreenState createState() => _WebScrapingScreenState();
}

class _WebScrapingScreenState extends State<WebScrapingScreen> {
  String? scrapedData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  /*

  for yeild: #content > div > div > div:nth-child(9) > div > div.mdc-typography--headline3
  for accuracy: #content > div > div > div:nth-child(7) > div > div.mdc-typography--headline3


  for table:
  #content > div > div > div:nth-child(3) > div > div.table-container > div > table > tbody > tr:nth-child(3) > td:nth-child(3)
  key: change value in tr:nth-child(7)
  1 = status
  3 = type
  5= per share
  7= decleration
  9 = ex div date
  11 = pay date


  1 = col 1
  3 = col 2:center col
  5 = col 3
   */

  Future<void> fetchData() async {
    final url = Uri.parse('https://www.dividendmax.com/united-states/nyse/real-estate-investment-trusts/realty-income-corp/dividends'); // Replace with your URL
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);
  final elements = document.querySelectorAll(' #content > div > div > div:nth-child(3) > div > div.table-container > div > table > tbody > tr:nth-child(3) > td:nth-child(3)'); // Replace with your selector

                                              //#content > div > div > div:nth-child(7) > div > div.mdc-typography--headline3  //accreacy value
                                               //working@#content > div > div > div:nth-child(3) > div > div.table-container > div > table > tbody > tr:nth-child(3) > td:nth-child(3)
                                               //#content > div > div > div:nth-child(2) > div > div.table-container > div > table > tbody > tr:nth-child(2)
      if (elements.isNotEmpty) {
        final extractedData = elements.last.text;
        setState(() {
          scrapedData = extractedData;
        });
      } else {
        setState(() {
          scrapedData = 'Data not found';
        });
      }
    } else {
      setState(() {
        scrapedData = 'Failed to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Scraping Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (scrapedData != null)
                Text(
                  'Scraped Data:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 10),
              Text(
                scrapedData ?? 'Loading...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          setState(() {
            fetchData();
          });

        },
        child: const Icon(Icons.refresh),
      ),

    );
  }
}
