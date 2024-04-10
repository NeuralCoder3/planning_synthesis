
```
docker build -f Dockerfile -t planning-synth ..

# in normal situation
docker run -it --rm planning-synth /bin/bash -c 'cd cd /etc/synth && fast-downward domain.pddl problem.pddl --search \"astar(merge_and_shrink())\"'

# if fast-downward is entry point
docker run -it --rm planning-synth domain.pddl problem.pddl --search "astar(merge_and_shrink())" 

docker tag planning-synth neuralcoder/planning-synth
docker push neuralcoder/planning-synth

# give no executable
arguments               = "/etc/synth/domain.pddl /etc/synth/problem.pddl --search 'astar(merge_and_shrink())'"
```
