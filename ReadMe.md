General:
https://en.wikipedia.org/wiki/Planning_Domain_Definition_Language

Extensions:
https://planning.wiki/ref/pddl/requirements#typing

FastDownward Heuristics/Support
https://www.fast-downward.org/Doc/Evaluator
https://www.fast-downward.org/PddlSupport

Usage
https://www.fast-downward.org/PlannerUsage




Example:

nix-shell -p fast-downward
# does not support conditional effect
fast-downward domain.pddl problem.pddl --search "astar(lmcut())"

fast-downward domain.pddl problem.pddl --evaluator "hff=ff()" --evaluator "hcea=cea()" --search "lazy_greedy([hff, hcea], preferred=[hff, hcea])"



astar(blind())
works with conditional effect









fast-downward domain.pddl problem.pddl --search "astar(ipdb())"






From Docu online:
fast-downward domain.pddl problem.pddl --search "astar(blind())"

admissible:
- blind
- hmax
- landmark_cost_partitioning(factory)
- landmark_sum(factory)
    lm_rhw, lm_zg
- merge_and_shrink

not admissible
- add
- cg
- ff
- goalcount
- hm (conditional ignored, not admissible)

admissible but not conditional
- cegar



https://www.fast-downward.org/Doc/SearchAlgorithm
astar
lazy_greedy
eager_greedy



fast-downward domain.pddl problem.pddl --evaluator "hff=ff()" --evaluator "hcea=cea()" --search "lazy_greedy([hff, hcea], preferred=[hff, hcea])"


fast-downward domain.pddl problem.pddl --alias seq-sat-lama-2011

















From Help

Examples:

Translate and find a plan with A* + LM-Cut:
fast-downward misc/tests/benchmarks/gripper/prob01.pddl --search "astar(lmcut())"

Translate and run no search:
fast-downward --translate misc/tests/benchmarks/gripper/prob01.pddl

Run predefined configuration (LAMA-2011) on translated task:
fast-downward --alias seq-sat-lama-2011 output.sas

Run a portfolio on a translated task:
fast-downward --portfolio driver/portfolios/seq_opt_fdss_1.py --search-time-limit 30m output.sas

Run the search component in debug mode (with assertions enabled) and validate the resulting plan:
fast-downward --debug output.sas --search "astar(ipdb())"

Pass options to translator and search components:
fast-downward misc/tests/benchmarks/gripper/prob01.pddl --translate-options --full-encoding --search-options --search "astar(lmcut())"

Find a plan and validate it:
fast-downward --validate misc/tests/benchmarks/gripper/prob01.pddl --search "astar(cegar())"




fast-downward --portfolio driver/portfolios/seq_opt_fdss_1.py domain.pddl problem.pddl

export SRCDIR=$PWD && \
cd $(dirname $(which fast-downward)) && \
cd ../lib/python3.10/site-packages/ && \
fast-downward --portfolio ./driver/portfolios/seq_opt_fdss_1.py $SRCDIR/domain.pddl $SRCDIR/problem.pddl && \
cd $SRCDIR
