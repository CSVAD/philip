# Dancing Drawings

This library for processing makes it as easy as 1-2-3 to control your drawings with an interface that speaks OSC.

1. Import the library and initialize it

```java
import dancingDrawings.*;
import oscP5.*;
DancingDrawings dancingDrawings;
	
	
void setup() {
  size(360, 560);
  dancingDrawings = new DancingDrawings(this);
}
```

2. Animate your drawing by calling one of the two "getter" functions

```java
void draw() {
  ellipse(
    180,
    // call getNormalizedContinuousValue() to get a value that has been set by a continuous controller
    // such as mod-wheel or aftertouch.
    280 + dancingDrawings.getNormalizedContinuousValue()*10.0,
    200,
    // call getNormalizedDiscreteStepValue() to get a value that has been set by a discrete stepped controller
    // such as a keyboard.
    300 + dancingDrawings.getNormalizedDiscreteStepValue()*10.0
  ); 

```

3. Configure your OSC interface to send to localhost:12002 and use the following addresses:

   send stepped values to `/dancing-drawings/discrete`
   
   send continuous values to `/dancing-drawings/continuous`



### Custom OSC address namespace

pass a second argument to the constructor to create your own namespaced OSC address space:

```java
void setup() {
  size(360, 560);
  dancingDrawings = new DancingDrawings(this, '/my-app');
}
```

your dancing drawing will now be listening for OSC messages addressed to:
	
`/my-app/discrete` and `/my-app/continuous`

### Demo

[Potato Man True Confessions](http://www.youtube.com/watch?v=Huytn5cUjjU "Potato Man True Confessions")

<iframe  title="YouTube video player" width="480" height="390" src="http://www.youtube.com/watch?v=Huytn5cUjjU?autoplay=0" frameborder="0" allowfullscreen></iframe>