<div align="center">
  <img src="Assets/logo/injector-logo.svg" width=400pt/>
  <br>
  <br>
  <div>
      <p>
          <a href="https://swiftpackageindex.com/ptrkstr/Injector"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fptrkstr%2FInjector%2Fbadge%3Ftype%3Dplatforms"/></a>
          <a href="https://swiftpackageindex.com/ptrkstr/Injector"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fptrkstr%2FInjector%2Fbadge%3Ftype%3Dswift-versions"/></a>
            <br>
          <a href="https://github.com/ptrkstr/Injector/actions/workflows/Code Coverage.yml"><img src="https://github.com/ptrkstr/Injector/actions/workflows/Code Coverage.yml/badge.svg"/></a>
          <a href="https://codecov.io/gh/ptrkstr/Injector"><img src="https://codecov.io/gh/ptrkstr/Injector/branch/develop/graph/badge.svg?token=QB0FP6M5ZW"/></a>          
            <br>
          <a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fptrkstr%2FInjector&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false"/></a>
      </p>
  </div>
  <p>
    A Swift package for simple dependency injection that also supports Swift UI previews.
  </p>
</div>

## Features

- :white_check_mark: Built upon the amazing [Factory](https://github.com/hmlongco/Factory)
- ✅ Tiny footprint (`Injector.swift` and `Factory.swift` are the only source files).
- ✅ Built for mocking in UnitTests, UITests and SwiftUI previews.
- ✅ Unit Tested.
- ✅ Cool logo.

## Usage

Injector uses the concept of a **syringe**:

```swift
extension Syringe {

}
```

Filled with **medicine**:

```swift
extension Syringe {
  static let person = Medicine<PersonType>(Person(), mock: Person_Mock())
  static let dog = Medicine<DogType>(Dog(), mock: Dog_Mock())
}
```

And at runtime **injected**:

```swift
let person = Syringe.person.inject()
// or
let person = Syringe.person()
// or
@Inject(Syringe.person) var person
```

Performing a **clean** will reset the instances:

```swif
Syringe.clean()
```

## Installation

### SPM

```
https://github.com/ptrkstr/injector
```
