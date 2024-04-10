FROM aibasel/downward:latest

RUN mkdir -p /etc/synth
WORKDIR /etc/synth

# run meta.py first to create the domain and problem files
COPY domain.pddl /etc/synth/
COPY problem.pddl /etc/synth/
RUN chmod -R 777 /etc/synth

RUN useradd -u 2568315 -ms /bin/bash s8maullr
RUN chown -R s8maullr:s8maullr /etc/synth
USER s8maullr
WORKDIR /etc/synth

# CMD ["bash" "-c" "cd /etc/synth && ./run.sh | tee -a /home/s8maullr/results/synth_log.txt"]
