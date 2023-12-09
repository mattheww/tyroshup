#import "fns.typ": dt, t, t2, rubric, std, syntax

= Expressions

#rubric[Syntax]

#syntax[```
   Expression ::=
       ExpressionWithBlock
     | ExpressionWithoutBlock

   ExpressionWithBlock ::=
       OuterAttributeOrDoc* (
           AsyncBlockExpression
         | BlockExpression
         | IfExpression
         | IfLetExpression
         | LoopExpression
         | MatchExpression
         | UnsafeBlockExpression
       )

   ExpressionWithoutBlock ::=
       OuterAttributeOrDoc* (
           ArrayExpression
         | AwaitExpression
         | BreakExpression
         | CallExpression
         | ClosureExpression
         | ContinueExpression
         | FieldAccessExpression
         | IndexExpression
         | LiteralExpression
         | MethodCallExpression
         | MacroInvocation
         | OperatorExpression
         | ParenthesizedExpression
         | PathExpression
         | RangeExpression
         | ReturnExpression
         | StructExpression
         | TupleExpression
         | UnderscoreExpression
       )

   ExpressionList ::=
       Expression ($$,$$ Expression)* $$,$$?

   Operand ::=
       Expression

   LeftOperand ::=
       Operand

   RightOperand ::=
       Operand
```]

#rubric[Legality Rules]

An #t("operand") is an #t("expression") nested within an #t("expression").

%SKIPPING%

#rubric[Dynamic Semantics]

#t("Evaluation") is the process by which an #t("expression") achieves its runtime effects.


== Dereference Expression

%SKIPPING%

The #t("value") of a #t("dereference expression") is determined as follows:

- If the #t("type") of the #t("operand") is `&mut T`, `&T`, `*mut T`, or `*const T`, then the #t("value") is the pointed-to #t("value").

- Otherwise the #t("value") is the result of evaluating #t("expression") `*core::ops::Deref::deref(&operand)` or #t("expression") `*core::ops::DerefMut::deref_mut(&mut operand)` respectively.

%SKIPPING%


== Invocation Expressions

=== Call Expressions

#rubric[Syntax]

#syntax[```
   CallExpression ::=
       CallOperand $$($$ ArgumentOperandList? $$)$$

   CallOperand ::=
       Operand

   ArgumentOperandList ::=
       ExpressionList
```]


#rubric[Legality Rules]

A #t("call expression") is an #t("expression") that invokes a #t("function") or constructs a #t("tuple enum variant value") or a #t("tuple struct value").

An #t("argument operand") is an #t("operand") which is used as an argument in a #t("call expression") or a #t("method call expression").

A #t("call operand") is the #t("function") being invoked or the #t("tuple enum variant value") or the #t("tuple struct value") being constructed by a #t("call expression").

%SKIPPING%

A #t("callee type") is either a #t("function item type"), a #t("function pointer type"), a #t("tuple enum variant"), a #t("tuple struct type"), or a #t("type") that implements any of the #std("core::ops::Fn"), #std("core::ops::FnMut"), or #std("core::ops::FnOnce") #t2("trait")[traits].

The #t("type") of a #t("call expression") is the #t("return type") of the invoked #t("function"), the #t("type") of the #t("tuple enum variant") or the #t("tuple struct") being constructed, or #t("associated type") #std("core::ops::FnOnce::Output").

A #t("call expression") whose #t("callee type") is either an #t("external function item type"), an #t("unsafe function item type"), or an #t("unsafe function pointer type") shall require #t("unsafe context").

The #t("value") of a #t("call expression") is determined as follows:

- If the #t("callee type") is a #t("function item type") or a #t("function pointer type"), then the #t("value") is the result of invoking the corresponding #t("function") with the #t2("argument operand")[argument operands].

- If the #t("callee type") is a #t("tuple enum variant") or a #t("tuple struct type"), then the #t("value") is the result of constructing the #t("tuple enum variant") or the #t("tuple struct") with the #t2("argument operand")[argument operands].

- If the #t("callee type") implements the #std("core::ops::Fn") #t("trait"), then the #t("value") is the result of invoking `core::ops::Fn::call(adjusted_call_operand, argument_operand_tuple)`, where `adjusted_call_operand` is the #t("adjusted call operand"), and `argument_operand_tuple` is a #t("tuple") that wraps the #t2("argument operand")[argument operands].

- If the #t("call operand") implements the #std("core::ops::FnMut") #t("trait"), then the #t("value") is the result of invoking `core::ops::FnMut::call_mut(adjusted_call_operand, argument_operand_tuple),` where `adjusted_call_operand` is the #t("adjusted call operand"), and `argument_operand_tuple` is a #t("tuple") that wraps the #t2("argument operand")[argument operands].

- If the #t("call operand") implements the #std("core::ops::FnOnce") #t("trait"), then the #t("value") is the result of invoking `core::ops::FnOnce::call_once(adjusted_call_operand, argument_operand_tuple),` where `adjusted_call_operand` is the #t("adjusted call operand"), and `argument_operand_tuple` is a #t("tuple") that wraps the #t2("argument operand")[argument operands].

A #t("call expression") is subject to #t("call resolution").


#rubric[Dynamic Semantics]

The #t("evaluation") of a #t("call expression") proceeds as follows:

+ The #t("call operand") is evaluated.

+ The #t2("argument operand")[argument operands] are evaluated in left-to-right order.

+ If the #t("adjusted call operand") is a #t("function item type") or
  #t("function pointer type"), then corresponding #t("function") is invoked.

+ If the #t("type") of the #t("call operand") implements the #std("core::ops::Fn") #t("trait"), then `core::ops::Fn::call(adjusted_call_operand, argument_operand_tuple)` is invoked.

+ If the #t("type") of the #t("call operand") implements the #std("core::ops::FnMut") #t("trait"), then `core::ops::FnMut::call_mut(adjusted_call_operand, argument_operand_tuple)` is invoked.

+ If the #t("type") of the #t("call operand") implements the #std("core::ops::FnOnce") #t("trait"), then `core::ops::FnOnce::call_once(adjusted_call_operand, argument_operand_tuple)` is invoked.


#rubric[Undefined Behavior]

It is undefined behavior to call a #t("function") with an #t("ABI") other than the #t("ABI") the #t("function") was defined with.


#rubric[Examples]

```rust
   let three: i32 = add(1, 2);
```

=== Call Conformance

%SKIPPING%

An #t("argument operand") matches a #t("function parameter") or #t("field") of the #t("callee type") when its position and the position of the #t("function parameter") or #t("field") are the same.
Such an #t("argument operand") is a #dt("matched argument operand").

The #t("type") of a #t("matched argument operand") and the #t("type") of the corresponding #t("function parameter") or #t("field") shall be #t("unifiable").

The number of #t2("argument operand")[argument operands] shall be equal to the number of #t2("field")[fields] or #t2("function parameter")[function parameters] of the #t("callee type").


== Return Expressions

#rubric[Syntax]

#syntax[```
   ReturnExpression ::=
       $$return$$ Expression?
```]


#rubric[Legality Rules]

A #t("return expression") is an #t("expression") that optionally yields a #t("value") and causes control flow to return to the end of the enclosing #t("control flow boundary").

A #t("return expression") shall appear within a #t("control flow boundary").

The #t("type") of a #t("return expression") is the #t("never type").

The #t("value") returned by a #t("return expression") is determined as follows:

- If the #t("return expression") has an #t("operand"), then the #t("value") is the #t("value") of the #t("operand").

- If the #t("return expression") does not have an #t("operand"), then the #t("value") is the #t("unit value").


#rubric[Dynamic Semantics]

The #t("evaluation") of a #t("return expression") proceeds as follows:

+ If the #t("return expression") has an #t("operand"), then

  + The #t("operand") is evaluated.

  + The #t("value") of the #t("operand") is #t2("passing convention")[passed] #t("by move") into the designated output location of the enclosing #t("control flow boundary").

+ Control destroys the current activation frame.

+ Control is transferred to the caller frame.


#rubric[Examples]

```rust
   fn max(left: i32, right: i32) -> i32 {
       if left > right {
           return left;
       }
       return right;
   }
```

