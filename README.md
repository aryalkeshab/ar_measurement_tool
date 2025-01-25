# AR Measurement Tool App

This is an iOS-exclusive AR Measurement Tool app built using Flutter and the ARKit plugin. The app allows users to measure real-world objects accurately using augmented reality. It leverages the ARKit framework to provide a seamless and intuitive AR experience.

---

## Features

- **AR Object Measurement**: Measure the length, width, and height of objects in real-world space.
- **User-Friendly Interface**: Simple and clean design for easy navigation.
- **Real-Time Object Detection**: Automatically detects objects in the AR view for precise measurement.

---

## Requirements

- **iOS Device**: The app is built for iOS and utilizes ARKit, which is supported only on devices running iOS 11.0 or later.
- **Flutter SDK**: Ensure that Flutter is installed on your system.
- **ARKit Plugin**: The app relies on the [arkit_plugin](https://pub.dev/packages/arkit_plugin).

---

## Installation Instructions

1. **Clone the Repository**:

   ```bash
   git clone <repository_url>
   cd ar_measurement_tool
   ```

2. **Install Dependencies**:
   Ensure that all required packages are installed by running:

   ```bash
   flutter pub get
   ```

3. **Open in Xcode**:
   Since this app requires ARKit, you need to open the iOS project in Xcode:

   ```bash
   open ios/Runner.xcworkspace
   ```

4. **Set Deployment Target**:

   - Open the `Runner` project in Xcode.
   - Navigate to `Build Settings` and set the **iOS Deployment Target** to 11.0 or later.

5. **Build and Run**:
   - Connect your iOS device.
   - Run the app using:
     ```bash
     flutter run
     ```
   - Ensure that your device supports ARKit.

---

## Approach

The app uses the `arkit_plugin` to integrate ARKit features into the Flutter app. The approach involved:

1. **AR Session Initialization**: Setting up an AR session using ARKit to detect surfaces and objects in the real world.
2. **Object Detection**: Identifying and tracking objects in the AR view to measure their dimensions accurately.
3. **Measurement Logic**: Using ARKit's distance calculation features to compute lengths and dimensions between detected points in 3D space.
4. **User Interface**: Creating a Flutter-based user-friendly UI that interacts with the ARKit functionalities seamlessly.

---

## Challenges Faced

1. **Object Detection in AR View**:

   - **Issue**: Detecting objects accurately in the AR view was challenging due to lighting conditions and variations in object textures.
   - **Solution**: Adjusted ARKit's configuration settings to improve surface detection and optimized point cloud visualization to enhance object tracking accuracy.

2. **ARKit Compatibility**:

   - Ensuring compatibility with specific iOS versions and ARKit-supported devices was a key concern.
   - Fixed by setting strict deployment targets and adding detailed instructions to ensure proper setup.

3. **Debugging AR Features**:
   - Debugging AR functionalities within a Flutter environment required extensive testing on physical devices, as ARKit does not work on simulators.

---

## How to Use

1. **Launch the App**: Open the app on your ARKit-compatible iOS device.
2. **Point and Measure**: Point your camera at an object and tap on the screen to measure its dimensions.
3. **View Measurements**: The app displays the measured values in real-time on the AR view.

---

## Contributing

If you'd like to contribute:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.

---

---

## Contact

For any queries or issues, feel free to contact me at keshabaryal03@gmail.com
