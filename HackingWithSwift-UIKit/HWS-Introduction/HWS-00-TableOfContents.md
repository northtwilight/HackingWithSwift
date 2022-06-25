# Paul Hudson, Hacking with Swift 

## Start Here

### Introduction
Hello, my name is Paul Hudson, and I run a website called hackingwithswift.com. I’ve written more books about Swift than anyone else in the world, so if you want to learn Swift in a fast and easy way you’ve come to the right person.

This series is called Swift in Sixty Seconds, because each part teaches you one distinct Swift concept in just one minute or less. So, there’s no time for me to go off on tangents, and there’s no time for those annoying “hey what’s up you guys it’s me again” intros that are so common on YouTube.

Instead, you should sit back and prepare to learn Swift in bite-size chunks.

Most Swift code is written using Apple’s development environment, Xcode. You should install Xcode from the Mac App Store, then go ahead and run it before continuing.

Are you all set? Let’s go!

## Simple types

### Variables
When you launch Xcode it will ask you what you want to do, and I’d like you to choose “Get Started with a Playground” – this is a sandbox where you can type Swift code and see immediate results.

The default is a blank playground for iOS, which is fine, so click Next then Create to save it on your desktop.

In this video I want to introduce you to variables, which are places where you can store program data. They are called variables because they can vary – you can change their values freely.

Playgrounds start with a line of code that creates a variable for us:

`var str = "Hello, playground"`

That creates a new variable called str, giving it the value “Hello, playground”. On the right of the playground you can see “Hello, playground” in the output area – that’s Xcode showing us the value was set.

Because str is a variable we can change it:

`str = "Goodbye"`

We don’t need var the second time because the variable has already been created – we’re just changing it.
### Strings and integers
Swift is what’s known as a type-safe language, which means that every variable must be of one specific type. The str variable that Xcode created for us holds a string of letters that spell “Hello, playground”, so Swift assigns it the type String.

On the other hand, if we want to store someone’s age we might make a variable like this:

`var age = 38`

That holds a whole number, so Swift assigns the type Int – short for “integer”.

If you have large numbers, Swift lets you use underscores as thousands separators – they don’t change the number, but they do make it easier to read. For example:

`var population = 8_000_000`

Strings and integers are different types, and they can’t be mixed. So, while it’s safe to change str to “Goodbye”, I can’t make it 38 because that’s an Int not a String.
### Multi-line strings
Standard Swift strings use double quotes, but you can’t include line breaks in there.

If you want multi-line strings you need slightly different syntax: start and end with three double quote marks, like this:

```
var str1 = """
This goes
over multiple
lines
"""
```

Swift is very particular about how you write those quote marks: the opening and closing triple must be on their own line, but opening and closing line breaks won’t be included in your final string.

If you only want multi-line strings to format your code neatly, and you don’t want those line breaks to actually be in your string, end each line with a \, like this:

```
var str2 = """
This goes \
over multiple \
lines
"""
```
### Doubles and booleans
Two other basic types of data in Swift are doubles and booleans, and you’ll be using them a lot.

“Double” is short for “double-precision floating-point number”, and it’s a fancy way of saying it holds fractional values such as 38.1, or 3.141592654.

Whenever you create a variable with a fractional number, Swift automatically gives that variable the type Double. For example:

`var pi = 3.141`

Doubles are different from integers, and you can’t mix them by accident.

As for booleans, they are much simpler: they just hold either true or false, and Swift will automatically assign the boolean type to any variable assigned either true or false as its value.

For example:

`var awesome = true`

### String interpolation
You’ve seen how you can type values for strings directly into your code, but Swift also has a feature called string interpolation – the ability to place variables inside your strings to make them more useful.

You can place any type of variable inside your string – all you have to do is write a backslash, \, followed by your variable name in parentheses. For example:

```
var score = 85
var str = "Your score was \(score)"
```

As you can see in the playground output, that sets the str variable to be “Your score was 85”.

You can do this as many times as you need, making strings out of strings if you want:

`var results = "The test results are here: \(str)"`

As you’ll see later on, string interpolation isn’t just limited to placing variables – you can actually run code inside there.
### Constants
I already said that variables have that name because their values can change over time, and that is often useful. However, very often you want to set a value once and never change it, and so we have an alternative to the var keyword called let.

The let keyword creates constants, which are values that can be set once and never again. For example:

`let taylor = "swift"`

If you try to change that, Xcode will refuse to run your code. It’s a form of safety: when you use constants you can no longer change something by accident.

When you write your own Swift code, you should always use let unless you specifically want to change a value. In fact, Xcode will warn you if you use var then don’t change the variable.
### Type annotations
Swift assigns each variable and constant a type based on what value it’s given when it’s created. So, when you write code like this Swift can see it holds a string:

`let str = "Hello, playground"`

That will make str a string, so you can’t try to assign it an integer or a boolean later on. This is called type inference: Swift is able to infer the type of something based on how you created it.

If you want you can be explicit about the type of your data rather than relying on Swift’s type inference, like this:

```
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true
```

Notice that booleans have the short type name Bool, in the same way that integers have the short type name Int.
### Simple types: Summary
You’ve made it to the end of the first part of this series, so let’s summarize.

1.    You make variables using var and constants using let. It’s preferable to use constants as often as possible.
2.    Strings start and end with double quotes, but if you want them to run across multiple lines you should use three sets of double quotes.
3.    Integers hold whole numbers, doubles hold fractional numbers, and booleans hold true or false.
4.    String interpolation allows you to create strings from other variables and constants, placing their values inside your string.
5.    Swift uses type inference to assign each variable or constant a type, but you can provide explicit types if you want.

## Complex types
### Arrays
Arrays are collections of values that are stored as a single value. For example, John, Paul, George, and Ringo are names, but arrays let you group them in a single value called The Beatles.

In code, we write this:

```
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
```

That last line makes the array: it starts and ends with brackets, with each item in the array separated by a comma.

You can read values from an array by writing a number inside brackets. Array positions count from 0, so if you want to read “Paul McCartney” you would write this:

`beatles[1]`

Be careful: Swift crashes if you read an item that doesn’t exist. For example, trying to read beatles[9] is a bad idea.

Note: If you’re using type annotations, arrays are written in brackets: [String], [Int], [Double], and [Bool].

### Sets
Sets are collections of values just like arrays, except they have two differences:

    Items aren’t stored in any order; they are stored in what is effectively a random order.
    No item can appear twice in a set; all items must be unique.

You can create sets directly from arrays, like this:

`let colors = Set(["red", "green", "blue"])`

When you look at the value of colors inside the playground output you’ll see it doesn’t match the order we used to create it. It’s not really a random order, it’s just unordered – Swift makes no guarantees about its order. Because they are unordered, you can’t read values from a set using numerical positions like you can with arrays.

If you try to insert a duplicate item into a set, the duplicates get ignored. For example:

`let colors2 = Set(["red", "green", "blue", "red", "blue"])`

The final colors2 set will still only include red, green, and blue once.
### Tuples
Tuples allow you to store several values together in a single value. That might sound like arrays, but tuples are different:

    You can’t add or remove items from a tuple; they are fixed in size.
    You can’t change the type of items in a tuple; they always have the same types they were created with.
    You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.

Tuples are created by placing multiple items into parentheses, like this:

`var name = (first: "Taylor", last: "Swift")`

You then access items using numerical positions starting from 0:

`name.0`

Or you can access items using their names:

`name.first`

Remember, you can change the values inside a tuple after you create it, but not the types of values. So, if you tried to change name to be (first: "Justin", age: 25) you would get an error.
### Arrays vs sets vs tuples
Arrays, sets, and tuples can seem similar at first, but they have distinct uses. To help you know which to use, here are some rules.

If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a tuple:

`let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")`

If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a set:

`let set = Set(["aardvark", "astronaut", "azalea"])`

If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array:

`let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]`

Arrays are by far the most common of the three types.

### Dictionaries
Dictionaries are collections of values just like arrays, but rather than storing things with an integer position you can access them using anything you want.

The most common way of storing dictionary data is using strings. For example, we could create a dictionary that stores the height of singers using their name:

```
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
```
Just like arrays, dictionaries start and end with brackets and each item is separated with a comma. However, we also use a colon to separate the value you want to store (e.g. 1.78) from the identifier you want to store it under (e.g. “Taylor Swift”).

These identifiers are called keys, and you can use them to read data back out of the dictionary:

`heights["Taylor Swift"]`

Note: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example, [String: Double] and [String: String].
### Dictionary default values
If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all. While this might be what you want, there’s an alternative: we can provide the dictionary with a default value to use if we request a missing key.

To demonstrate this, let’s create a dictionary of favorite ice creams for two people:
```
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
```
We can read Paul’s favorite ice cream like this:

`favoriteIceCream["Paul"]`

But if we tried reading the favorite ice cream for Charlotte, we’d get back nil, meaning that Swift doesn’t have a value for that key:

`favoriteIceCream["Charlotte"]`

We can fix this by giving the dictionary a default value of “Unknown”, so that when no ice cream is found for Charlotte we get back “Unknown” rather than nil:

`favoriteIceCream["Charlotte", default: "Unknown"]`
### Creating empty collections
Arrays, sets, and dictionaries are called collections, because they collect values together in one place.

If you want to create an empty collection just write its type followed by opening and closing parentheses. For example, we can create an empty dictionary with strings for keys and values like this:

`var teams = [String: String]()`

We can then add entries later on, like this:

`teams["Paul"] = "Red"`

Similarly, you can create an empty array to store integers like this:

`var results = [Int]()`

The exception is creating an empty set, which is done differently:
```
var words = Set<String>()
var numbers = Set<Int>()
```

This is because Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.

If you wanted, you could create arrays and dictionaries with similar syntax:
```
var scores = Dictionary<String, Int>()
var results = Array<Int>()
```
### Enumerations

### Enum associated values
### Enum raw values
### Complex types: Summary

## Operators and conditions

### Arithmetic Operators
### Operator overloading
### Compound assignment operators
### Comparison operators
### Conditions
### Combining operators
### The ternary operator
### Switch statements
### Range operators
### Operators and conditions summary

## Looping
### For loops
### While loops
### Repeat loops
### Exiting loops
### Exiting multiple loops
### Skipping items
### Infinite loops
### Looping summary

## Functions

### Writing functions
### Accepting parameters
### Returning values
### Parameter labels
### Omitting parameter labels
### Default parameters
### Variadic functions
### Writing throwing functions
### Running throwing functions
### inout parameters
### Functions summary

## Closures

### Creating basic closures
### Accepting parameters in a closure
### Returning values from a closure
### Closures as parameters
### Trailing closure syntax
### Using closures as parameters when they accept parameters
### Using closures as parameters when they return values
### Shorthand parameter names
### Closures with multiple parameters
### Returning closures from functions
### Capturing values
### Closures summary

## Structs

### Creating your own structs
### Computed properties
### Property observers
### Methods
### Mutating methods
### Properties and methods of strings
### Properties and methods of arrays
### Initializers
### Referring to the current instance
### Lazy properties
### Static properties and methods
### Access control
### Structs summary

## Classes

### Creating your own classes
### Class inheritance
### Overriding methods
### Final classes
### Copying objects
### Deinitializers
### Mutability
### Classes summary

## Protocols and extensions

### Protocols
### Protocol inheritance
### Extensions
### Protocol extensions
### Protocol-oriented programming
### Protocols and extensions summary

## Optionals

### Handling missing data
### Unwrapping optionals
### Unwrapping with guard
### Force unwrapping
### Implicitly unwrapped optionals
### Nil coalescing
### Optional chaining
### Optional try
### Failable initializers
### Typecasting
### Optionals summary

## Conclusion

### Where now?
