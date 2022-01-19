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

- ✅ Tiny footprint (`Injector.swift` and `Resolver.swift` are the only source files).
- ✅ Supports SwiftUI previews.
- ✅ Great unit tests.
- ✅ Cool logo.

## Usage

```swift
import Injector

Injector.setup {
    $0.register(Person(), mock: Person_Mock(), for: PersonType.self)
    $0.register(Cat(), mock: Cat_Mock(), for: CatType.self)
}

let person = inject(PersonType.self)
let cat = inject(CatType.self)
```

## Why should my main app contain the mocks?

This is so mocks can be used in SwiftUI previews. I couldn't find an alternative way but would be glad to hear it if you had one.

## Installation

### SPM

Add the following to your project:  

```
https://github.com/ptrkstr/injector
```
