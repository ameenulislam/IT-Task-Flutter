A Flutter Web application that allows users to load and display an image from a URL. It also provides fullscreen viewing functionality with a floating action menu for toggling fullscreen mode.

🚀 Features
📷 Load Image from URL – Enter an image URL to display it in a resizable container.
🔍 Fullscreen Mode – Double-click the image or use the menu to toggle fullscreen mode.
🎨 Blurred Menu Overlay – A floating action button opens a menu with options to enter or exit fullscreen mode.
⚡ Optimized for Web – Uses dart:html and dart:js for seamless browser integration.
📂 Project Structure
bash
Copy
Edit
/lib
 ├── main.dart       # Entry point of the app
 ├── home_page.dart  # HomePage widget with image viewer functionality
 ├── widgets         # (Optional) Future UI components
🛠️ Technologies Used
Flutter (Web Support)
Dart
HTML & JavaScript Integration (dart:html and dart:js)
🖥️ Getting Started
1️⃣ Prerequisites
Install Flutter (latest stable version)
Enable web support:
sh
Copy
Edit
flutter config --enable-web
2️⃣ Clone the Repository
sh
Copy
Edit
git clone https://github.com/your-username/flutter-web-image-viewer.git
cd flutter-web-image-viewer
3️⃣ Run the App
sh
Copy
Edit
flutter run -d chrome
📝 Usage
Enter an image URL in the text field.
Click the arrow button to load the image.
Double-click the image to toggle fullscreen.
Use the floating action button to open the menu.
Select Enter Fullscreen or Exit Fullscreen.