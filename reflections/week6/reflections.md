# Week 6

## User Interface: A Personal View

The work of Bruner, building on Piaget, suggests 3 separate mentalities:
* enactive
  * know where you are, manipulate
* iconic
  * recognize, compare, configure, concrete
* symbolic
  * tie together longs chains of reasoning, abstract


> because none of the mentalities are supremely useful to the exclusion of the others, the best strategy would be to gently force synergy between them in the user interface design.

Thinking of the three mentalities is fascinating. I reflect on how challenging it can be for me to switch from a programming headspace to a musical creative exploration headspace. Programming often involves going deep into the symbolic mentality. I did a bit more reading on Bruner, and I believe that my music practice involves a combination of the _enactive_ and _iconic_ mentalities.

It is bizarre that Kay ends his insightful text with the strange suggestion that we need a weapon as a tool to explore the new world of developing user interfaces to connect to our work and to our colleagues.

## Instrumental Interaction

Shneiderman's Principles of Direct Manipulation:

1. Continuous representation of objects of interest

2. Physical actions on objects vs complex syntax

3. Fast, incremental, and reversible operations with an immediately-apparent effect on the objects of interest

4. Layered or spiral approach to learning

> This is
especially cumbersome when trial-and-error is an integral
part of the task, as when a graphics designer selects a font
size: specifying the point size numerically is annoying
when the goal is to see the visual result on the page.

Reflecting on my experience with font configuration interfaces-- I'm used to a flow where I ...
1. enter 10pt
2. observe the effect
3. alter the size to 20pt
4. if too big,  halve to 15pt
5. continue as in binary search

This is a bizarre and inefficient input mechanism for adjusting a visual property.

> Reification is a process for turning concepts into objects. In user interfaces, the resulting objects can be represented explicitly on the screen and operated upon.

> The degree of integration measures the ratio between the
number of degrees of freedom (DOF) provided by the logical
part of the instrument and the number of DOFs captured by
the input device. This term comes from the notion of
integral tasks [17]: some tasks are performed more
efficiently when the various DOFs are controlled
simultaneously with a single device.

Degree of Integration (DoI) is an interesting lens by which to reflect on the potential of hand-tracking and bi-manual interfaces. Hands have high DoF, so it seems the DoI will always be greater than 1. If the application achieves DoI of 1, it would indicate that every DoF of the hand(s) have a corrolary in the instrument's logic. While this is possible, this types of user interface will be much more difficult to learn.


## Alternative Programming Interfaces for Alternative Programmers

1. physical
  > Communicating text back and forth is
  a turn-based experience. Programmer talks, computer
  talks, etc. Alternative interfaces can allow for a continuous feedback loop between human and computer. For
  example, each of the patch-based visual environments allow the user to adjust parameters with sliders, and see
  the results of these changes in realtime.

  This continuous feedback loop brings computer interfaces closer to musical instruments, and result in rich interactions for fine tuning as well as exploratory search.

2. conceptual
> Conceptual interfaces are largely
equivalent with the semantics of a programming language.
They are the key mental structures that must exist solidly and
isomorphically in the mind of the programmer and the mind
of the computer (that is, in its implementation), in order for
programmer and computer to collaborate effectively.
3. social

### Who are Alternative Programmers
>  To support improvisation, a programming interface must first provide continuous feedback, as
turn-based feedback will impart its own rhythm on the
improvisation. Second it must let the improviser work directly in the representation of concern.

YES! I had not made the mental link to improvisation-- but the word and concept resonate very nicely in my understanding of what constitutes a well-designed interface. As a musician, I undertand improvisation in a certain musical way, while as a tool-user, I understand improvisation as a way of exploring and learning.

### Recursive Drawing
Leveraging recursion using principles of direct manipulation and continuous feedback was very satisfying, and provided the "ah-ha" recursive moment while interacting in a visual, iconic environment (rather than a symbolic and turn-based environment of coding).

> In each of these examples, when I started from a reductionist perspective, the primitives of the model determined
the transformations that were available to the programmer.
This could be seen as a pernicious form of representation
exposure. In the alternate version, the transformations available in a given context were considered first. These transformations then implied an appropriate model to display to the
programmer in that context.

Makes me think of the suggestion to "design for interactions, not for interfaces"

Recursive Drawing is a fantastic example of an alternative programming environment that leverages direct manipulation to to enable recursive design techniques for programmers of all skill levels.
