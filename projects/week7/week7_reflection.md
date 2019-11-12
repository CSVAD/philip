This library is intended to help people create their own "dancing
drawings" that are controllable via OSC interfaces. The goal is to make
it easier for folks to wire up interactive controller input to their
drawing.

The library seeks to be extremely simple to use. It requires zero
configuration, and implementing sketches can simply call
"dancingDrawings.getNormalizedDiscreteStepValue()" to get a value that
has been set by a discrete interface input, such as keyboard note pitch
value.

The methods I expose are getNormalizedDiscreteStepValue() and
getNormalizedContinuousValue().

OSC interfaces send to /dancing-drawings/discrete
and /dancing-drawings/continuous

on localhost:12002 to send these values to the library.

See an example video of the library in action at https://youtu.be/Huytn5cUjjU

