let rec gcd n1 n2 = 
   if n2 = 0 then n1
   else gcd n2 (n1%n2)

printfn "gcd (36, 16) = %d" (gcd 36 16)