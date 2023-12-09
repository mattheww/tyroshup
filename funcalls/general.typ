#import "fns.typ": dt, t, t2, rubric, syntax, editorial

= General

This document contains some of the text from a couple of pages of the Ferrocene Language Specification (commit `ab6469ca23` from 2023-10-05).

It covers call expressions and return expressions.

%SKIPPING% indicates a place where material has been cut out.


== Structure

Each chapter is divided into subchapters that have a common structure.
Each chapter and subchapter is then organized to include the following segments as is relevant to the topic:


#rubric[Syntax]

The syntax representation of a #t("construct").


#rubric[Legality Rules]

Compile-time rules and facts for each #t("construct").
A #t("construct") is legal if it obeys all of the Legality Rules.


#rubric[Dynamic Semantics]

Run-time effects of each #t("construct").


#rubric[Undefined Behavior]

Situations that result in unbounded errors.


#rubric[Implementation Requirements]

Additional requirements for conforming tools.


#rubric[Examples]

Examples illustrating the possible forms of a #t("construct").
This material is informative.


== Method of Description and Syntax Notation

The form of a Rust program is described by means of a context-free syntax together with context-dependent requirements expressed by narrative rules.

The meaning of a Rust program is described by means of narrative rules defining both the effects of each construct and the composition rules for constructs.

The context-free syntax of Rust is described using a simple variant of the Backus-Naur form.
In particular:

- A `monospaced` font is used to denote Rust syntax.

- Words in PascalCase font are used to denote a syntactic category, for example:

```
   FloatExponent
```

- Words in *bold* font are used to indicate literal words and
  #t2("keyword")[keywords], for example:

#syntax[```
    $$crate$$
    $$proc_macro_derive$$
    $$Self$$
    $$tt$$
```]

#editorial[We'd want some kind of custom processing for this, in particular
interpreting the \$\$ markup.]

%SKIPPING%


== Definitions

Terms are defined throughout this document, indicated by _italic_ type.
Terms explicitly defined in this document are not to be presumed to refer implicitly to similar terms defined elsewhere.

%SKIPPING%

The definitions of terms are available in #link(label("glossary"))[Glossary].

A _rule_ is a requirement imposed on the programmer, stated in normative language such as "shall", "shall not", "must", "must not", except for text under Implementation Requirements heading.

A _fact_ is a requirement imposed on a conforming tool, stated in informative language such as "is", "is not", "can", "cannot".

