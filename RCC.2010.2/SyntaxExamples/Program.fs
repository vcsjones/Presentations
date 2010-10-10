//Declare a variable
let variable = "Hello World!"

//print the string variable out
printfn "%s" variable

//print out a number. Note the "d" instead of the "s"
let numericVariable = 5
printfn "%d" numericVariable

//A bigint
let hugeInteger = 888888888888888888888888888888888888888888888888888888888888888888888888I
printfn "%A" (hugeInteger / 2I)

//A function (method) that prints out a variable
let printNumber d = 
    printfn "%d" d

//Call the function
printNumber numericVariable

//Use pipelining to pass in the argument
numericVariable |> printNumber

//Use the "rec" modifier to allow recursive calls
let printUpTo n = 
    let rec loop x = 
        printNumber x
        if x < n then loop (x+1)
    loop 0

printUpTo 10

//Scoping existing locals / parameters
let print x =
    printNumber x
    let printAnother x = 
        printNumber x
    printAnother 7

print 5

let r() = 
    let r() = 
        4
    r

//Language support for tuples
let tuple = ("a", 5)
//print the "a"
printfn "%s" (fst tuple) //fst = "first"
//print the "5"
printfn "%d" (snd tuple) //snd = "second"

//Make a list and print it
[1..10]
|> List.iter(fun x -> printfn "%d" x)

//Use "banana clips" to make it an array
[|1..10|]
|> Array.iter(fun x -> printfn "%d" x)

//Make an infinitely long list of the letter "a"
let infiniteA = 
    seq {
        while true do yield "a"
    }

//print 10 a's
infiniteA
|> Seq.take 10
|> Seq.iter(fun x -> printfn "%s" x)

//Sequences are lazy. Lists and Arrays are not.


//Types
type MyClass = 
    static member Foo() =
        0

let foo = MyClass.Foo()
printfn "foo = %d" foo

//Records
type Point =
    {
    X: int
    Y: int
    }

let p = {X = 1; Y=2}

printfn "%A" p