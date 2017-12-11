SETS
       i   disposal site / 1*5 /
       j   sector   / 1*10 / ;

PARAMETER c(i)  capacity of site i /
$include "capacities.txt"
/;

PARAMETER d(j,i)  distance from disposal site i to sector j in kilometers /
$include "distances.txt"
/;

PARAMETER e(j)  estimated annual snow of sector j in thousand cubic meters / 
$include "estimates.txt"
/;

VARIABLES
Z       total cost for objective function ;

POSITIVE VARIABLE U(j,i)  0 or 1 indicating assignment of sector j to disposal site i;

EQUATIONS
COST        define total objective function
CAP(i)      capacity constraints
ASG(j)      assignment constraints;

COST..    Z =e= SUM((i,j), d(j,i) * U(j,i) * e(j) * 0.1 * 1000);
CAP(I)..  SUM(j, e(j) * U(j,i)) =L= c(i);
ASG(J)..  SUM(i, U(j,i))  =e=  1 ;

MODEL  GAP /ALL/ ;
Option MIP = Cplex;
option optca=0;
option optcr=0;
SOLVE GAP USING LP MINIMIZING Z ;

DISPLAY U.L, U.M;