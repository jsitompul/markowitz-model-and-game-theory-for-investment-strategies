%DOWNLOAD and IMPORT .mat files to be able to run the data
%Source: https://finance.yahoo.com/

%The following are the table that consists of entries that represent the
%return on investments.
%The rows represent the daily date i (January 1, 2006 to January 1,
%2011), whereas the columns represent the investments j. 

%"Jimmy" reads the (sxt) table in "Jimmy's.xlsx" as the variable
%"Averys".
Jimmy = Jimmys;
[s t] = size(Avery);

%A takes the last 100 rows of the different matrices, but still takes all
%the investments j.
%These 100 rows denote the 10 percent (testing) of the total dataset.
A = Jimmy(901:s,1:t);
%The following converts Jimmy's testing table to testing matrix.
A = A{:,:};

%The matrix A has m rows and n columns.
[m n] = size(A);

%em and en are row vectors whose entries are 1's, which appear m and n
%times respectively.
em = ones(m,1);
en = ones(n,1);

%c is the cost vector for the matrix A.
c = [0*en' 1]';
%Ain and bin are provided and used for the inequality constraints (for the matrix A).
Aineq = [-A em];
bineq = 0*em;
%Aeq and beq are provided and used for the equality constraints (for the matrix A).
Aeq = [en' 0];
beq = 1;
%We need to take into account that the decision variables are bounded below by zero but the value of the games is not (it is free).
lb=[0*en' -Inf]';

%linprog command (for the matrix A) is provided, considering the inequality and the equality constraints.
[xx zz_jimmy] = linprog(-c, Aineq, bineq, Aeq, beq, lb);

%The following displays the strategy for the column player.
display('Strategy for Column Player')
xx

%The following displays the payoff.
display('Payoff for either player')
%Be sure to negate the result since we are solving max zz_jimmy, which is the same as -min-zz_jimmy.
-zz_jimmy    