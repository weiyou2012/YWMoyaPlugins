# YWMoyaPlugins

[![CI Status](https://img.shields.io/travis/dyang@micmd.com/YWMoyaPlugins.svg?style=flat)](https://travis-ci.org/dyang@micmd.com/YWMoyaPlugins)
[![Version](https://img.shields.io/cocoapods/v/YWMoyaPlugins.svg?style=flat)](https://cocoapods.org/pods/YWMoyaPlugins)
[![License](https://img.shields.io/cocoapods/l/YWMoyaPlugins.svg?style=flat)](https://cocoapods.org/pods/YWMoyaPlugins)
[![Platform](https://img.shields.io/cocoapods/p/YWMoyaPlugins.svg?style=flat)](https://cocoapods.org/pods/YWMoyaPlugins)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YWMoyaPlugins is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YWMoyaPlugins'
```

## How to use

**YWMoyaLogPlugin**

```swift
    let provider = MoyaProvider(plugins: [YWLogPlugin()])
    ... more code
```
When request some info, you can see some log info in Xcode. 🎉

**YWAlertManagerUIPlugin**

```swift
    class NetworkAlertUiManager: TipManagerUIDelegate {
      
      func alertProgress() {
        ... UI code
      }
      func hideProgressAlert() {
        ... UI code
      }
      func alertMessageSuccess(response: Response) {
        ... UI code
      }
      func alertMessageFailure(moyaError: MoyaError) {
        ... UI code
      }
    }

    let alertManagerPlugin = YWAlertManagerPlugin()
    alertManagerPlugin.tipDelegate = NetworkAlertUiManager()
    let provider = MoyaProvider(plugins: [alertManagerPlugin])
    ... more code
```

After the plug-in is set up, you can implement some actions in the corresponding callback.

 It is commonly used in scenarios such as delay notification, response message notification, and network error notification.

## License

YWMoyaPlugins is available under the MIT license. See the LICENSE file for more info.
