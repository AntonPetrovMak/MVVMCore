# Clean Architecture + MVVM + Router

## Clean Architecture

Clean architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of clean architecture is that code dependencies can only come from the outer levels inward.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83876559-b8997900-a741-11ea-8c7b-5d559778b9f8.png" >
</div>

* Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models), Workers, and Store Interfaces. This layer could be potentially reused within different projects. Such separation allows for not using the host app within the test target because no dependencies (also 3rd party) are needed — this makes the Domain Workers tests take just a few seconds. Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)
* Presentation Layer contains UI. Views are coordinated by ViewModels (Presenters) which execute one or many Workers Presentation Layer depends only on the Domain Layer.
* Data Layer contains Store Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data to Domain Models.

## Dependency Direction
* Presentation Layer (MVVM) = ViewModels + Views(UI)
* Domain Layer = Entities + Workers + Store Interfaces
* Data Store Layer = Store Implementations + API(Network) + Persistence DB

# MVVM

The Model-View-ViewModel (MVVM) pattern is a UI design pattern. It provides a clean separation of concerns between the UI and Domain.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83877081-948a6780-a742-11ea-86e5-a3bd5ef7ab63.png" >
</div>

**Responsibilities:**

* **ViewModel** - The primary responsibility of the ViewModel is to provide data to the view, so that view can put that data on the screen. The ViewModel should not contain any UI components or parts. The best way to achieve this it avoids importing UIKit or any UI frameworks.
* **View** - The main purpose and responsibilities of views is to define the structure of what the user sees on the screen. The View should not contain any business logic just UI.
* **Model** - It is the client side data model that supports the views in the application.

The relationships between the three components of the MVVM pattern, just following these strict rules:
* The View has a reference to the ViewModel through the protocol, but not vice-versa.
* The ViewModel has a reference to the Model, but not vice-versa.
* The View has no reference to the Model or vice-versa. 

# Data Binding

Data Binding between View and ViewModel can be done for example with closures, delegates or observables (e.g. RxSwift). Combine and SwiftUI also can be used but only if our minimum supported iOS system is 13. The View has a direct relationship to ViewModel and notifies it whenever an event inside View happens. From ViewModel, there is no direct reference to View (only Data Binding)

In this project, we will use a simple combination of Closure and didSet to avoid third-party dependencies. It is **Observable** class. (Need to add link)

```
// SomeViewModel.swift

var isLoading: Observable<Bool> = Observable(false)

... 
// notify ViewController that loading begins
isLoading.value = true
...

//  SomeViewController.swift

if bind(_ viewModel: ViewModelProtocol) {
  viewModel.isLoading.observe(on: self) { [weak self] in 
    self?.setRefreshControl(isLoading: $0) 
  }
}
```
# MVVM base interfaces

Using any of the architectural patterns, we need to rely on base classes or protocols. This core ensures the integrity of the architecture. Since Swift is a protocol-oriented language and is easy to work with, we will use a protocol approach.

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83877405-2a25f700-a743-11ea-89eb-9f4b2cbfc5f8.png" >
</div>

**Entities descriptions:**

* **MVVMViewModel** - As use can see on diagram above, ViewModel has not any references to ViewController. So in the ViewModel focused a business logic and it determines when to make transitions. The ViewModel should know about the Router and keep strong reference on it, that have opportunity to notify the router in time.

* **MVVMViewController** - ViewController must maintain a strong link to the ViewModel. Do not use the MVVMViewModel interface as associated type in ViewController, since we should not have access to the router through the ViewModel. We must define our custom protocol, which will be implemented by ViewModel and set it as associated type in ViewController.

* **MVVMRouter** - Router must keep a weak reference on ViewController that avoids a retain cycle. It is worth noting that the router keeps a reference to the base controller and transfers it from module to module. As result that every modul can have a reference to the base controller (not parent).

# Мodule example

<div align="center">
<img src="https://user-images.githubusercontent.com/15180933/83881377-357c2100-a749-11ea-9607-4b31f03bb260.png" >
</div>

# Templates

* [Download archive by link](https://drive.google.com/file/d/18ZsVgFIXLXTjgRB8t_NoO08ipaTOKrmH)
* MVVM Core Templates.zip and unarchive it.
* We need to navigate to where Xcode stores its templates. 
  * In Finder, press **Cmd+Shift+G** to bring up the _“Go to the folder…”_ prompt.
  * Enter in this path:~/Library/Developer/Xcode/Templates/File Templates/
* Move the MVVM Core folder to File Templates directory.
* Reload Xcode.
