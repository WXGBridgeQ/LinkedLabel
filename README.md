# LinkedLabel

LinkedLabel, written in Swift

## Demo

![](http://7xk1wz.com1.z0.glb.clouddn.com/LinkedLabel.gif)

## Usage

```swift
label.addLinks([
    (string: "Ut enim ad minim veniam", attributes: [.foregroundColor: UIColor.red], action: { print($0) }),
    (string: "Duis aute irure dolor in reprehenderit", attributes: [.foregroundColor: UIColor.green], action: { print($0) }),
    (string: "Excepteur sint occaecat cupidatat non proident", attributes: [.foregroundColor: UIColor.blue], action: { print($0) })
])
```
