# AFL-EDGE

## Overview
Fuzz testing has become one of the de facto standard techniques for bug finding in the software industry. However, most of the popular fuzzing tools naively run multiple instances concurrently, without elaborate distribution of workload. This can lead different instances to explore overlapped code regions, eventually reducing the benefits of concurrency. We develop a solution, called AFL-EDGE, to improve the parallel mode of AFL, considering a round of mutations to a unique seed as a task and adopting edge coverage to define the uniqueness of a seed.
