open System

type MyException(message:string, innerException:Exception) =
    inherit Exception(message, innerException)

let rec walkExceptionsForMyException (e:Exception) =
    match e with
    | null -> null
    | :? MyException -> e
    | _ -> walkExceptionsForMyException e.InnerException

let walkExceptionsUsingSeq (e:Exception) = 
    Seq.unfold(fun (x:Exception) -> if e.InnerException = null then None else Some(x, x.InnerException)) e
    |> Seq.filter(fun x -> x.GetType() = typedefof<MyException>)
    |> Seq.head

let mutable r = "a" ^ "b"


let GetException() = 
    new ApplicationException("Something bad happened",
                    new ApplicationException("Object didn't exist",
                        new ApplicationException("Couldn't find something",
                            new MyException("User didn't click button fast enough.",
                                new ApplicationException("Oops!")
                                )
                            )
                        )
                    )

printfn "Exception: %A" (walkExceptionsUsingSeq(GetException()))