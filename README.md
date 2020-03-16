# J2-algorithm-DOE
_Matlab implementation of the J2-optimal OA/NOA constructor for Design of Experiments_



## J2-OPTIMALITY BASED ORTHOGONAL ARRAY/NEARLY-ORTHOGONAL ARRAY ALGORITHM IMPLEMENTATION


In the design of large experiments, there is a need to balance statistical quality of the experiment design against the cost and scope of conducting the experiments. Sometimes in engineering problems with several impacting "factors" at several possible "levels", the available data and models are insufficient, but the amount of data required would have to come from a really large experiment, one which is almost impractical to conduct in reality. In order to simplify the model, it is crucial to forego a full-factorial design and move towards a close-to-optimal trade-off - the orthogonal array (OA) or the nearly-orthogonal array (NOA). These let experiment designers to use all the factors to create a model, the experiment results of which can be extrapolated to obtain granular information within the modelling set. This becomes especially important if the experiment design contains mixed levels, i.e. each factor having unequal number of levels.

Detailed in Xu (2002) is an algorithm for constructing OAs/NOAs for mixed levels and small run sizes.

This project is an implementation of the algorithm for the MATLAB environment. The project presently contains only a Matlab command-line interface for manipulation - a GUI will be added for greater simplicity in designing complex experiments.



## WHY MAKE IT?

For a project in composite materials (glass/aramid/carbon fibres in a variety of matrix materials), we wanted to create a tool for material selection to aid the design of composite materials. We realized that since the emergent mechanical properties of composites depend on at least 8-12 factors (material type, layup sequence, weave type, matrix material, dimensions, etc.), designing complex composite parts with greater accuracy requires very strong material property models. It is also inefficient to have to run finite element simulations at the level of abstraction of the ply sequence every single time. Having better material models would help the engineering/product lifecycle.

As an engineer in an early-stage endeavour, there was very limited access to paid/premium material engineering software tools, e.g. GRANTA Selector. There was a specific set of materials that the team was trying to explore, and would probably run some destructive testing on test coupons to build the model too. So it was efficient to create a standalone tool internally to design such a complex experiment and reduce the cost of manual testing by reducing the number of individual trials required.

The implementation is based on the aforementioned paper by Xu (2002). A link to the paper is included for further reference.



## DISCLAIMER
[The code is presently not being actively maintained (as of 16-03-2020), so please be vigilant of errors and bugs while adapting to use.]




Please feel free to share any notes, feedback, or insights on the tool. Would love to hear it.
