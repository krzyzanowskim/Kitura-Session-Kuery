# Kitura-Session-Kuery
Kitura-Session store using [Swift-Kuery](https://github.com/IBM-Swift/Swift-Kuery) as the backing store

![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

## Summary
 [Kitura-Session](https://github.com/IBM-Swift/Kitura-Session) store using [Swift-Kuery](https://github.com/IBM-Swift/Swift-Kuery) as the backing store

## Table of Contents
* [Swift version](#swift-version)
* [API](#api)
* [License](#license)

## Swift version
The latest version of Kitura-Session-Kuery requires **Swift 4.0.3**. You can download this version of the Swift binaries by following this [link](https://swift.org/download/). Compatibility with other Swift versions is not guaranteed.

## API
In order to use Kuery as session store, create an instance of `KueryStore`, and pass it to `Session` constructor:

```swift
import KituraSession
import KituraSessionKuery

let pool = ...
guard let connection = pool.getConnection() else {
    // Error
}

let kueryStore = KueryStore(connection: kueryConnection)
let session = Session(secret: <secret>, store: kueryStore)
```

## License
This library is licensed under MIT. Full license text is available in [LICENSE](LICENSE).