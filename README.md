# Flutter CRUD Application

This repository contains a simple CRUD (Create, Read, Update, Delete) application built with Flutter. The application is designed to interact with a REST API developed using Node.js.

## Getting Started

To run this project locally, follow these steps.

### Prerequisites

- Flutter installed on your machine
- An editor (preferably Android Studio, IntelliJ, or VSCode)
- An emulator or device to run the application
- Node.js environment set up for the backend API

### Installation

```
  1. Clone the repository to your local machine.
  git clone https://github.com/freidev/note-flutter-app.git

  2. Navigate to the cloned directory.
  cd note-flutter-app

  3. Fetch the latest version of Flutter from the stable channel and enable web support (optional).
  flutter channel stable
  flutter upgrade
  flutter config --enable-web

  4. Get the dependencies.
  flutter pub get

  5. Start the emulator or connect your device.

  6. Run the app.
  flutter run
```

## Features

- Create, Read, Update, and Delete functionalities.
- Interaction with a custom REST API.
- Clean and organized code structure.
- Responsive UI for both mobile and web platforms.

## Usage

The app consists of a list that displays data fetched from the REST API. Each item in the list has options to edit or delete. A floating action button allows you to add new items.

## API Configuration

The application expects the API to be running on `http://localhost:3000/`. If your API is running on a different URL, make sure to update the API base URL in the application's configuration file.

## Contributing

Contributions to this project are welcome. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

---

Happy coding!
