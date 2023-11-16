# web_scrapeing_test

A new Flutter project.

## Getting Started

This project is a basic implememtation of web scraping data, here we are getting stock data like the dividend information froma website link where this information is free to read. 
we pass in the link where this info is free to read and using chrome developer tools we find the element where we want to take the data - to do this we copy the html selector. then use document.querySelectorAll() to extract this data using the flutter packages below
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;