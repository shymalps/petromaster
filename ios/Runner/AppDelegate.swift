// ios/Runner/AppDelegate.swift
//
// REPLACE your existing AppDelegate.swift with this file.
// This adds the UITextField-based screen protection required by
// the screen_protector package on iOS.

import Flutter
import UIKit
import screen_protector  

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {


    ScreenProtectorPlugin.setWindow(window)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}