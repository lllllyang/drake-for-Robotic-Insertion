# title
A Planning Framework for Robotic Insertion Tasks via Hydroelastic Contact Model

# Abstract: 
Robotic contact-rich insertion tasks present a significant challenge for motion planning
due to the complex force interaction between robots and objects. Although many learning-based
methods have shown success in contact tasks, most methods need sampling or exploring to gather
sufficient experimental data. However, it is both time-consuming and expensive to conduct real-
world experiments repeatedly. On the other hand, while the virtual world enables low cost and
fast computations by simulators, there still exists a huge sim-to-real gap due to the inaccurate point
contact model. Although finite element analysis might generate accurate results for contact tasks,
it is computationally expensive. As such, this study proposes a motion planning framework with
bilevel optimization to leverage relatively accurate force information with fast computation time.
This framework consists of Dynamic Movement Primitives (DMPs) used to parameterize motion
trajectories, Black-Box Optimization (BBO), a derivative-free approach, integrated to improve contact-
rich insertion policy with hydroelastic contact model, and simulated variability to account for visual
uncertainty in the real world. The accuracy of the simulated model is then validated by comparing
our contact results with a benchmark Peg-in-Hole task. Using these integrated DMPs and BBO with
hydroelastic contact model, the motion trajectory generated in planning is capable of guiding the
robot towards successful insertion with iterative refinement

![test result rollout =1](https://github.com/lllllyang/drake-for-Robotic-Insertion/assets/110092628/31c17163-857f-4e2a-adc5-354bd495a6e1)


# Introduction

This repo supports the simulated data and the code to plot the figures in our paper.

