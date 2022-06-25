# Paul Hudson, Hacking with Swift 

## I. Start Here

### Introduction
Hello, my name is Paul Hudson, and I run a website called hackingwithswift.com. I’ve written more books about Swift than anyone else in the world, so if you want to learn Swift in a fast and easy way you’ve come to the right person.

This series is called Swift in Sixty Seconds, because each part teaches you one distinct Swift concept in just one minute or less. So, there’s no time for me to go off on tangents, and there’s no time for those annoying “hey what’s up you guys it’s me again” intros that are so common on YouTube.

Instead, you should sit back and prepare to learn Swift in bite-size chunks.

Most Swift code is written using Apple’s development environment, Xcode. You should install Xcode from the Mac App Store, then go ahead and run it before continuing.

Are you all set? Let’s go!

## II. Simple types

### Variables
When you launch Xcode it will ask you what you want to do, and I’d like you to choose “Get Started with a Playground” – this is a sandbox where you can type Swift code and see immediate results.

The default is a blank playground for iOS, which is fine, so click Next then Create to save it on your desktop.

In this video I want to introduce you to variables, which are places where you can store program data. They are called variables because they can vary – you can change their values freely.

Playgrounds start with a line of code that creates a variable for us:
```swift
var str = "Hello, playground"
```

That creates a new variable called str, giving it the value “Hello, playground”. On the right of the playground you can see “Hello, playground” in the output area – that’s Xcode showing us the value was set.

Because str is a variable we can change it:

```swift
str = "Goodbye"
```
We don’t need var the second time because the variable has already been created – we’re just changing it.
### Strings and integers
Swift is what’s known as a type-safe language, which means that every variable must be of one specific type. The str variable that Xcode created for us holds a string of letters that spell “Hello, playground”, so Swift assigns it the type String.

On the other hand, if we want to store someone’s age we might make a variable like this:
```swift
var age = 38
```
That holds a whole number, so Swift assigns the type Int – short for “integer”.

If you have large numbers, Swift lets you use underscores as thousands separators – they don’t change the number, but they do make it easier to read. For example:
```swift
var population = 8_000_000
```
Strings and integers are different types, and they can’t be mixed. So, while it’s safe to change str to “Goodbye”, I can’t make it 38 because that’s an Int not a String.
### Multi-line strings
Standard Swift strings use double quotes, but you can’t include line breaks in there.

If you want multi-line strings you need slightly different syntax: start and end with three double quote marks, like this:

```swift
var str1 = """
This goes
over multiple
lines
"""
```

Swift is very particular about how you write those quote marks: the opening and closing triple must be on their own line, but opening and closing line breaks won’t be included in your final string.

If you only want multi-line strings to format your code neatly, and you don’t want those line breaks to actually be in your string, end each line with a \, like this:

```swift
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

```swift
var pi = 3.141
```
Doubles are different from integers, and you can’t mix them by accident.

As for booleans, they are much simpler: they just hold either true or false, and Swift will automatically assign the boolean type to any variable assigned either true or false as its value.

For example:

```swift
var awesome = true
```

### String interpolation
You’ve seen how you can type values for strings directly into your code, but Swift also has a feature called string interpolation – the ability to place variables inside your strings to make them more useful.

You can place any type of variable inside your string – all you have to do is write a backslash, \, followed by your variable name in parentheses. For example:

```swift
var score = 85
var str = "Your score was \(score)"
```

As you can see in the playground output, that sets the str variable to be “Your score was 85”.

You can do this as many times as you need, making strings out of strings if you want:

```swift
var results = "The test results are here: \(str)"
```

As you’ll see later on, string interpolation isn’t just limited to placing variables – you can actually run code inside there.
### Constants
I already said that variables have that name because their values can change over time, and that is often useful. However, very often you want to set a value once and never change it, and so we have an alternative to the var keyword called let.

The let keyword creates constants, which are values that can be set once and never again. For example:

```swift
let taylor = "swift"
```

If you try to change that, Xcode will refuse to run your code. It’s a form of safety: when you use constants you can no longer change something by accident.

When you write your own Swift code, you should always use let unless you specifically want to change a value. In fact, Xcode will warn you if you use var then don’t change the variable.
### Type annotations
Swift assigns each variable and constant a type based on what value it’s given when it’s created. So, when you write code like this Swift can see it holds a string:

```swift
let str = "Hello, playground"
```

That will make str a string, so you can’t try to assign it an integer or a boolean later on. This is called type inference: Swift is able to infer the type of something based on how you created it.

If you want you can be explicit about the type of your data rather than relying on Swift’s type inference, like this:

```swift
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

## III. Complex types
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

```swift
beatles[1]
```

Be careful: Swift crashes if you read an item that doesn’t exist. For example, trying to read beatles[9] is a bad idea.

Note: If you’re using type annotations, arrays are written in brackets: [String], [Int], [Double], and [Bool].

### Sets
Sets are collections of values just like arrays, except they have two differences:

    Items aren’t stored in any order; they are stored in what is effectively a random order.
    No item can appear twice in a set; all items must be unique.

You can create sets directly from arrays, like this:

```swift
let colors = Set(["red", "green", "blue"])
```

When you look at the value of colors inside the playground output you’ll see it doesn’t match the order we used to create it. It’s not really a random order, it’s just unordered – Swift makes no guarantees about its order. Because they are unordered, you can’t read values from a set using numerical positions like you can with arrays.

If you try to insert a duplicate item into a set, the duplicates get ignored. For example:

```swift
let colors2 = Set(["red", "green", "blue", "red", "blue"])
```

The final colors2 set will still only include red, green, and blue once.
### Tuples
Tuples allow you to store several values together in a single value. That might sound like arrays, but tuples are different:

• You can’t add or remove items from a tuple; they are fixed in size.
• You can’t change the type of items in a tuple; they always have the same types they were created with.
• You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.

Tuples are created by placing multiple items into parentheses, like this:

```swift
var name = (first: "Taylor", last: "Swift")
```

You then access items using numerical positions starting from 0:

```swift
name.0
```

Or you can access items using their names:

```swift
name.first
```

Remember, you can change the values inside a tuple after you create it, but not the types of values. So, if you tried to change name to be (first: "Justin", age: 25) you would get an error.
### Arrays vs sets vs tuples
Arrays, sets, and tuples can seem similar at first, but they have distinct uses. To help you know which to use, here are some rules.

If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a tuple:

```swift
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
```

If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a set:

```swift
let set = Set(["aardvark", "astronaut", "azalea"])
```

If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array:

```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
```

Arrays are by far the most common of the three types.

### Dictionaries
Dictionaries are collections of values just like arrays, but rather than storing things with an integer position you can access them using anything you want.

The most common way of storing dictionary data is using strings. For example, we could create a dictionary that stores the height of singers using their name:

```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
```
Just like arrays, dictionaries start and end with brackets and each item is separated with a comma. However, we also use a colon to separate the value you want to store (e.g. 1.78) from the identifier you want to store it under (e.g. “Taylor Swift”).

These identifiers are called keys, and you can use them to read data back out of the dictionary:

```swift
heights["Taylor Swift"]
```

Note: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example, [String: Double] and [String: String].
### Dictionary default values
If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all. While this might be what you want, there’s an alternative: we can provide the dictionary with a default value to use if we request a missing key.

To demonstrate this, let’s create a dictionary of favorite ice creams for two people:
```swift
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
```
We can read Paul’s favorite ice cream like this:

`favoriteIceCream["Paul"]`

But if we tried reading the favorite ice cream for Charlotte, we’d get back nil, meaning that Swift doesn’t have a value for that key:

```swift
favoriteIceCream["Charlotte"]
```

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
```swift
var words = Set<String>()
var numbers = Set<Int>()
```

This is because Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.

If you wanted, you could create arrays and dictionaries with similar syntax:
```swift
var scores = Dictionary<String, Int>()
var results = Array<Int>()
```
### Enumerations
Enumerations – usually called just enums – are a way of defining groups of related values in a way that makes them easier to use.

For example, if you wanted to write some code to represent the success or failure of some work you were doing, you could represent that as strings:

`let result = "failure"`

But what happens if someone accidentally uses different naming?
```swift
let result2 = "failed"
let result3 = "fail"
```

All those three are different strings, so they mean different things.

With enums we can define a Result type that can be either success or failure, like this:
```swift
enum Result {
    case success
    case failure
}
```
And now when we use it we must choose one of those two values:

`let result4 = Result.failure`

This stops you from accidentally using different strings each time.
### Enum associated values
As well as storing a simple value, enums can also store associated values attached to each case. This lets you attach additional information to your enums so they can represent more nuanced data.

For example, we might define an enum that stores various kinds of activities:
```swift
enum Activity {
    case bored
    case running
    case talking
    case singing
}
```
That lets us say that someone is talking, but we don’t know what they are talking about, or we can know that someone is running, but we don’t know where they are running to.

Enum associated values let us add those additional details:
```swift
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
```
Now we can be more precise – we can say that someone is talking about football:

`let talking = Activity.talking(topic: "football")`
### Enum raw values
Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways.

For example, you might create a Planet enum that stores integer values for each of its cases:
```swift
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
```
Swift will automatically assign each of those a number starting from 0, and you can use that number to create an instance of the appropriate enum case. For example, earth will be given the number 2, so you can write this:

`let earth = Planet(rawValue: 2)`

If you want, you can assign one or more cases a specific value, and Swift will generate the rest. It’s not very natural for us to think of Earth as the second planet, so you could write this:
```swift
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
```
Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.
### Complex types: Summary
You’ve made it to the end of the second part of this series, so let’s summarize:

1.    Arrays, sets, tuples, and dictionaries let you store a group of items under a single value. They each do this in different ways, so which you use depends on the behavior you want.
2.    Arrays store items in the order you add them, and you access them using numerical positions.
3.    Sets store items without any order, so you can’t access them using numerical positions.
4.    Tuples are fixed in size, and you can attach names to each of their items. You can read items using numerical positions or using your names.
5.    Dictionaries store items according to a key, and you can read items using those keys.
6.    Enums are a way of grouping related values so you can use them without spelling mistakes.
7.    You can attach raw values to enums so they can be created from integers or strings, or you can add associated values to store additional information about each case.

## IV. Operators and conditions

### Arithmetic Operators
Now you know all the basic types in Swift, we can start to put them together using operators. Operators are those little mathematical symbols like + and -, and Swift has a huge range of them.

Here are a couple of test variables for us to work with:
```swift
let firstScore = 12
let secondScore = 4
```
We can add and subtract using + and -:
```swift
let total = firstScore + secondScore
let difference = firstScore - secondScore
```
And we can multiply and divide using * and /:
```swift
let product = firstScore * secondScore
let divided = firstScore / secondScore
```
Swift has a special operator for calculating remainders after division: %. It calculates how many times one number can fit inside another, then sends back the value that’s left over.

For example, we set secondScore to 4, so if we say 13 % secondScore we’ll get back one, because 4 fits into 13 three times with remainder one:

`let remainder = 13 % secondScore`
### Operator overloading
Swift supports operator overloading, which is a fancy way of saying that what an operator does depends on the values you use it with. For example, + sums integers like this:
```swift
let meaningOfLife = 42
let doubleMeaning = 42 + 42
```
But + also joins strings, like this:
```swift
let fakers = "Fakers gonna "
let action = fakers + "fake"
```
You can even use + to join arrays, like this:
```swift
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf
```
Remember, Swift is a type-safe language, which means it won’t let you mix types. For example, you can’t add an integer to a string because it doesn’t make any sense.
### Compound assignment operators
Swift has shorthand operators that combine one operator with an assignment, so you can change a variable in place. These look like the existing operators you know – +, -, *, and /, but they have an = on the end because they assign the result back to whatever variable you were using.

For example, if someone scored 95 in an exam but needs to be penalized 5 points, you could write this:
```swift
var score = 95
score -= 5
```
Similarly, you can add one string to another using +=:
```swift
var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"
```
### Comparison operators
Now you know some operators you can write conditions using if statements. You give Swift a condition, and if that condition is true it will run code of your choosing.

To try this out, I want to use a Swift function called print(): you run it with some text, and it will be printed out.

We can use conditions to check for a winning Blackjack hand:
```swift
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}
```
The code inside the braces – { and } – will be run if the condition is true. If you want you can provide alternative code to run if the condition is false, using else:
```swift
if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
```
You can also chain conditions together using else if:
```swift
if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
```
### Conditions
Now you know some operators you can write conditions using if statements. You give Swift a condition, and if that condition is true it will run code of your choosing.

To try this out, I want to use a Swift function called print(): you run it with some text, and it will be printed out.

We can use conditions to check for a winning Blackjack hand:

```swift
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
}
```

The code inside the braces – { and } – will be run if the condition is true. If you want you can provide alternative code to run if the condition is false, using else:
```swift
if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
```
You can also chain conditions together using else if:
```swift
if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
```

### Combining operators
Swift has two special operators that let us combine conditions together: they are && (pronounced “and”) and || (pronounced “or”).

For example, we could check that the age of two people are both over a certain value like this:

```swift
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
```

That print() call will only happen if both ages are over 18, which they aren’t. In fact, Swift won’t even bother checking the value of age2 because it can see that age1 already failed the test.

The alternative to && is ||, which evaluates as true if either item passes the test. For example we could print a message if either age is over 18:


```swift
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}
```

You can use && and || more than once in a single condition, but don’t make things too complicated otherwise it can be hard to read!

### The ternary operator
Swift has a rarely used operator called the ternary operator. It works with three values at once, which is where its name comes from: it checks a condition specified in the first value, and if it’s true returns the second value, but if it’s false returns the third value.

The ternary operator is a condition plus true or false blocks all in one, split up by a question mark and a colon, all of which which makes it rather hard to read. Here’s an example:

```swift
let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
```

That checks whether the two cards are the same, then prints “Cards are the same” if the condition is true, or “Cards are different” if it’s false. We could write the same code using a regular condition:

```swift
if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}
```
### Switch statements
If you have several conditions using if and else if, it’s often clearer to use a different construct known as switch case. Using this approach you write your condition once, then list all possible outcomes and what should happen for each of them.

To try this out, here’s a weather constant containing the string sunny:

`let weather = "sunny"`

We can use a switch block to print one of four different messages:

```swift
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
```

In that example, the last case – default – is required because Swift makes sure you cover all possible cases so that no eventuality is missed off. If the weather is anything other than rain, snow, or sun, the default case will be run.

Swift will only run the code inside each case. If you want execution to continue on to the next case, use the fallthrough keyword like this:

```swift
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}
```
### Range operators
Swift gives us two ways of making ranges: the ..< and ... operators. The half-open range operator, ..<, creates ranges up to but excluding the final value, and the closed range operator, ..., creates ranges up to and including the final value.

For example, the range 1..<5 contains the numbers 1, 2, 3, and 4, whereas the range 1...5 contains the numbers 1, 2, 3, 4, and 5.

Ranges are helpful with switch blocks, because you can use them for each of your cases. For example, if someone sat an exam we could print different messages depending on their score:
```swift
let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
```
As before, the default case must be there to ensure all possible values are covered.
### Operators and conditions summary
You’ve made it to the end of the third part of this series, so let’s summarize:

1. Swift has operators for doing arithmetic and for comparison; they mostly work like you already know.
2. There are compound variants of arithmetic operators that modify their variables in place: +=, -=, and so on.
3. You can use if, else, and else if to run code based on the result of a condition.
4. Swift has a ternary operator that combines a check with true and false code blocks. Although you might see it in other  code, I wouldn’t recommend using it yourself.
5. If you have multiple conditions using the same value, it’s often clearer to use switch instead.
6. You can make ranges using ..< and ... depending on whether the last number should be excluded or included.

## V. Looping

### For loops
Swift has a few ways of writing loops, but their underlying mechanism is the same: run some code repeatedly until a condition evaluates as false.

The most common loop in Swift is a for loop: it will loop over arrays and ranges, and each time the loop goes around it will pull out one item and assign to a constant.

For example, here’s a range of numbers:

`let count = 1...10`

We can use a for loop to print each item like this:
```swift
for number in count {
    print("Number is \(number)")
}
```
We can do the same with arrays:

```swift
let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}
```

If you don’t use the constant that for loops give you, you should use an underscore instead so that Swift doesn’t create needless values:
```swift
print("Players gonna ")

for _ in 1...5 {
    print("play")
}
```

### While loops
A second way of writing loops is using while: give it a condition to check, and its loop code will go around and around until the condition fails.

For example, we could use a while loop to simulate a child counting in a game of hide and seek: we start at one, count up to and including 20 while printing each number out, then after the loop print “Ready or not”.

Here’s how that looks in Swift:

```swift
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")
```

### Repeat loops
The third way of writing loops is not commonly used, but it’s so simple to learn we might as well cover it: it’s called the repeat loop, and it’s identical to a while loop except the condition to check comes at the end.

So, we could rewrite our hide and seek example like this:
```swift
var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")
```
Because the condition comes at the end of the repeat loop the code inside the loop will always be executed at least once, whereas while loops check their condition before their first run.

For example, this print() function will never be run, because false is always false:
```swift
while false {
    print("This is false")
}
```

Xcode will even warn us that the print() line will never be executed.

On the other hand, this print() function will be run once, because repeat only fails the condition after the loop runs:

repeat {
    print("This is false")
} while false
### Exiting loops
You can exit a loop at any time using the break keyword. To try this out, let’s start with a regular while loop that counts down for a rocket launch:
```swift
var countDown = 10

while countDown >= 0 {
    print(countDown)
    countDown -= 1
}

print("Blast off!")
```
In this case, the astronaut in command gets bored part-way through the countdown and decides to skip the remainder and launch straight away:
```swift
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}
```
With that change, as soon as countDown reaches 4 the astronaut’s message will be printed, and the rest of the loop gets skipped.
### Exiting multiple loops
If you put a loop inside a loop it’s called a nested loop, and it’s not uncommon to want to break out of both the inner loop and the outer loop at the same time.

As an example, we could write some code to calculate the times tables from 1 through 10 like this:
```swift
for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}
```
If we wanted to exit part-way through we need to do two things. First, we give the outside loop a label, like this:
```swift
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}
```
Second, add our condition inside the inner loop, then use break outerLoop to exit both loops at the same time:
```swift
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
```
With a regular break, only the inner loop would be exited – the outer loop would continue where it left off.
### Skipping items
As you’ve seen, the break keyword exits a loop. But if you just want to skip the current item and continue on to the next one, you should use continue instead.

To try this out, we can write a loop from 1 through 10, then use Swift’s remainder operator to skip any numbers that are odd:
```swift
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}
```
Remember, the remainder operator figures out how many times 2 fits into each number in our loop, then returns whatever is left over. So, if 1 is left over, it means the number is odd, so we can use continue to skip it.
### Infinite loops
It’s common to use while loops to make infinite loops: loops that either have no end or only end when you’re ready. All apps on your iPhone use infinite loops, because they start running, then continually watch for events until you choose to quit them.

To make an infinite loop, just use true as your condition. true is always true, so the loop will repeat forever. Warning: Please make sure you have a check that exits your loop, otherwise it will never end.

As an example, we’re going to use while true to print the music of John Cage’s piece 4’33” – if you didn’t know, it’s famous because it’s 4 minutes and 33 seconds of complete silence.

We can write the “music” for this piece using while true, with a condition that exits the loop when we’ve gone around enough times:
```swift
var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}
```
### Looping summary
You’ve made it to the end of the fourth part of this series, so let’s summarize:

    1. Loops let us repeat code until a condition is false.
    2. The most common loop is for, which assigns each item inside the loop to a temporary constant.
    3. If you don’t need the temporary constant that for loops give you, use an underscore instead so Swift can skip that work.
    4. There are while loops, which you provide with an explicit condition to check.
    5. Although they are similar to while loops, repeat loops always run the body of their loop at least once.
    You can exit a single loop using break, but if you have nested loops you need to use break followed by whatever label you 6. placed before your outer loop.
    7. You can skip items in a loop using continue.
    Infinite loops don’t end until you ask them to, and are made using while true. Make sure you have a condition somewhere 8. to end your infinite loops!

## VI. Functions

### Writing functions
Functions let us re-use code, which means we can write a function to do something interesting then run that function from lots of places. Repeating code is generally a bad idea, and functions help us avoid doing that.

To start with, we’re going to write a function that prints help information for users of our app. We might need this anywhere in our app, so having it as a function is a good idea.

Swift functions start with the func keyword, then your function name, then open and close parentheses. All the body of your function – the code that should be run when the function is requested – is placed inside braces.

Let’s write the printHelp() function now:
```swift
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}
```
We can now run that using printHelp() by itself:

`printHelp()`

Running a function is often referred to as calling a function.
### Accepting parameters
Functions become more powerful when they can be customized each time you run them. Swift lets you send values to a function that can then be used inside the function to change the way it behaves. We’ve used this already – we’ve been sending strings and integers to the print() function, like this:

`print("Hello, world!")`

Values sent into functions this way are called parameters.

To make your own functions accept parameters, give each parameter a name, then a colon, then tell Swift the type of data it must be. All this goes inside the parentheses after your function name.

For example, we can write a function to print the square of any number:
```swift
func square(number: Int) {
    print(number * number)
}
```
That tells Swift we expect to receive an Int, and it should be called number. This name is used both inside the function when you want to refer to the parameter, but also when you run the function, like this:

`square(number: 8)`

### Returning values
As well as receiving data, functions can also send back data. To do this, write a dash then a right angle bracket after your function’s parameter list, then tell Swift what kind of data will be returned.

Inside your function, you use the return keyword to send a value back if you have one. Your function then immediately exits, sending back that value – no other code from that function will be run.

We could rewrite our square() function to return a value rather than print it directly:
```swift
func square(number: Int) -> Int {
    return number * number
}
```
Now we can grab that return value when the function is run, and print it there:
```swift
let result = square(number: 8)
print(result)
```
If you need to return multiple values, this is a perfect example of when to use tuples.
### Parameter labels
We wrote our square() function like this:
```swift
func square(number: Int) -> Int {
    return number * number
}
```
That names its parameter number, so we can use number inside the function to refer to it, but we must also use the name when running the function, like this:

`let result = square(number: 8)`

Swift lets us provide two names for each parameter: one to be used externally when calling the function, and one to be used internally inside the function. This is as simple as writing two names, separated by a space.

To demonstrate this, here’s a function that uses two names for its string parameter:
```swift
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
```

The parameter is called to name, which means externally it’s called to, but internally it’s called name. This gives variables a sensible name inside the function, but means calling the function reads naturally:

`sayHello(to: "Taylor")`
### Omitting parameter labels
You might have noticed that we don’t actually send any parameter names when we call print() – we say print("Hello") rather than print(message: "Hello").

You can get this same behavior in your own functions by using an underscore, _, for your external parameter name, like this:
```swift
func greet(_ person: String) {
    print("Hello, \(person)!")
}
```
You can now call greet() without having to use the person parameter name:

`greet("Taylor")`

This can make some code more natural to read, but generally it’s better to give your parameters external names to avoid confusion. For example, if I say setAlarm(5) it’s hard to tell what that means – does it set an alarm for five o’clock, set an alarm for five hours from now, or activate pre-configured alarm number 5?
### Default parameters
The print() function prints something to the screen, but always adds a new line to the end of whatever you printed, so that multiple calls to print() don’t all appear on the same line.

You can change that behavior if you want, so you could use spaces rather than line breaks. Most of the time, though, folks want new lines, so print() has a terminator parameter that uses new line as its default value.

You can give your own parameters a default value just by writing an = after its type followed by the default you want to give it. So, we could write a greet() function that can optionally print nice greetings:
```swift
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
```
That can be called in two ways:
```swift
greet("Taylor")
greet("Taylor", nicely: false)
```
### Variadic functions
Some functions are variadic, which is a fancy way of saying they accept any number of parameters of the same type. The print() function is actually variadic: if you pass lots of parameters, they are all printed on one line with spaces between them:

`print("Haters", "gonna", "hate")`

You can make any parameter variadic by writing ... after its type. So, an Int parameter is a single integer, whereas Int... is zero or more integers – potentially hundreds.

Inside the function, Swift converts the values that were passed in to an array of integers, so you can loop over them as needed.

To try this out, let’s write a square() function that can square many numbers:
```swift
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
```
Now we can run that with lots of numbers just by passing them in separated by commas:

`square(numbers: 1, 2, 3, 4, 5)`
### Writing throwing functions
Sometimes functions fail because they have bad input, or because something went wrong internally. Swift lets us throw errors from functions by marking them as throws before their return type, then using the throw keyword when something goes wrong.

First we need to define an enum that describes the errors we can throw. These must always be based on Swift’s existing Error type. We’re going to write a function that checks whether a password is good, so we’ll throw an error if the user tries an obvious password:
```
enum PasswordError: Error {
    case obvious
}
```
Now we’ll write a checkPassword() function that will throw that error if something goes wrong. This means using the throws keyword before the function’s return value, then using throw PasswordError.obvious if their password is “password”.

Here’s that in Swift:
```swift
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}
```
### Running throwing functions
Swift doesn’t like errors to happen when your program runs, which means it won’t let you run an error-throwing function by accident.

Instead, you need to call these functions using three new keywords: do starts a section of code that might cause problems, try is used before every function that might throw an error, and catch lets you handle errors gracefully.

If any errors are thrown inside the do block, execution immediately jumps to the catch block. Let’s try calling checkPassword() with a parameter that throws an error:
```swift
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```
When that code runs, “You can’t use that password” is printed, but “That password is good” won’t be – that code will never be reached, because the error is thrown.
### inout parameters
All parameters passed into a Swift function are constants, so you can’t change them. If you want, you can pass in one or more parameters as inout, which means they can be changed inside your function, and those changes reflect in the original value outside the function.

For example, if you want to double a number in place – i.e., change the value directly rather than returning a new one – you might write a function like this:
```swift
func doubleInPlace(number: inout Int) {
    number *= 2
}
```
To use that, you first need to make a variable integer – you can’t use constant integers with inout, because they might be changed. You also need to pass the parameter to doubleInPlace using an ampersand, &, before its name, which is an explicit recognition that you’re aware it is being used as inout.

In code, you’d write this:
```swift
var myNum = 10 
doubleInPlace(number: &myNum)
```
### Functions summary
You’ve made it to the end of the fifth part of this series, so let’s summarize:

    1. Functions let us re-use code without repeating ourselves.
    2. Functions can accept parameters – just tell Swift the type of each parameter.
    Functions can return values, and again you just specify what type will be sent back. Use tuples if you want to return 3. several things.
    4. You can use different names for parameters externally and internally, or omit the external name entirely.
    5. Parameters can have default values, which helps you write less code when specific values are common.
    6. Variadic functions accept zero or more of a specific parameter, and Swift converts the input to an array.
    7. Functions can throw errors, but you must call them using try and handle errors using catch.
    8. You can use inout to change variables inside a function, but it’s usually better to return a new value.

## VII. Closures

### Creating basic closures
Swift lets us use functions just like any other type such as strings and integers. This means you can create a function and assign it to a variable, call that function using that variable, and even pass that function into other functions as parameters.

Functions used in this way are called closures, and although they work like functions they are written a little differently.

Let’s start with a simple example that prints a message:
```swift
let driving = {
    print("I'm driving in my car")
}
```
That effectively creates a function without a name, and assigns that function to driving. You can now call driving() as if it were a regular function, like this:

`driving()`

### Accepting parameters in a closure
When you create closures, they don’t have a name or space to write any parameters. That doesn’t mean they can’t accept parameters, just that they do so in a different way: they are listed inside the open braces.

To make a closure accept parameters, list them inside parentheses just after the opening brace, then write in so that Swift knows the main body of the closure is starting.

For example, we could make a closure that accepts a place name string as its only parameter like this:
```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}
```
One of the differences between functions and closures is that you don’t use parameter labels when running closures. So, to call driving() now we’d write this:

`driving("London")`

### Returning values from a closure
Closures can also return values, and they are written similarly to parameters: you write them inside your closure, directly before the in keyword.

To demonstrate this, we’re going to take our driving() closure and make it return its value rather than print it directly. Here’s the original:
```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}
```
We want a closure that returns a string rather than printing the message directly, so we need to use -> String before in, then use return just like a normal function:
```swift
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```

We can now run that closure and print its return value:
```swift
let message = drivingWithReturn("London")
print(message)
```
### Closures as parameters
Because closures can be used just like strings and integers, you can pass them into functions. The syntax for this can hurt your brain at first, so we’re going to take it slow.

First, here’s our basic driving() closure again
```swift
let driving = {
    print("I'm driving in my car")
}
```
If we wanted to pass that closure into a function so it can be run inside that function, we would specify the parameter type as () -> Void. That means “accepts no parameters, and returns Void” – Swift’s way of saying “nothing”.

So, we can write a travel() function that accepts different kinds of traveling actions, and prints a message before and after:
```swift
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
```
We can now call that using our driving closure, like this:

`travel(action: driving)`
### Trailing closure syntax
If the last parameter to a function is a closure, Swift lets you use special syntax called trailing closure syntax. Rather than pass in your closure as a parameter, you pass it directly after the function inside braces.

To demonstrate this, here’s our travel() function again. It accepts an action closure so that it can be run between two print() calls:
```swift
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
```
Because its last parameter is a closure, we can call travel() using trailing closure syntax like this:
```swift
travel() {
    print("I'm driving in my car")
}
```
In fact, because there aren’t any other parameters, we can eliminate the parentheses entirely:
```swift
travel {
    print("I'm driving in my car")
}
```
Trailing closure syntax is extremely common in Swift, so it’s worth getting used to.
### Using closures as parameters when they accept parameters
This is where closures can start to be read a bit like line noise: a closure you pass into a function can also accept its own parameters.

We’ve been using () -> Void to mean “accepts no parameters and returns nothing”, but you can go ahead and fill the () with the types of any parameters that your closure should accept.

To demonstrate this, we can write a travel() function that accepts a closure as its only parameter, and that closure in turn accepts a string:
```swift
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
```
Now when we call travel() using trailing closure syntax, our closure code is required to accept a string:
```swift
travel { (place: String) in
    print("I'm going to \(place) in my car")
}
```
### Using closures as parameters when they return values
We’ve been using () -> Void to mean “accepts no parameters and returns nothing”, but you can replace that Void with any type of data to force the closure to return a value.

To demonstrate this, we can write a travel() function that accepts a closure as its only parameter, and that closure in turn accepts a string and returns a string:
```swift
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
```
Now when we call travel() using trailing closure syntax, our closure code is required to accept a string and return a string:
```swift
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```
### Shorthand parameter names
We just made a travel() function. It accepts one parameter, which is a closure that itself accepts one parameter and returns a string. That closure is then run between two calls to print().

Here’s that in code:
```swift
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
```
We can call travel() using something like this:
```swift
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```
However, Swift knows the parameter to that closure must be a string, so we can remove it:
```swift
travel { place -> String in
    return "I'm going to \(place) in my car"
}
```
It also knows the closure must return a string, so we can remove that:
```swift
travel { place in
    return "I'm going to \(place) in my car"
}
```
As the closure only has one line of code that must be the one that returns the value, so Swift lets us remove the return keyword too:
```swift
travel { place in
    "I'm going to \(place) in my car"
}
```
Swift has a shorthand syntax that lets you go even shorter. Rather than writing place in we can let Swift provide automatic names for the closure’s parameters. These are named with a dollar sign, then a number counting from 0.
```swift
travel {
    "I'm going to \($0) in my car"
}
```
### Closures with multiple parameters
Just to make sure everything is clear, we’re going to write another closure example using two parameters.

This time our travel() function will require a closure that specifies where someone is traveling to, and the speed they are going. This means we need to use (String, Int) -> String for the parameter’s type:
```swift
func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}
```
We’re going to call that using a trailing closure and shorthand closure parameter names. Because this accepts two parameters, we’ll be getting both $0 and $1:
```swift
travel {
    "I'm going to \($0) at \($1) miles per hour."
}
```
Some people prefer not to use shorthand parameter names like $0 because it can be confusing, and that’s OK – do whatever works best for you.
### Returning closures from functions
In the same way that you can pass a closure to a function, you can get closures returned from a function too.

The syntax for this is a bit confusing a first, because it uses -> twice: once to specify your function’s return value, and a second time to specify your closure’s return value.

To try this out, we’re going to write a travel() function that accepts no parameters, but returns a closure. The closure that gets returned must be called with a string, and will return nothing.

Here’s how that looks in Swift:
```swift
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
```
We can now call travel() to get back that closure, then call it as a function:
```
let result = travel()
result("London")
```
It’s technically allowable – although really not recommended! – to call the return value from travel() directly:

`let result2 = travel()("London")`
### Capturing values
If you use any external values inside your closure, Swift captures them – stores them alongside the closure, so they can be modified even if they don’t exist any more.

Right now we have a travel() function that returns a closure, and the returned closure accepts a string as its only parameter and returns nothing:
```swift
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
```
We can call travel() to get back the closure, then call that closure freely:
```swift
let result = travel()
result("London")
```
Closure capturing happens if we create values in travel() that get used inside the closure. For example, we might want to track how often the returned closure is called:
```swift
func travel() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
```
Even though that counter variable was created inside travel(), it gets captured by the closure so it will still remain alive for that closure.

So, if we call result("London") multiple times, the counter will go up and up:
```swift
result("London")
result("London")
result("London")
```
### Closures summary
You’ve made it to the end of the sixth part of this series, so let’s summarize:

1. You can assign closures to variables, then call them later on.
2. Closures can accept parameters and return values, like regular functions.
3. You can pass closures into functions as parameters, and those closures can have parameters of their own and a return value.
4. If the last parameter to your function is a closure, you can use trailing closure syntax.
5. Swift automatically provides shorthand parameter names like $0 and $1, but not everyone uses them.
6. If you use external values inside your closures, they will be captured so the closure can refer to them later.

## VIII. Structs

### Creating your own structs
Swift lets you design your own types in two ways, of which the most common are called structures, or just structs. Structs can be given their own variables and constants, and their own functions, then created and used however you want.

Let’s start with a simple example: we’re going to create a Sport struct that stores its name as a string. Variables inside structs are called properties, so this is a struct with one property:
```swift
struct Sport {
    var name: String
}
```
That defines the type, so now we can create and use an instance of it:
```swift
var tennis = Sport(name: "Tennis")
print(tennis.name)
```
We made both name and tennis variable, so we can change them just like regular variables:

`tennis.name = "Lawn tennis"`

Properties can have default values just like regular variables, and you can usually rely on Swift’s type inference.
### Computed properties
We just created a Sport struct like this:
```swift
struct Sport {
    var name: String
}
```
That has a name property that stores a String. These are called stored properties, because Swift has a different kind of property called a computed property – a property that runs code to figure out its value.

We’re going to add another stored property to the Sport struct, then a computed property. Here’s how that looks:
```swift
struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}
```
As you can see, olympicStatus looks like a regular String, but it returns different values depending on the other properties.

We can try it out by creating a new instance of Sport:
```swift
let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
```
### Property observers
Property observers let you run code before or after any property changes. To demonstrate this, we’ll write a Progress struct that tracks a task and a completion percentage:
```swift
struct Progress {
    var task: String
    var amount: Int
}
```
We can now create an instance of that struct and adjust its progress over time:
```swift
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
```
What we want to happen is for Swift to print a message every time amount changes, and we can use a didSet property observer for that. This will run some code every time amount changes:
```swift
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
```
You can also use willSet to take action before a property changes, but that is rarely used.
### Methods
Structs can have functions inside them, and those functions can use the properties of the struct as they need to. Functions inside structs are called methods, but they still use the same func keyword.

We can demonstrate this with a City struct. This will have a population property that stores how many people are in the city, plus a collectTaxes() method that returns the population count multiplied by 1000. Because the method belongs to City it can read the current city’s population property.

Here’s the code:
```swift
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}
```
That method belongs to the struct, so we call it on instances of the struct like this:
```swift
let london = City(population: 9_000_000)
london.collectTaxes()
```
### Mutating methods
If a struct has a variable property but the instance of the struct was created as a constant, that property can’t be changed – the struct is constant, so all its properties are also constant regardless of how they were created.

The problem is that when you create the struct Swift has no idea whether you will use it with constants or variables, so by default it takes the safe approach: Swift won’t let you write methods that change properties unless you specifically request it.

When you want to change a property inside a method, you need to mark it using the mutating keyword, like this:
```swift
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
```
Because it changes the property, Swift will only allow that method to be called on Person instances that are variables:
```
var person = Person(name: "Ed")
person.makeAnonymous()
```
### Properties and methods of strings
We’ve used lots of strings so far, and it turns out they are structs – they have their own methods and properties we can use to query and manipulate the string.

First, let’s create a test string:

`let string = "Do or do not, there is no try."`

You can read the number of characters in a string using its count property:

`print(string.count)`

They have a hasPrefix() method that returns true if the string starts with specific letters:

`print(string.hasPrefix("Do"))`

You can uppercase a string by calling its uppercased() method:

`print(string.uppercased())`

And you can even have Swift sort the letters of the string into an array:

`print(string.sorted())`

Strings have lots more properties and methods – try typing string. to bring up Xcode’s code completion options.
### Properties and methods of arrays
Arrays are also structs, which means they too have their own methods and properties we can use to query and manipulate the array.

Here’s a simple array to get us started:

`var toys = ["Woody"]`

You can read the number of items in an array using its count property:

`print(toys.count)`

If you want to add a new item, use the append() method like this:

`toys.append("Buzz")`

You can locate any item inside an array using its firstIndex() method, like this:

`toys.firstIndex(of: "Buzz")`

That will return 1 because arrays count from 0.

Just like with strings, you can have Swift sort the items of the array alphabetically:

`print(toys.sorted())`

Finally, if you want to remove an item, use the remove() method like this:

`toys.remove(at: 0)`

Arrays have lots more properties and methods – try typing toys. to bring up Xcode’s code completion options.
### Initializers
Initializers are special methods that provide different ways to create your struct. All structs come with one by default, called their memberwise initializer – this asks you to provide a value for each property when you create the struct.

You can see this if we create a User struct that has one property:
```swift
struct User {
    var username: String
}
```
When we create one of those structs, we must provide a username:
```swift
var user = User(username: "twostraws")
```
We can provide our own initializer to replace the default one. For example, we might want to create all new users as “Anonymous” and print a message, like this:
```swift
struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
```
You don’t write func before initializers, but you do need to make sure all properties have a value before the initializer ends.

Now our initializer accepts no parameters, we need to create the struct like this:
```swift
var user = User()
user.username = "twostraws"
```
### Referring to the current instance
Inside methods you get a special constant called self, which points to whatever instance of the struct is currently being used. This self value is particularly useful when you create initializers that have the same parameter names as your property.

For example, if you create a Person struct with a name property, then tried to write an initializer that accepted a name parameter, self helps you distinguish between the property and the parameter – self.name refers to the property, whereas name refers to the parameter.

Here’s that in code:
```swift
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
```

### Lazy properties
As a performance optimization, Swift lets you create some properties only when they are needed. As an example, consider this FamilyTree struct – it doesn’t do much, but in theory creating a family tree for someone takes a long time:
```swift
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
```
We might use that FamilyTree struct as a property inside a Person struct, like this:
```swift
struct Person {
    var name: String
    var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed")
```
But what if we didn’t always need the family tree for a particular person? If we add the lazy keyword to the familyTree property, then Swift will only create the FamilyTree struct when it’s first accessed:

`lazy var familyTree = FamilyTree()`

So, if you want to see the “Creating family tree!” message, you need to access the property at least once:

`ed.familyTree`

### Static properties and methods
All the properties and methods we’ve created so far have belonged to individual instances of structs, which means that if we had a Student struct we could create several student instances each with their own properties and methods:
```swift
struct Student {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")
```
You can also ask Swift to share specific properties and methods across all instances of the struct by declaring them as static.

To try this out, we’re going to add a static property to the Student struct to store how many students are in the class. Each time we create a new student, we’ll add one to it:
```swift
struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
```
Because the classSize property belongs to the struct itself rather than instances of the struct, we need to read it using Student.classSize:

`print(Student.classSize)`
### Access control
Access control lets you restrict which code can use properties and methods. This is important because you might want to stop people reading a property directly, for example.

We could create a Person struct that has an id property to store their social security number:
```swift
struct Person {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let ed = Person(id: "12345")
```
Once that person has been created, we can make their id be private so you can’t read it from outside the struct – trying to write ed.id simply won’t work.

Just use the private keyword, like this:
```swift
struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
}
```
Now only methods inside Person can read the id property. For example:
```swift
struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}
```
Another common option is public, which lets all other code use the property or method.
### Structs summary
You’ve made it to the end of the seventh part of this series, so let’s summarize:

    1. You can create your own types using structures, which can have their own properties and methods.
    2. You can use stored properties or use computed properties to calculate values on the fly.
    3. If you want to change a property inside a method, you must mark it as mutating.
    4. Initializers are special methods that create structs. You get a memberwise initializer by default, but if you create  your own you must give all properties a value.
    5. Use the self constant to refer to the current instance of a struct inside a method.
    6. The lazy keyword tells Swift to create properties only when they are first used.
    7. You can share properties and methods across all instances of a struct using the static keyword.
    8. Access control lets you restrict what code can use properties and methods.

## IX. Classes

### Creating your own classes
Classes are similar to structs in that they allow you to create new types with properties and methods, but they have five important differences and I’m going to walk you through each of those differences one at a time.

The first difference between classes and structs is that classes never come with a memberwise initializer. This means if you have properties in your class, you must always create your own initializer.

For example:
```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```
Creating instances of that class looks just the same as if it were a struct:

```
let poppy = Dog(name: "Poppy", breed: "Poodle")
```
### Class inheritance
The second difference between classes and structs is that you can create a class based on an existing class – it inherits all the properties and methods of the original class, and can add its own on top.

This is called class inheritance or subclassing, the class you inherit from is called the “parent” or “super” class, and the new class is called the “child” class.

Here’s the Dog class we just created:
```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```
We could create a new class based on that one called Poodle. It will inherit the same properties and initializer as Dog by default:
```swift
class Poodle: Dog {

}
```
However, we can also give Poodle its own initializer. We know it will always have the breed “Poodle”, so we can make a new initializer that only needs a name property. Even better, we can make the Poodle initializer call the Dog initializer directly so that all the same setup happens:
```swift
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
```
For safety reasons, Swift always makes you call super.init() from child classes – just in case the parent class does some important work when it’s created.
### Overriding methods
Child classes can replace parent methods with their own implementations – a process known as overriding. Here’s a trivial Dog class with a makeNoise() method:
```swift
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}
```
If we create a new Poodle class that inherits from Dog, it will inherit the makeNoise() method. So, this will print “Woof!”:
```swift
class Poodle: Dog {
}

let poppy = Poodle()
poppy.makeNoise()
```
Method overriding allows us to change the implementation of makeNoise() for the Poodle class.

Swift requires us to use override func rather than just func when overriding a method – it stops you from overriding a method by accident, and you’ll get an error if you try to override something that doesn’t exist on the parent class:
```swift
class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
```
With that change, poppy.makeNoise() will print “Yip!” rather than “Woof!”.
### Final classes
Although class inheritance is very useful – and in fact large parts of Apple’s platforms require you to use it – sometimes you want to disallow other developers from building their own class based on yours.

Swift gives us a final keyword just for this purpose: when you declare a class as being final, no other class can inherit from it. This means they can’t override your methods in order to change your behavior – they need to use your class the way it was written.

To make a class final just put the final keyword before it, like this:
```swift
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```
### Copying objects
The third difference between classes and structs is how they are copied. When you copy a struct, both the original and the copy are different things – changing one won’t change the other. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.

For example, here’s a simple Singer class that has a name property with a default value:
```swift
class Singer {
    var name = "Taylor Swift"
}
```
If we create an instance of that class and prints its name, we’ll get “Taylor Swift”:
```swift
var singer = Singer()
print(singer.name)
```
Now let’s create a second variable from the first one and change its name:
```swift
var singerCopy = singer
singerCopy.name = "Justin Bieber"
```
Because of the way classes work, both singer and singerCopy point to the same object in memory, so when we print the singer name again we’ll see “Justin Bieber”:
```swift
print(singer.name)
```
On the other hand, if Singer were a struct then we would get “Taylor Swift” printed a second time:
```swift
struct Singer {
    var name = "Taylor Swift"
}
```
### Deinitializers
The fourth difference between classes and structs is that classes can have deinitializers – code that gets run when an instance of a class is destroyed.

To demonstrate this, here’s a Person class with a name property, a simple initializer, and a printGreeting() method that prints a message:
```swift
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}
```
We’re going to create a few instances of the Person class inside a loop, because each time the loop goes around a new person will be created then destroyed:
```swift
for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
```
And now for the deinitializer. This will be called when the Person instance is being destroyed:
```swift
deinit {
    print("\(name) is no more!")
}
```
### Mutability

```swift
```

The final difference between classes and structs is the way they deal with constants. If you have a constant struct with a variable property, that property can’t be changed because the struct itself is constant.

However, if you have a constant class with a variable property, that property can be changed. Because of this, classes don’t need the mutating keyword with methods that change properties; that’s only needed with structs.

This difference means you can change any variable property on a class even when the class is created as a constant – this is perfectly valid code:
```swift
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
```
If you want to stop that from happening you need to make the property constant:
```swift
class Singer {
    let name = "Taylor Swift"
}
```
### Classes summary
You’ve made it to the end of the eighth part of this series, so let’s summarize:

1. Classes and structs are similar, in that they can both let you create your own types with properties and methods.
One class can inherit from another, and it gains all the properties and methods of the parent class. It’s common to talk 2. about class hierarchies – one class based on another, which itself is based on another.
3. You can mark a class with the final keyword, which stops other classes from inheriting from it.
4. Method overriding lets a child class replace a method in its parent class with a new implementation.
When two variables point at the same class instance, they both point at the same piece of memory – changing one changes 5. the other.
6. Classes can have a deinitializer, which is code that gets run when an instance of the class is destroyed.
7. Classes don’t enforce constants as strongly as structs – if a property is declared as a variable, it can be changed  regardless of how the class instance was created.

## X. Protocols and extensions

### Protocols
Protocols are a way of describing what properties and methods something must have. You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol.

For example, we can write a function that accepts something with an id property, but we don’t care precisely what type of data is used. We’ll start by creating an Identifiable protocol, which will require all conforming types to have an id string that can be read (“get”) or written (“set”):
```swift
protocol Identifiable {
    var id: String { get set }
}
```
We can’t create instances of that protocol - it’s a description of what we want, rather than something we can create and use directly. But we can create a struct that conforms to it:
```swift
struct User: Identifiable {
    var id: String
}
```
Finally, we’ll write a displayID() function that accepts any Identifiable object:
```swift
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
```
### Protocol inheritance
```swift
```

One protocol can inherit from another in a process known as protocol inheritance. Unlike with classes, you can inherit from multiple protocols at the same time before you add your own customizations on top.

We’re going to define three protocols: Payable requires conforming types to implement a calculateWages() method, NeedsTraining requires conforming types to implement a study() method, and HasVacation requires conforming types to implement a takeVacation() method:
```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
```
We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces:
```swift
protocol Employee: Payable, NeedsTraining, HasVacation { }
```
Now we can make new types conform to that single protocol rather than each of the three individual ones.

### Extensions


Extensions allow you to add methods to existing types, to make them do things they weren’t originally designed to do.

For example, we could add an extension to the Int type so that it has a squared() method that returns the current number multiplied by itself:
```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}
```
To try that out, just create an integer and you’ll see it now has a squared() method:
```swift
let number = 8
number.squared()
```
Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead. For example, we could add a new isEven computed property to integers that returns true if it holds an even number:
```swift
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
```
### Protocol extensions
```swift
```
Protocols let you describe what methods something should have, but don’t provide the code inside. Extensions let you provide the code inside your methods, but only affect one data type – you can’t add the method to lots of types at the same time.

Protocol extensions solve both those problems: they are like regular extensions, except rather than extending a specific type like Int you extend a whole protocol so that all conforming types get your changes.

For example, here is an array and a set containing some names:
```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
```
Swift’s arrays and sets both conform to a protocol called Collection, so we can write an extension to that protocol to add a summarize() method to print the collection neatly
```swift
extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}
```
Both Array and Set will now have that method, so we can try it out:
```swift
pythons.summarize()
beatles.summarize()
```
### Protocol-oriented programming
```swift
```
Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions.

First, here’s a protocol called Identifiable that requires any conforming type to have an id property and an identify() method:
```swift
protocol Identifiable {
    var id: String { get set }
    func identify()
}
```
We could make every conforming type write their own identify() method, but protocol extensions allow us to provide a default:
```swift
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}
```
Now when we create a type that conforms to Identifiable it gets identify() automatically:
```swift
struct User: Identifiable {
    var id: String
}
```
let twostraws = User(id: "twostraws")
twostraws.identify()
### Protocols and extensions summary
```swift
```
You’ve made it to the end of the ninth part of this series, so let’s summarize:

1. Protocols describe what methods and properties a conforming type must have, but don’t provide the implementations of those methods.
2. You can build protocols on top of other protocols, similar to classes.
3. Extensions let you add methods and computed properties to specific types such as Int.
4. Protocol extensions let you add methods and computed properties to protocols.
5. Protocol-oriented programming is the practice of designing your app architecture as a series of protocols, then using protocol extensions to provide default method implementations.


## XI. Optionals

### Handling missing data
We’ve used types such as Int to hold values like 5. But if you wanted to store an age property for users, what would you do if you didn’t know someone’s age?

You might say “well, I’ll store 0”, but then you would get confused between new-born babies and people whose age you don’t know. You could use a special number such as 1000 or -1 to represent “unknown”, both of which are impossible ages, but then would you really remember that number in all the places it’s used?

Swift’s solution is called optionals, and you can make optionals out of any type. An optional integer might have a number like 0 or 40, but it might have no value at all – it might literally be missing, which is nil in Swift.

To make a type optional, add a question mark after it. For example, we can make an optional integer like this:

```swift
var age: Int? = nil
```

That doesn’t hold any number – it holds nothing. But if we later learn that age, we can use it:
```swift
age = 38
```
### Unwrapping optionals
Optional strings might contain a string like “Hello” or they might be nil – nothing at all.

Consider this optional string:
```swift
var name: String? = nil
```
What happens if we use name.count? A real string has a count property that stores how many letters it has, but this is nil – it’s empty memory, not a string, so it doesn’t have a count.

Because of this, trying to read name.count is unsafe and Swift won’t allow it. Instead, we must look inside the optional and see what’s there – a process known as unwrapping.

A common way of unwrapping optionals is with if let syntax, which unwraps with a condition. If there was a value inside the optional then you can use it, but if there wasn’t the condition fails.

For example:
```swift
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```
If name holds a string, it will be put inside unwrapped as a regular String and we can read its count property inside the condition. Alternatively, if name is empty, the else code will be run.

### Unwrapping with guard
An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for you, but if it finds nil inside it expects you to exit the function, loop, or condition you used it in.

However, the major difference between if let and guard let is that your unwrapped optional remains usable after the guard code.

Let’s try it out with a greet() function. This will accept an optional string as its only parameter and try to unwrap it, but if there’s nothing inside it will print a message and exit. Because optionals unwrapped using guard let stay around after the guard finishes, we can print the unwrapped string at the end of the function:
```swift
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
```
Using guard let lets you deal with problems at the start of your functions, then exit immediately. This means the rest of your function is the happy path – the path your code takes if everything is correct.

### Force unwrapping
Optionals represent data that may or may not be there, but sometimes you know for sure that a value isn’t nil. In these cases, Swift lets you force unwrap the optional: convert it from an optional type to a non-optional type.

For example, if you have a string that contains a number, you can convert it to an Int like this:
```swift
let str = "5"
let num = Int(str)
```
That makes num an optional Int because you might have tried to convert a string like “Fish” rather than “5”.

Even though Swift isn’t sure the conversion will work, you can see the code is safe so you can force unwrap the result by writing ! after Int(str), like this:
```swift
let num = Int(str)!
```
Swift will immediately unwrap the optional and make num a regular Int rather than an Int?. But if you’re wrong – if str was something that couldn’t be converted to an integer – your code will crash.

As a result, you should force unwrap only when you’re sure it’s safe – there’s a reason it’s often called the crash operator.
### Implicitly unwrapped optionals
Like regular optionals, implicitly unwrapped optionals might contain a value or they might be nil. However, unlike regular optionals you don’t need to unwrap them in order to use them: you can use them as if they weren’t optional at all.

Implicitly unwrapped optionals are created by adding an exclamation mark after your type name, like this:
```swift
let age: Int! = nil
```
Because they behave as if they were already unwrapped, you don’t need if let or guard let to use implicitly unwrapped optionals. However, if you try to use them and they have no value – if they are nil – your code crashes.

Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have a value before you need to use it. Because you know they will have a value by the time you need them, it’s helpful not having to write if let all the time.

That being said, if you’re able to use regular optionals instead it’s generally a good idea.

### Nil coalescing
The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – if the optional was nil – then a default value is used instead. Either way, the result won’t be optional: it will either be the value from inside the optional or the default value used as a backup.

Here’s a function that accepts an integer as its only parameter and returns an optional string:
```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
```
If we call that with ID 15 we’ll get back nil because the user isn’t recognized, but with nil coalescing we can provide a default value of “Anonymous” like this:
```swift
let user = username(for: 15) ?? "Anonymous"
```
That will check the result that comes back from the username() function: if it’s a string then it will be unwrapped and placed into user, but if it has nil inside then “Anonymous” will be used instead.
### Optional chaining
Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c.

When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be ignored – Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will continue.

To try this out, here’s an array of names:
```swift
let names = ["John", "Paul", "George", "Ringo"]
```
We’re going to use the first property of that array, which will return the first name if there is one or nil if the array is empty. We can then call uppercased() on the result to make it an uppercase string:
```swift
let beatle = names.first?.uppercased()
```
That question mark is optional chaining – if first returns nil then Swift won’t try to uppercase it, and will set beatle to nil immediately.
### Optional try
Back when we were talking about throwing functions, we looked at this code:
```swift
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```
That runs a throwing function, using do, try, and catch to handle errors gracefully.

There are two alternatives to try, both of which will make more sense now that you understand optionals and force unwrapping.

The first is try?, and changes throwing functions into functions that return an optional. If the function throws an error you’ll be sent nil as the result, otherwise you’ll get the return value wrapped as an optional.

Using try? we can run checkPassword() like this:
```swift
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
```
The other alternative is try!, which you can use when you know for sure that the function will not fail. If the function does throw an error, your code will crash.

Using try! we can rewrite the code to this:
```swift
try! checkPassword("sekrit")
print("OK!")
```
### Failable initializers
When talking about force unwrapping, I used this code:
```swift
let str = "5"
let num = Int(str)
```
That converts a string to an integer, but because you might try to pass any string there what you actually get back is an optional integer.

This is a failable initializer: an initializer that might work or might not. You can write these in your own structs and classes by using init?() rather than init(), and return nil if something goes wrong. The return value will then be an optional of your type, for you to unwrap however you want.

As an example, we could code a Person struct that must be created using a nine-letter ID string. If anything other than a nine-letter string is used we’ll return nil, otherwise we’ll continue as normal.

Here’s that in Swift:
```swift
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
```

### Typecasting
Swift must always know the type of each of your variables, but sometimes you know more information than Swift does. For example, here are three classes:
```swift

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
```
We can create a couple of fish and a couple of dogs, and put them into an array, like this:
```swift
let pets = [Fish(), Dog(), Fish(), Dog()]
```
Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal.

If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will check to see whether each pet is a Dog object, and if it is we can then call makeNoise().

This uses a new keyword called as?, which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.

Here’s how we write the loop in Swift:
```swift
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
```

### Optionals summary
```swift
```
You’ve made it to the end of the tenth part of this series, so let’s summarize:

1. Optionals let us represent the absence of a value in a clear and unambiguous way.
2. Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.
3. You can force unwrap optionals with an exclamation mark, but if you try to force unwrap nil your code will crash.
4. Implicitly unwrapped optionals don’t have the safety checks of regular optionals.
5. You can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.
6. Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.
7. You can use try? to convert a throwing function into an optional return value, or try! to crash if an error is thrown.
8. If you need your initializer to fail when it’s given bad input, use init?() to make a failable initializer.
9. You can use typecasting to convert one type of object to another.


```swift
```
## XII. Conclusion

### Where now?
You’ve made it to the end of Swift in Sixty Seconds – I hope you’re proud of all the work you’ve put in! Don’t worry if you found some things hard: topics such as closures and optionals are hard, so if they took some time to learn that’s just a sign your brain is working properly.

Now, the question is: where can you go next? Well, I publish a range of books that I hope will help you answer that question:

- If you’d like to start using Swift to make iOS apps, you should read Hacking with Swift. It’s available free online but you can buy the premium edition with bonus content if you prefer.
- If you’d like to improve your knowledge of the Swift language, tackling more advanced features such as generics, custom operators, and functional programming, you should read Pro Swift.
- If you’d like to learn to make games using Swift, you’re ready for my book Dive Into SpriteKit – you get to choose how each game project should develop.
- If you’d like to try other Apple platforms, I have books teaching macOS, watchOS, and tvOS.

Congratulations on finishing Swift in Sixty Seconds – I hope you learned a lot, and that you’re able to have a lot of fun with your new coding skills!
