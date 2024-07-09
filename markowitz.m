%DOWNLOAD and IMPORT .mat files to be able to run the data

%Source: https://finance.yahoo.com/

%The following are the table that consists of entries that represent the
%return on investments.
%The rows represent the daily date i (January 1, 2006 to January 1,
%2011), whereas the columns represent the investments j. 

%"Jimmy" reads the (sxt) table in "Currencies1.xlsx" as the variable
%"Currencies1".
Jimmy = Currencies1;
[s t] = size(Jimmy);

%"Emma" reads the (sxt) table in "Emma's.xlsx" as the variable
%"Emmas".
Emma = Emmas;

%"Avery" reads the (sxt) table in "Avery's.xlsx" as the variable
%"Averys".
Avery = Averys;

%"Ryan" reads the (sxt) table in "Ryan's.xlsx" as the variable
%"Ryans".
Ryan = Ryans;

%"Total" combines "Currencies1", "Emmas", "Averys", and "Ryans into a (qxr)
%tabl
Total = [Currencies1 Emmas Averys Ryans];
[q r] = size(Total);

%"Training1" takes the first 700 rows of the different matrices, 
%but still takes all the investments j.
%The first 700 rows denotes the 70 percent (training) of the total dataset.
Training1 = Jimmy(1:700,1:t);
Training2 = Emma(1:700,1:t);
Training3 = Avery(1:700,1:t);
Training4 = Ryan(1:700,1:t);
Training = Total(1:700,1:r);

%The following (line 42-46) converts training tables to training matrices.
Training1 = Training1{:,:};
Training2 = Training2{:,:};
Training3 = Training3{:,:};
Training4 = Training4{:,:};
Training = Training{:,:};

%The following (line 51-55) takes the next 200 rows of the different matrices, 
%but still takes all the investments j.
%These 200 rows denote the 20 percent (validation) of the total dataset.
Validation1 = Jimmy(701:900,1:t);
Validation2 = Emma(701:900,1:t);
Validation3 = Avery(701:900,1:t);
Validation4 = Ryan(701:900,1:t);
Validation = Total(701:900,1:r);

%The following (line 58-62) converts validation tables to validation matrices.
Validation1 = Validation1{:,:};
Validation2 = Validation2{:,:};
Validation3 = Validation3{:,:};
Validation4 = Validation4{:,:};
Validation = Validation{:,:};


%The following (line 68-72) takes the last 100 rows of the different matrices, 
%but still takes all the investments j.
%These 100 rows denote the 10 percent (testing) of the total dataset.
Testing1 = Jimmy(901:s,1:t);
Testing2 = Emma(901:s,1:t);
Testing3 = Avery(901:s,1:t);
Testing4 = Ryan(901:s,1:t);
Testing = Total(901:q,1:r);


%The following (line 76-80) converts testing tables to testing matrices.
Testing1 = Testing1{:,:};
Testing2 = Testing2{:,:};
Testing3 = Testing3{:,:};
Testing4 = Testing4{:,:};
Testing = Testing{:,:};

%muv is a row vector that increments mu by .01 from .0 to 10.
muv = [.0:.01:10]; 

%Define XX's to be the decision vectors used for the plotting of
%the training matrices.
XX1 = [];
XX2 = [];
XX3 = [];
XX4 = [];
XX = [];

%The matrix Training1 has m rows and n columns.
[m n] = size(Training1);
%The matrix Training has g rows and h columns.
[g h] = size(Training);

%The following variables are the mean returns on investment on instruments
%in the training matrices.
%f's are row vectors of the size 1xm.
f1 = mean(Training1); 
f2 = mean(Training2);
f3 = mean(Training3); 
f4 = mean(Training4);
f = mean(Training);

%em, en, and eh are row vectors whose entries are 1's, which appear m, n,
%and h times respectively.
em = ones(1,m); 
en = ones(1,n); 
eh = ones(1,h);

%The following variables take the mean returns and repeat m times. 
%This creates m same rows consisting of the entries in each f's. 
%S's are of the size mxn. 
S1 = repmat(f1,m,1); 
S2 = repmat(f2,m,1);
S3 = repmat(f3,m,1); 
S4 = repmat(f4,m,1);
S = repmat(f,m,1);

%The following variables aRE the mean return matrices S's subtracted from the training matrices with 
%provided return values.
AA1 = Training1-S1;
AA2 = Training2-S2;
AA3 = Training3-S3;
AA4 = Training4-S4;
AA = Training-S;

%I1 is an mxm identity matrix.
I1 = eye(m); 

%zz_avery is the Game Theory payoff for Avery's testing data.
%To check, run the gametheoryp2.m MATLAB file. 
zz_avery = 0.9888;


%The following for-loop is intended for keeping track of the reward and risk coordinates (for plotting).

%Note that size(muv,2) returns the number of columns in muv(which is 1001),
%because 2 refers to the column dimension of muv in this case.
for i = 1:size(muv,2) 
    %shows the i-th iteration.
    i

    %The following is the calculation for the reward and risk coordinates
    %using the training matrices.

    %c's is the cost vector for the matrix A.
    c1 = [muv(i)*f1 em*(-1/m)]'; 
    c2 = [muv(i)*f2 em*(-1/m)]';
    c3 = [muv(i)*f3 em*(-1/m)]'; 
    c4 = [muv(i)*f4 em*(-1/m)]';
    c = [muv(i)*f em*(-1/m)]'; 

    %Ain's and bin are provided and used for the inequality constraints
    %(for the training matrices).
    %Ain(1-4) is of the size (2m)x(m+n), Ain is of the size
    %(2m)x(m+h), bin is of the size (2m)x1.
    Ain1 = [-AA1 -I1; AA1 -I1]; 
    Ain2 = [-AA2 -I1; AA2 -I1];
    Ain3 = [-AA3 -I1; AA3 -I1]; 
    Ain4 = [-AA4 -I1; AA4 -I1];
    Ain = [-AA -I1; AA -I1];
    bin = [zeros(2*m,1)]; 

    %Aeq, Aeq1, and beq are provided and used for the equality constraint
    %(for the training matrices).
    %Aeq1 is of the size 1x(m+n), Aeq is of the size 1x(m+h), and beq is a
    %scalar.
    Aeq1 = [en 0*em];
    Aeq = [eh 0*em];
    beq = 1;

    %The following linprog commands are provided, using the
    %inequality and the equality constraints.
    [d1 val1] = linprog(-c1, Ain1, bin, Aeq1, beq, zeros(m+n,1))
    [d2 val2] = linprog(-c2, Ain2, bin, Aeq1, beq, zeros(m+n,1))
    [d3 val3] = linprog(-c3, Ain3, bin, Aeq1, beq, zeros(m+n,1))
    [d4 val4] = linprog(-c4, Ain4, bin, Aeq1, beq, zeros(m+n,1))
    [d val] = linprog(-c, Ain, bin, Aeq, beq, zeros(m+h,1))

    %y(1-4) are the decision vector portion of the size nx1, whereas y is of the
    %size hx1.
    y1 = d1(1:n);
    y2 = d2(1:n);
    y3 = d3(1:n);
    y4 = d4(1:n);
    y = d(1:h);

    %reward(i)'s is the multiplication of the decision vector y' by the
    %column mean return vector f'.
    %reward(i)'s are scalars.
    reward1(i) = y1'*f1';
    reward2(i) = y2'*f2';
    reward3(i) = y3'*f3';
    reward4(i) = y4'*f4';
    reward(i) = y'*f';

    %z's are the decision vector portion of the size mx1.
    z1 = d1(n+1:m+n);
    z2 = d2(n+1:m+n);
    z3 = d3(n+1:m+n);
    z4 = d4(n+1:m+n);
    z = d(h+1:m+h);

    %risk(i)'s are the mean of the entries in the vector z's.
    %risk(i)'s are scalars.
    risk1(i) = mean(z1');
    risk2(i) = mean(z2');
    risk3(i) = mean(z3');
    risk4(i) = mean(z4');
    risk(i) = mean(z');

    %XX's keep track of the decision vectors stored in it.
    XX1 = [XX1 d1];
    XX2 = [XX2 d2];
    XX3 = [XX3 d3];
    XX4 = [XX4 d4];
    XX = [XX d];
 
    %myval(i) is the payoff/reward for the combined validation data.
    myval(i) = y' *mean(Validation)';

    %mytest(i) is the payoff/reward for the combined testing data.
    mytest(i) = y' *mean(Testing)';

    %myval_avery(i) is the payoff/reward for Avery'svalidation data.
    myval_avery(i) = y3' *mean(Validation3)';

    %mytest_avery(i) is the payoff/reward for Avery's testing data.
    mytest_avery(i) = y3' *mean(Testing3)';

    %gt_avery(i) is the payoff/reward for Avery's testing data (Game Theory
    %version).
    gt_avery(i) = zz_avery;
end


%Figure 1
%The following 5 lines create a labelled plot of the Efficient Frontier
%graph (or Reward vs Risk graph) of the four individual portfolios and the
%combined portfolio.
figure('Name','The Efficient Frontier for the provided data set')
plot(reward1,risk1,'--o',reward2,risk2,'--o',reward3,risk3,'--o',reward4,risk4,'--o',reward,risk,'--o')
legend('Jimmy','Emma','Avery','Ryan','Combined Portfolio')
xlabel('Risk')
ylabel('Reward')

%Figure 2
%The following 5 lines create a labelled plot of Payoff for Validation and
%Testing vs Risk Parameter of the combined portfolio and Avery's portfolio.
figure('Name','Risk paramater vs reward')
plot(muv,myval,'-',muv,mytest,'-',muv,myval_avery,'-',muv,mytest_avery,'-')
legend('Validation','Testing','Validation (Avery)','Testing (Avery)')
xlabel("Risk Parameter")
ylabel("Payoff for Validation and Testing")

%Figure 3
%The following 5 lines create a labelled plot of Payoff for Avery's Testing
%vs Risk Parameter (Markowitz Portfolio and Game Theory Portfolio).
figure('Name','Risk paramater vs reward')
plot(muv,mytest_avery,'-',muv,gt_avery,'-')
legend('Markowitz Portfolio Testing (Avery)','Game Theory Portfolio Testing (Avery)')
xlabel("Risk Parameter")
ylabel("Payoff for Avery's Testing")