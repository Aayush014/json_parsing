# Flutter JSON Data App

This Flutter app demonstrates how to manage and display JSON data using the `Provider` package. The app leverages the factory pattern and model classes to ensure clean code architecture and efficient state management.

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
- [Project Structure](#project-structure)
- [Detailed Explanation](#detailed-explanation)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- Fetch JSON data
- Display data in a user-friendly manner
- State management using Provider
- Clean code architecture with factory and model classes

## Architecture
This app follows a clean and scalable architecture by separating concerns into different layers:
1. **Model Layer**: Contains model classes to parse JSON data.
2. **Provider Layer**: Manages state and provides data to the UI.
3. **UI Layer**: Displays the data to the user.

<details> 
  <summary><h2>📸Photos</h2></summary>
  <p>
    <table align="center">
  <tr>
    <td><img src="https://github.com/Aayush014/json_parsing/assets/133498952/ee34d093-1d11-4f39-9c2f-21c251345d83" alt="Image 2" width="180" height="auto"></td>
  </tr>
    </table>    
  </p>
  </details>

## Setup Instructions
1. **Clone the repository**:
    ```sh
    git clone https://github.com/Aayush014/json_parsing.git
    ```
2. **Install dependencies**:
    ```sh
    flutter pub get
    ```
3. **Run the app**:
    ```sh
    flutter run
    ```

## Project Structure
```
lib/
├── main.dart
├── models/
│   └── data_model.dart
├── providers/
│   └── data_provider.dart
└── screens/
    └── home_screen.dart
```

## Detailed Explanation

### Model Layer
The `data_model.dart` file contains a class to parse JSON data. Using a factory constructor ensures easy and efficient data parsing.

```dart
class DataModel {
  final int id;
  final String name;
  final String description;

  DataModel({required this.id, required this.name, required this.description});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
```

### Provider Layer
The `data_provider.dart` file contains a class that extends `ChangeNotifier` to manage the state. It fetches data from a JSON source and notifies listeners of any changes.

```dart
import 'package:flutter/material.dart';
import '../models/data_model.dart';

class DataProvider with ChangeNotifier {
  List<DataModel> _items = [];

  List<DataModel> get items => _items;

  Future<void> fetchData() async {
    // Simulate network request
    final response = await Future.delayed(
      Duration(seconds: 2),
      () => [
        {'id': 1, 'name': 'Item 1', 'description': 'Description 1'},
        {'id': 2, 'name': 'Item 2', 'description': 'Description 2'},
      ],
    );

    _items = response.map((item) => DataModel.fromJson(item)).toList();
    notifyListeners();
  }
}
```

### UI Layer
The `home_screen.dart` file contains a simple UI to display the data. It uses a `Consumer` widget to listen to changes in the `DataProvider`.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter JSON Data App'),
      ),
      body: FutureBuilder(
        future: Provider.of<DataProvider>(context, listen: false).fetchData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<DataProvider>(
              builder: (ctx, dataProvider, child) => ListView.builder(
                itemCount: dataProvider.items.length,
                itemBuilder: (ctx, index) {
                  final item = dataProvider.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.description),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
```

### Main Entry Point
The `main.dart` file initializes the `Provider` and runs the app.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/data_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => DataProvider(),
      child: MaterialApp(
        title: 'Flutter JSON Data App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
```

## Dependencies
Ensure the following dependencies are added to your `pubspec.yaml` file:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^5.0.0
```

## Usage
After setting up the project and running the app, you will see a list of items fetched from the JSON data. The data is managed by the Provider and displayed in a clean and simple UI.

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License.
