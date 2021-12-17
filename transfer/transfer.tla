---- MODULE transfer ----
EXTENDS Naturals, TLC


(* --algorithm Transfer
\* will be error because alice account in some case have not enough money to tranfer 
\* TODO: should add a account amount check before transfering
variables alice_account = 10, bob_account = 10, money \in 1..20;

begin 
AliceWithdraw: alice_account := alice_account - money;
BobDeposit: bob_account := bob_account + money;
AliceAmountCheck: assert alice_account >= 0;

end algorithm *)
\* BEGIN TRANSLATION (chksum(pcal) = "41d90e8f" /\ chksum(tla) = "6006398a")
VARIABLES alice_account, bob_account, money, pc

vars == << alice_account, bob_account, money, pc >>

Init == (* Global variables *)
        /\ alice_account = 10
        /\ bob_account = 10
        /\ money \in 1..20
        /\ pc = "AliceWithdraw"

AliceWithdraw == /\ pc = "AliceWithdraw"
                 /\ alice_account' = alice_account - money
                 /\ pc' = "BobDeposit"
                 /\ UNCHANGED << bob_account, money >>

BobDeposit == /\ pc = "BobDeposit"
              /\ bob_account' = bob_account + money
              /\ pc' = "AliceAmountCheck"
              /\ UNCHANGED << alice_account, money >>

AliceAmountCheck == /\ pc = "AliceAmountCheck"
                    /\ Assert(alice_account >= 0, 
                              "Failure of assertion at line 13, column 19.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << alice_account, bob_account, money >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == AliceWithdraw \/ BobDeposit \/ AliceAmountCheck
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

====
