# Landmark预览
![iPhone 12 Pro_1657098451162](https://user-images.githubusercontent.com/16502006/177557046-6e8c0cd0-05ef-4fbf-a75e-2a90bbac2f07.png)![iPhone 12 Pro_1657098420285](https://user-images.githubusercontent.com/16502006/177557160-61233959-8557-4994-8bbc-b8b2ecb4bec5.png)![iPhone 12 Pro_1657098463546](https://user-images.githubusercontent.com/16502006/177557179-1b464063-792b-4e4a-a7d0-ee4acfde7a1c.png)

# Swift UI的总结
## some View
SwiftUI里View是一个协议，定义了一个关联类型和body变量，几乎所有的控件都遵守了这个View的协议，由于协议里有关联类型或者Self，所以View不能直接当作函数的返回参数使用，为此要加上some的关键字来说明函数返回的是不透明类型。

## ModifiedContent
在一个view上几乎所有的方法调用(像是frame或background)都会将view包装在一个ModifiedContent中
以下Text的实际类型是 ModifiedContent<ModifiedContent<Text, _FrameLayout>, _BackgroundStyleModifier<Color>>
如果不使用不透明类型some的话，就要修改View实际返回的类型，modified调用顺序的不同也会产生不同的类型。
View modifier 所做的事情，并不是改变View上的某个属性，而是用一个带有相关属性的新View来包装原有的View。
```
Text("hello world")
.frame(width: 100, height: 100)
.background(.blue)
```

## 布局
SwiftUI的布局过程是从上而下的：父view向子view建议尺寸，子view将它们布局在这个建议尺寸中，然后返回它们实际需要的尺寸。
建议尺寸和实际尺寸的关系根据view的不同而有所不同。比如说，形状和图片总是会使用全部的建议尺寸，而text view只需要它们的内容所适配占有的尺寸。

## @ViewBuilder
被@ViewBuilder修饰的content会包装成一个TupleView返回，并且最多只接受十个参数，就是十个控件
```
VStack.init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content)
static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(C0, C1)> where C0 : View, C1 : View
```

## 属性包装 Property Wrapper
Swift UI的控件是值类型，是不可变的，要刷新Swift UI控件需要更改属性。
具体选用哪种属性包装方式，取决于你要操作的属性是值类型还是对象，取决于view是只需要可读数据还是需要可读且可写的数据，也取决于view是否拥有这些数据。

### 值类型
view只用只读的方式去使用某个属性，使用普通属性就可以；

@Binging：修饰的属性会变成引用传递，view可以对这个属性进行读写操作，这个属性不属于view，传递时需要加上$符号；

@State：修饰的属性也可以进行读写操作，并且会被Swift UI监听，当属性的值变化时会触发使用到这一属性的Swift UI的更新。对于@State修饰的属性的访问，只能发生在body或者body 所调用的方法中。不能在外部改变@State的值，它的所有相关操作和状态改变都应该是和当前View挂钩的，一般配合private来定义变量只属于当前view。

### 对象类型
@ObservedObject：当指向对象的引用可以发生变化时，使用@ObservedObject，这会让SwiftUI去对所有的变更(通过对象上的objectWillChange publisher)进行订阅。只要对象上的属性发生了变化，SwiftUI 就会渲染这个view。同样地，当传入一个不同的对象时，SwiftUI也会去订阅这个对象，而放弃原来的订阅；

@StateObject：当引用不能改变时，使用@StateObject，它只会让属性在view被首次创建之前初始化一次。当view被重新创建时，同样的引用将会被使用；

@EnvironmentObject：当对象是通过环境进行传递时，使用@EnvironmentObject，SwiftUI的环境系统为对象的注入提供了特殊的支持，那就是使用environmentObject(_:) 修饰器。这个方法接受一个ObservableObject，并将它沿着view树传递下去，即可以在子view里使用这个对象。它不需要指定EnvironmentKey，因为这个对象的类型会自动被用作key。要在view中观察一个环境对象，使用@EnvironmentObject属性包装。这会使view在被观察对象的objectWillChange publisher被触发时失效并重绘。和@ObservedObject不同，@EnvironmentObject不会在类型中自动创建变量，即变量是通过Environment去传递的，而不是初始化进行传递的，所以View初始化时不需要初始化此变量。

## protocol ObservableObject
ObservableObject协议的唯一要求是实现objectWillChange，它是一个publisher，会在对象变更时发送事件。当自定义的对象遵守ObservableObject协议时，通过在属性前面添加@Published，Combine框架会为我们创建一个objectWillChange的实现，在每次这个属性发生改变的时候发送事件通知订阅的UI进行更新。

## Combine
Combine框架是为Swift UI服务的响应式数据处理框架，最核心的是Publisher和Subscriber，即事件发布和事件订阅，两个协议定义了成为发布者和订阅者的条件。
Publisher最主要的两个工作是发布新的事件及其数据，以及准备好被Subscriber订阅。
Subscriber想要订阅某个Publisher，Subscriber中的Input和Failure必须与Publisher的Output和Failure类型一致。
Swift UI的更新是由状态驱动View，View是被动的响应状态的变化，可以把View看成是响应状态改变的函数，而状态改变就是发布的事件。

## SwiftUI与UIKit
要把UIKit的控件转换成Swift UI的控件，需要遵守UIViewRepresentable协议，协议中的makeUIView(context:) 需要返回想要封装的UIView类型，SwiftUI在创建一个被封装的UIView 时会对其调用。updateUIView(_:context:) 则在UIViewRepresentable中的某个属性发生变化，SwiftUI 要求更新该 UIKit 部件时被调用。
把Swift UI给UIKit的控件使用时用UIHostingController<Content> : UIViewController where Content : View，初始化时init(rootView: Content)传入一个Swift UI的View。

## 内置图标库 (SF Symbols)
SF Symbols是从iOS13开始内置于系统中的字符图标库，提供了常见的线条图标，而且可以任意地为它们设置尺寸，颜色等属性。SwiftUI的Image提供了Image(systemName:) 来通过符号名生成对应图片。这种“图片”相对特殊，它的行为更接近于字体，实际上SF Symbols就是San Francisco字体的一部分，所以可以用 .font 和 .foregroundColor等来对它进行设置。
官方软件地址：https://developer.apple.com/sf-symbols/
