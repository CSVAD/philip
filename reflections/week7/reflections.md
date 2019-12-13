## Learnable Programming

I found this essay to be extremely insightful and thought-provoking.

Viktor's criticism of Processing is well-aimed. Regarding his criticism of the simple line of code `ellipse(202, 100, 80)`:
> Why do we consider the code acceptable and the UI not? Why do we expect programmers to "look up" functions in "documentation", while modern user interfaces are designed so that documentation is typically unnecessary?

 I found myself initially responding _"oh, you just have to learn how to search the docs... its how programming works"_...

...Before realizing that programming doesn't _have_ to work this way-- we get to choose how to re-invent programming environments and languages.

> Experienced programmers might look at this example and consider this a programmer's error, because this is "just how code works." But this error is not intrinsic to programming; it's a consequence of specific design decisions -- mutable state, global variables, no encapsulation.

Yes. Yes. Yes.


> All computation in Smalltalk is represented by objects sending and responding to messages from other objects. In order to program the behavior of an object, the programmer casts herself into the role of that object (to the extent of referring to the object as "self"!) and thinks of herself as carrying on a conversation with other objects.

Smalltalk inspired my favorite programming language, Ruby. Ruby objects receive messages and report internal state or invoke the matching method. This design, along with a flexible class model, uniquely facilitate metaprogramming. Metaprogramming in ruby makes it possible for developers to create their own domain-specific languages (DSL). One example of of a popular DSL is the RSpec ruby gem designed for writing readable test suites.

## Extending Manual Practices with Artist-Centric Programming Tools

> The importance of continuous production corresponds with Cziksentmihalyi’s concept of flow, an invested and active creative state [12].

This is definitely something I want to dig into. Being in the flow is how I would describe my favorite moments in my musical practice. Will read Cziksentimihalyi's work.

> Visual programming languages reduce some of the challenges
of programming, but they still require artists and designers to
work through an abstract description rather than a concrete
artifact [61]. An alternative approach involves creating and
manipulating procedural relationships through direct manipulation.

My takeaway from watching videos of DB is that the design of these brushes is challenging because it is still so far removed from the act of drawing. Direct manipulation of the procedural relationships is a compelling approach-- and I can see both the potential for incorporating that in DB, as well as well as the challenges of designing a UI that can support multiple approaches while still being accessible. Excited to see where you take it.

> Traditional manual tools and direct-manipulation
environments enable artists to sense what to try and when and
intuit which tool to use [40]. By contrast, the breadth of many
programming languages requires even expert programmers to
regularly stop and consult references [7].

###

How we can teach non-programmers

- for textual programming environments, "hello world" makes sense because everything is text
- for arts/design it makes more sense for the intro lesson to involve
  drawing or shape generation
