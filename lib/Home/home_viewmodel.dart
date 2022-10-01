import 'dart:async';
import 'dart:core';
import 'package:blind_ai/API/api_object.dart';
import 'package:blind_ai/API/api_read_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../API/api_currency.dart';
import '../API/api_sos.dart';
import '../Image/image.dart';
import 'package:camera/camera.dart';

class HomeViewModel extends BaseViewModel {
  TextToSpeech tts = TextToSpeech();

  bool _isLoading = false;
  get isLoading => _isLoading;

  void setSystemLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setSystemFree() {
    _isLoading = false;
    notifyListeners();
  }

  void setUpVoice() {
    tts.setVolume(1);
    tts.setPitch(2);
  }

  // One
  Future<void> onTapOne() async {
    setSystemLoading();
    setUpVoice();
    await tts.speak("SOS");
    onDoubleTapOne();
  }

  Future<void> onDoubleTapOne() async {
    await apiSOS();
    await tts.speak("Alerted the SOS Contacts");
    setSystemFree();
  }

  // Two
  Future<void> onTapTwo() async {
    setSystemLoading();
    setUpVoice();
    await tts.speak("Read Text");
    onDoubleTapTwo();
  }

  Future<void> onDoubleTapTwo() async {
    setUpVoice();
    XFile? image = await pickImageFromCamera();
    if (image != null) {
      String? response = await apiReadText(path: image.path);
      await tts.speak(response);
    }
    setSystemFree();
  }

  // Three
  Future<void> onTapThree() async {
    setSystemLoading();
    setUpVoice();
    await tts.speak("Detect Object");
    onDoubleTapThree();
  }

  Future<void> onDoubleTapThree() async {
    setUpVoice();
    XFile? image = await pickImageFromCamera();
    if (image != null) {
      String? response = await apiObject(path: image.path);
      await tts.speak(response);
    }
    setSystemFree();
  }

  // Four
  Future<void> onTapFour() async {
    setSystemLoading();
    setUpVoice();
    await tts.speak("Check Currency");
    onDoubleTapFour();
  }

  Future<void> onDoubleTapFour() async {
    setUpVoice();
    XFile? image = await pickImageFromCamera();
    if (image != null) {
      String? response = await apiCurrency(path: image.path);
      await tts.speak(response);
    }
    setSystemFree();
  }

  // Voice Button
  Future<void> onTapVoice() async {
    setSystemLoading();
    setUpVoice();
    await tts.speak("Mike");
    setSystemFree();
  }

  void onDoubleTapVoice() {}
}
