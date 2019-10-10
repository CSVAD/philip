# Design Galleries

The Design Galleries approach can provide value for designers when the render task is computationally intensive, as long as the output vectors are well-selected and tuned for the task at hand. I understand it as an evolution of the Inverse Design approach, because the system still needs a methodology for selecting the renders that a human user is most likely to find interesting.

This approach can be broadly generalized to any kind of design task wherein

Question:
I had trouble understanding the methodology described

> The output vector should be a concise, efficiently computed set
of values that summarizes the perceptual qualities of the final image. Thus, output vectors are based on pixel luminances from several low-resolution thumbnail images (32  25 pixels and smaller).
The luminances at resolution  are weighted by a factor f (). The
distance metric on the output vector is the standard L1
(Manhattan) distance.

Later, they compare the output vector for scene-lighting vs transfer function cases.

> For the scene-lighting DG, the output vector contains approximately 850 weighted pixel luminances. This kind of resolution is necessary because lights can cause completely local illumination effects in a synthetically rendered image, effects that should be representable in the output vector. In comparison, changes to transfer functions will generally affect many pixels throughout a volume rendered image. We can take advantage of this homogeneity by including only a handful of pixels in the output vector.

### Criticism:

> Inverse design is one technique for setting parameters, but it is
only feasible when the user can articulate or quantify what is desired.

Choosing output vectors is... in some way, _is_ quantifying what is desired.

>DGs replace this requirement with the much weaker one of
quantifying similarity between graphics. Unlike interactive evolution, DGs are feasible even when the graphics-generating process has high computational cost. Finally, DGs are useful even when the user has absolutely no idea what is desired, but wants to know what
the possibilities are.

If the user has no idea what is desired, it seems unlikely that they would
* choose output vectors
* schedule/config and overnight offline rendering task
