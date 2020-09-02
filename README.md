# Voice match application

This is my Advanced diploma final year project to match voices from this mobile application.

## Getting Started

To get started with this project  you must have an understanding of Flutter SDK and  have access to our backend API endpoints(which is not yet released for public uses)
 which serves to process voices sent via this application

Few resources to get started with this demo mobile application you:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation
-You should have Flutter SDK Installed
- Clone this project into your computer
- In you terminal,go to project root folder and run <code>flutter pub get</code>

## Medcorder setup

Recorded file paths setup
- Edit medcorder_plugins <code>Flutter Plugins/medcorder_audio-0.0.6/android/src/main/java/co/medcorder/medcorderaudio/MedcorderAudioPlugins</code>
- Add below codes 
    - <code>import android.os.Environment;</code>
    - <code> import java.io.File;</code>
    - Line 51
        - <code>private String outputFilePath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/Voicematch/audio/";</code>
    - Line 128 ~ 130
         <code>
         File outputFolder = new File(outputFilePath);
         //      currentOutputFile = activity.getApplicationContext().getFilesDir() + "/" + fileName + ".aac";
               currentOutputFile =  outputFilePath+""+ fileName + ".aac";
               if(!outputFolder.exists()) outputFolder.mkdirs();
         </code>
 
    - Line 237 ~ 239
        <code>
        File outputFolder = new File(outputFilePath);
         currentPlayingFile =  outputFilePath+""+ fileName + ".aac";
         if(!outputFolder.exists()) outputFolder.mkdirs();
        </code>
