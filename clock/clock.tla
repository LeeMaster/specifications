---- MODULE clock ----
\* Specifying System Ch2 simple clock 
EXTENDS Naturals, TLC

VARIABLE hr

Cinit == hr \in 1..12 

Cnext == hr' = IF hr # 12 THEN hr + 1 ELSE hr 

C == Cinit /\ [][Cnext]_hr

\* TODO: I don't think this specification need this theorem for C imples the Cinit 
\* Because the state machine theory 
THEOREM C => Cinit
====