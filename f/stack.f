NodeImpl E L = < null:Unit, node : { data : E, next : L } >;
Node E = Rec L . NodeImpl E L;

Stack E X = { rep : X, push : X -> E -> Unit, pop : X -> E, isEmpty : X -> Bool };

StackRep E = { head : Ref (Node E) };

diverge = lambda T . lambda _:Unit . fix (lambda x:T . x);

linkedStack = lambda E . lambda def:E .
                let rep = { head = ref (fold [Node E] (< null = unit > as NodeImpl E (Node E))) } in
                    {*(StackRep E), 
		          {rep = rep, 
			   push = lambda r:StackRep E. lambda d:E .
                                     (r.head) := fold [Node E] 
                                                  ( < node = { data = d, 
                                                               next = !(r.head) } >
                                                    as NodeImpl E (Node E) ),
                           pop = lambda r:StackRep E. 
                                       case (unfold [Node E] (!(r.head))) of
                                         <node=n> ==> ((r.head) := (n.next) ; n.data)
                                       | <null=u> ==> def, /*diverge [E] (unit), */
                           isEmpty = lambda r:StackRep E. 
                                       case (unfold [Node E] (!(r.head))) of
                                         <null=u> ==> true
                                       | <node=n> ==> false }
	            } as {Some X, Stack E X};

s = linkedStack [Nat] (1001);

let {X, x} = s in x.isEmpty(x.rep);

let {X, x} = s in x.push(x.rep) 17;

let {X, x} = s in x.isEmpty(x.rep);

let {X, x} = s in x.pop(x.rep); 

let {X, x} = s in x.isEmpty(x.rep);

let {X, x} = s in x.pop(x.rep); 

let {X, x} = s in x.isEmpty(x.rep);
