T1 = Nat;
T2 = Nat -> Nat;

myfix = lambda f : (T1 -> T2) -> (T1 -> T2) .
          (lambda x:Rec A . A -> (T1 -> T2) . 
              f (lambda y:T1 . (unfold[Rec A . A -> T1 -> T2]x) x y))
          (fold[Rec A . A -> T1 -> T2]
              (lambda x:Rec A . A -> (T1 -> T2) . 
                  f (lambda y:T1 . (unfold[Rec A . A -> T1 -> T2]x) x y)));

