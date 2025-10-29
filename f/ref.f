"ref 2";
ref 2;

addr = ref (lambda x:Nat . lambda y:Nat . x);
addr := (lambda x:Nat . lambda y:Nat .
         if iszero y then x
	 else (!addr (succ x) (pred y)));
add = !addr;

addg = lambda a:Nat->Nat->Nat . (lambda x:Nat. lambda y:Nat .
                     if iszero y then x else (a (succ x) (pred y)));

reffix = lambda g:(Nat->Nat->Nat)->(Nat->Nat->Nat).
            let r = ref (lambda x:Nat . lambda y:Nat . 0) in
	       (r := g (lambda x:Nat . lambda y:Nat . !r x y) ;
	       !r);
	    
add = reffix addg;

"add 3 0 = ";
add 3 0;
"add 3 1 = ";
add 3 1;

mul = reffix (lambda m:Nat->Nat->Nat . lambda x:Nat . lambda y: Nat .
                    m x y);
"mul 2 2 = ";
mul 2 2;
"mul 3 3 = ";
mul 3 3;

