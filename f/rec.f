/* recursive types */

List = Rec X . < u: Unit,  n: { d:Nat, n: X}>;
ListU = < u:Unit, n:{d:Nat, n: List}>;

nil = fold [List] <u=unit> as ListU;
cons = lambda x:Nat .
           lambda r:List .
              fold [List] < n = { d = x, n = r } > as ListU;
isEmpty = lambda l:List.
            case (unfold [List] l) of
              <u=x> ==> true
            | <n=c> ==> false;

length = fix (lambda len : List -> Nat .
                lambda l : List .
                    case (unfold [List] l) of
                      <u=x> ==> 0
                    | <n=c> ==> succ (len c.n));

l123 = cons 1 (cons 2 (cons 3 nil));

isEmpty l123;
length l123;


/* Hungry FUnction (unfold [Hungry] hungry 1) 2 3 4 3 2 1; */

Hungry = Rec X . Nat -> X;

hungry = fix (lambda h : Hungry . fold [Hungry] (lambda x:Nat . h));

h1 = (unfold [Hungry] hungry) 12;

Stream = Rec S . Unit -> { current : Nat, rest : S };

from = fix (lambda f: Nat -> Stream .
              lambda n:Nat .
                 fold [Stream] ( lambda _: Unit . { current = n, rest = f(succ n)  } ) );
s1 = from 0;
r1 = (unfold [Stream] s1) unit;
r1.current;
s2 = r1.rest;
(unfold [Stream] s2) unit;
