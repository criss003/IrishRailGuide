# IrishRailGuide
A guide for Irish Rail

Find out the timetables for Dart and Trains on each station from Dublin

Technical choices:

- I choose TBXML because it is the fastest XML Parser and it uses less memory (source: http://www.raywenderlich.com/553/xml-tutorial-for-ios-how-to-choose-the-best-xml-parser-for-your-iphone-project)
- I used an open source from github for TBXML, in which I replaced the NSURLConnection with NSURLSession because it’s deprecated in iOS 9 (source: https://github.com/71squared/TBXML)

Improvements:

- UI improvements 
- Network connection issues treated
- error messages 
- loading indicators in UI while parsing xml data

Features that could be added:

- display train informations for all stations
- display more informations about trains, stations, connections
- map view
