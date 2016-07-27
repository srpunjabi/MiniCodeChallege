# MiniCodeChallege
A mini iOS app that I wrote for a coding challenge.  The app consumes a rest API containing location data of restaurants in Chicago and displays them on a map.  

### Screenshots:
<img src="Screenshots/Master.png?" alt="alt text" width="187.5" height="333.5">
<img src="Screenshots/Details.png?" alt="alt text" width="187.5" height="333.5">

### Works On:
iOS 9.1 and later

### Usage:
1. Open the app once installed
2. List of restaurants will be displayed
3. Click on a restaurant name to see more details.

### Build Instructions:
1.  This app was written with Swift 2.2 so it will require Xcode 7.3 or higher
2.  Clone the repo or download the zip file
4.  Build and run

### Details:

##### ViewControllers:
1. **MasterViewController:**  Shows a list of restaurants in an UITableView.  A UISegmentedControl is used to filter restaurants by name and by distance.
2. **DetailViewController:**  Displays restaurants as pins on a MKMapView along with some info about the restaurants.

##### Model:
1. **Location:**  An object that holds location data and contains a failable intitializer to convert json dictionary into Location objects.
2. **LocationAnnotation:**  A MKAnnotation subclass that holds data used to display pin annotation.  

##### Network:
I wasn't allowed to use any third party libraries for this project, so this project uses NSURL.* classes for networking and NSJSONSerialization for json parsing.

1. **LocationNetworkSingleton:**  Makes network requests, parses the JSON into Location objects and calls the completionHandler closure passed in.

### Other Contributors:
 **1. Reachability.swift:** 
 ```
 Copyright (c) 2014 Isuru Nanayakkara
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 ```




