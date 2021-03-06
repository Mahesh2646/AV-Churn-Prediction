getwd()
setwd("~/Kaggle/av/churn pred/data bck")


library(dplyr)
library(data.table)
library(Matrix)
library(xgboost)
library(caret)
library(dplyr)
library(MLmetrics)


train <- read.csv("train.csv")
test  <- read.csv("test.csv") 


train$D_prev<- (train$D_prev1 +( .8 *train$D_prev2)+ (.8*train$D_prev3)+(0.8*train$D_prev4)+(0.6*train$D_prev5)+(0.6*train$D_prev6))
train$COUNT_MB_C_prev<- (train$COUNT_MB_C_prev1 +( .8 *train$COUNT_MB_C_prev2)+ (.8*train$COUNT_MB_C_prev3)+(0.8*train$COUNT_MB_C_prev4)+(0.6*train$COUNT_MB_C_prev5)+(0.6*train$COUNT_MB_C_prev6))
train$count_C_prev<- (train$count_C_prev1 +( .8 *train$count_C_prev2)+ (.8*train$count_C_prev3)+(0.8*train$count_C_prev4)+(0.6*train$count_C_prev5)+(0.6*train$count_C_prev6))
train$ATM_amt_prev<- (train$ATM_amt_prev1 +( .8 *train$ATM_amt_prev2)+ (.8*train$ATM_amt_prev3)+(0.8*train$ATM_amt_prev4)+(0.6*train$ATM_amt_prev5)+(0.6*train$ATM_amt_prev6))
train$CR_AMB_Prev<- (train$CR_AMB_Prev1 +( .8 *train$CR_AMB_Prev2)+ (.8*train$CR_AMB_Prev3)+(0.8*train$CR_AMB_Prev4)+(0.6*train$CR_AMB_Prev5)+(0.6*train$CR_AMB_Prev6))
train$ATM_C_prev<- (train$ATM_C_prev1 +( .8 *train$ATM_C_prev2)+ (.8*train$ATM_C_prev3)+(0.8*train$ATM_C_prev4)+(0.6*train$ATM_C_prev5)+(0.6*train$ATM_C_prev6))
train$MB_C_prev<- (train$MB_C_prev1 +( .8 *train$MB_C_prev2)+ (.8*train$MB_C_prev3)+(0.8*train$MB_C_prev4)+(0.6*train$MB_C_prev5)+(0.6*train$MB_C_prev6))
train$ATM_CW_Amt_prev<- (train$ATM_CW_Amt_prev1 +( .8 *train$ATM_CW_Amt_prev2)+ (.8*train$ATM_CW_Amt_prev3)+(0.8*train$ATM_CW_Amt_prev4)+(0.6*train$ATM_CW_Amt_prev5)+(0.6*train$ATM_CW_Amt_prev6))
train$COUNT_IB_C_prev<- (train$COUNT_IB_C_prev1 +( .8 *train$COUNT_IB_C_prev2)+ (.8*train$COUNT_IB_C_prev3)+(0.8*train$COUNT_IB_C_prev4)+(0.6*train$COUNT_IB_C_prev5)+(0.6*train$COUNT_IB_C_prev6))
train$ATM_CW_Cnt_prev<- (train$ATM_CW_Cnt_prev1 +( .8 *train$ATM_CW_Cnt_prev2)+ (.8*train$ATM_CW_Cnt_prev3)+(0.8*train$ATM_CW_Cnt_prev4)+(0.6*train$ATM_CW_Cnt_prev5)+(0.6*train$ATM_CW_Cnt_prev6))
train$COUNT_POS_C_prev<- (train$COUNT_POS_C_prev1 +( .8 *train$COUNT_POS_C_prev2)+ (.8*train$COUNT_POS_C_prev3)+(0.8*train$COUNT_POS_C_prev4)+(0.6*train$COUNT_POS_C_prev5)+(0.6*train$COUNT_POS_C_prev6))
train$ATM_D_prev<- (train$ATM_D_prev1 +( .8 *train$ATM_D_prev2)+ (.8*train$ATM_D_prev3)+(0.8*train$ATM_D_prev4)+(0.6*train$ATM_D_prev5)+(0.6*train$ATM_D_prev6))
train$custinit_DR_amt_prev<- (train$custinit_DR_amt_prev1 +( .8 *train$custinit_DR_amt_prev2)+ (.8*train$custinit_DR_amt_prev3)+(0.8*train$custinit_DR_amt_prev4)+(0.6*train$custinit_DR_amt_prev5)+(0.6*train$custinit_DR_amt_prev6))
train$BAL_prev<- (train$BAL_prev1 +( .8 *train$BAL_prev2)+ (.8*train$BAL_prev3)+(0.8*train$BAL_prev4)+(0.6*train$BAL_prev5)+(0.6*train$BAL_prev6))
train$IB_C_prev<- (train$IB_C_prev1 +( .8 *train$IB_C_prev2)+ (.8*train$IB_C_prev3)+(0.8*train$IB_C_prev4)+(0.6*train$IB_C_prev5)+(0.6*train$IB_C_prev6))
train$BRANCH_C_prev<- (train$BRANCH_C_prev1 +( .8 *train$BRANCH_C_prev2)+ (.8*train$BRANCH_C_prev3)+(0.8*train$BRANCH_C_prev4)+(0.6*train$BRANCH_C_prev5)+(0.6*train$BRANCH_C_prev6))
train$POS_C_prev<- (train$POS_C_prev1 +( .8 *train$POS_C_prev2)+ (.8*train$POS_C_prev3)+(0.8*train$POS_C_prev4)+(0.6*train$POS_C_prev5)+(0.6*train$POS_C_prev6))
train$BRANCH_D_prev<- (train$BRANCH_D_prev1 +( .8 *train$BRANCH_D_prev2)+ (.8*train$BRANCH_D_prev3)+(0.8*train$BRANCH_D_prev4)+(0.6*train$BRANCH_D_prev5)+(0.6*train$BRANCH_D_prev6))
train$count_D_prev<- (train$count_D_prev1 +( .8 *train$count_D_prev2)+ (.8*train$count_D_prev3)+(0.8*train$count_D_prev4)+(0.6*train$count_D_prev5)+(0.6*train$count_D_prev6))
train$BRN_CASH_Dep_Amt_prev<- (train$BRN_CASH_Dep_Amt_prev1 +( .8 *train$BRN_CASH_Dep_Amt_prev2)+ (.8*train$BRN_CASH_Dep_Amt_prev3)+(0.8*train$BRN_CASH_Dep_Amt_prev4)+(0.6*train$BRN_CASH_Dep_Amt_prev5)+(0.6*train$BRN_CASH_Dep_Amt_prev6))
train$COUNT_IB_D_prev<- (train$COUNT_IB_D_prev1 +( .8 *train$COUNT_IB_D_prev2)+ (.8*train$COUNT_IB_D_prev3)+(0.8*train$COUNT_IB_D_prev4)+(0.6*train$COUNT_IB_D_prev5)+(0.6*train$COUNT_IB_D_prev6))
train$BRN_CASH_Dep_Cnt_prev<- (train$BRN_CASH_Dep_Cnt_prev1 +( .8 *train$BRN_CASH_Dep_Cnt_prev2)+ (.8*train$BRN_CASH_Dep_Cnt_prev3)+(0.8*train$BRN_CASH_Dep_Cnt_prev4)+(0.6*train$BRN_CASH_Dep_Cnt_prev5)+(0.6*train$BRN_CASH_Dep_Cnt_prev6))
train$COUNT_MB_D_prev<- (train$COUNT_MB_D_prev1 +( .8 *train$COUNT_MB_D_prev2)+ (.8*train$COUNT_MB_D_prev3)+(0.8*train$COUNT_MB_D_prev4)+(0.6*train$COUNT_MB_D_prev5)+(0.6*train$COUNT_MB_D_prev6))
train$BRN_CW_Amt_prev<- (train$BRN_CW_Amt_prev1 +( .8 *train$BRN_CW_Amt_prev2)+ (.8*train$BRN_CW_Amt_prev3)+(0.8*train$BRN_CW_Amt_prev4)+(0.6*train$BRN_CW_Amt_prev5)+(0.6*train$BRN_CW_Amt_prev6))
train$COUNT_POS_D_prev<- (train$COUNT_POS_D_prev1 +( .8 *train$COUNT_POS_D_prev2)+ (.8*train$COUNT_POS_D_prev3)+(0.8*train$COUNT_POS_D_prev4)+(0.6*train$COUNT_POS_D_prev5)+(0.6*train$COUNT_POS_D_prev6))
train$BRN_CW_Cnt_prev<- (train$BRN_CW_Cnt_prev1 +( .8 *train$BRN_CW_Cnt_prev2)+ (.8*train$BRN_CW_Cnt_prev3)+(0.8*train$BRN_CW_Cnt_prev4)+(0.6*train$BRN_CW_Cnt_prev5)+(0.6*train$BRN_CW_Cnt_prev6))
train$custinit_CR_cnt_prev<- (train$custinit_CR_cnt_prev1 +( .8 *train$custinit_CR_cnt_prev2)+ (.8*train$custinit_CR_cnt_prev3)+(0.8*train$custinit_CR_cnt_prev4)+(0.6*train$custinit_CR_cnt_prev5)+(0.6*train$custinit_CR_cnt_prev6))
train$C_prev<- (train$C_prev1 +( .8 *train$C_prev2)+ (.8*train$C_prev3)+(0.8*train$C_prev4)+(0.6*train$C_prev5)+(0.6*train$C_prev6))
train$custinit_DR_cnt_prev<- (train$custinit_DR_cnt_prev1 +( .8 *train$custinit_DR_cnt_prev2)+ (.8*train$custinit_DR_cnt_prev3)+(0.8*train$custinit_DR_cnt_prev4)+(0.6*train$custinit_DR_cnt_prev5)+(0.6*train$custinit_DR_cnt_prev6))
train$CNR_prev<- (train$CNR_prev1 +( .8 *train$CNR_prev2)+ (.8*train$CNR_prev3)+(0.8*train$CNR_prev4)+(0.6*train$CNR_prev5)+(0.6*train$CNR_prev6))
train$EOP_prev<- (train$EOP_prev1 +( .8 *train$EOP_prev2)+ (.8*train$EOP_prev3)+(0.8*train$EOP_prev4)+(0.6*train$EOP_prev5)+(0.6*train$EOP_prev6))
train$COUNT_ATM_C_prev<- (train$COUNT_ATM_C_prev1 +( .8 *train$COUNT_ATM_C_prev2)+ (.8*train$COUNT_ATM_C_prev3)+(0.8*train$COUNT_ATM_C_prev4)+(0.6*train$COUNT_ATM_C_prev5)+(0.6*train$COUNT_ATM_C_prev6))
train$IB_D_prev<- (train$IB_D_prev1 +( .8 *train$IB_D_prev2)+ (.8*train$IB_D_prev3)+(0.8*train$IB_D_prev4)+(0.6*train$IB_D_prev5)+(0.6*train$IB_D_prev6))
train$COUNT_ATM_D_prev<- (train$COUNT_ATM_D_prev1 +( .8 *train$COUNT_ATM_D_prev2)+ (.8*train$COUNT_ATM_D_prev3)+(0.8*train$COUNT_ATM_D_prev4)+(0.6*train$COUNT_ATM_D_prev5)+(0.6*train$COUNT_ATM_D_prev6))
train$MB_D_prev<- (train$MB_D_prev1 +( .8 *train$MB_D_prev2)+ (.8*train$MB_D_prev3)+(0.8*train$MB_D_prev4)+(0.6*train$MB_D_prev5)+(0.6*train$MB_D_prev6))
train$COUNT_BRANCH_C_prev<- (train$COUNT_BRANCH_C_prev1 +( .8 *train$COUNT_BRANCH_C_prev2)+ (.8*train$COUNT_BRANCH_C_prev3)+(0.8*train$COUNT_BRANCH_C_prev4)+(0.6*train$COUNT_BRANCH_C_prev5)+(0.6*train$COUNT_BRANCH_C_prev6))
train$POS_D_prev<- (train$POS_D_prev1 +( .8 *train$POS_D_prev2)+ (.8*train$POS_D_prev3)+(0.8*train$POS_D_prev4)+(0.6*train$POS_D_prev5)+(0.6*train$POS_D_prev6))
train$COUNT_BRANCH_D_prev<- (train$COUNT_BRANCH_D_prev1 +( .8 *train$COUNT_BRANCH_D_prev2)+ (.8*train$COUNT_BRANCH_D_prev3)+(0.8*train$COUNT_BRANCH_D_prev4)+(0.6*train$COUNT_BRANCH_D_prev5)+(0.6*train$COUNT_BRANCH_D_prev6))
train$custinit_CR_amt_prev<- (train$custinit_CR_amt_prev1 +( .8 *train$custinit_CR_amt_prev2)+ (.8*train$custinit_CR_amt_prev3)+(0.8*train$custinit_CR_amt_prev4)+(0.6*train$custinit_CR_amt_prev5)+(0.6*train$custinit_CR_amt_prev6))
train$NO_OF_FD_BOOK_PrevQ<- (train$NO_OF_FD_BOOK_PrevQ1 +( .9 *train$NO_OF_FD_BOOK_PrevQ2))
train$I_CR_AQB_PrevQ<- (train$I_CR_AQB_PrevQ1 +( .9 *train$I_CR_AQB_PrevQ2))
train$RD_AMOUNT_BOOK_PrevQ<- (train$RD_AMOUNT_BOOK_PrevQ1 +( .9 *train$RD_AMOUNT_BOOK_PrevQ2))
train$count_No_of_MF_PrevQ<- (train$count_No_of_MF_PrevQ1 +( .9 *train$count_No_of_MF_PrevQ2))
train$I_NRV_PrevQ<- (train$I_NRV_PrevQ1 +( .9 *train$I_NRV_PrevQ2))
train$Dmat_Investing_PrevQ<- (train$Dmat_Investing_PrevQ1 +( .9 *train$Dmat_Investing_PrevQ2))
train$NO_OF_RD_BOOK_PrevQ<- (train$NO_OF_RD_BOOK_PrevQ1 +( .9 *train$NO_OF_RD_BOOK_PrevQ2))
train$FD_AMOUNT_BOOK_PrevQ<- (train$FD_AMOUNT_BOOK_PrevQ1 +( .9 *train$FD_AMOUNT_BOOK_PrevQ2))
train$Total_Invest_in_MF_PrevQ<- (train$Total_Invest_in_MF_PrevQ1 +( .9 *train$Total_Invest_in_MF_PrevQ2))
train$I_CNR_PrevQ<- (train$I_CNR_PrevQ1 +( .9 *train$I_CNR_PrevQ2))
train$I_AQB_PrevQ<- (train$I_AQB_PrevQ1 +( .9 *train$I_AQB_PrevQ2))


test$D_prev<- (test$D_prev1 +( .8 *test$D_prev2)+ (.8*test$D_prev3)+(0.8*test$D_prev4)+(0.6*test$D_prev5)+(0.6*test$D_prev6))
test$COUNT_MB_C_prev<- (test$COUNT_MB_C_prev1 +( .8 *test$COUNT_MB_C_prev2)+ (.8*test$COUNT_MB_C_prev3)+(0.8*test$COUNT_MB_C_prev4)+(0.6*test$COUNT_MB_C_prev5)+(0.6*test$COUNT_MB_C_prev6))
test$count_C_prev<- (test$count_C_prev1 +( .8 *test$count_C_prev2)+ (.8*test$count_C_prev3)+(0.8*test$count_C_prev4)+(0.6*test$count_C_prev5)+(0.6*test$count_C_prev6))
test$ATM_amt_prev<- (test$ATM_amt_prev1 +( .8 *test$ATM_amt_prev2)+ (.8*test$ATM_amt_prev3)+(0.8*test$ATM_amt_prev4)+(0.6*test$ATM_amt_prev5)+(0.6*test$ATM_amt_prev6))
test$CR_AMB_Prev<- (test$CR_AMB_Prev1 +( .8 *test$CR_AMB_Prev2)+ (.8*test$CR_AMB_Prev3)+(0.8*test$CR_AMB_Prev4)+(0.6*test$CR_AMB_Prev5)+(0.6*test$CR_AMB_Prev6))
test$ATM_C_prev<- (test$ATM_C_prev1 +( .8 *test$ATM_C_prev2)+ (.8*test$ATM_C_prev3)+(0.8*test$ATM_C_prev4)+(0.6*test$ATM_C_prev5)+(0.6*test$ATM_C_prev6))
test$MB_C_prev<- (test$MB_C_prev1 +( .8 *test$MB_C_prev2)+ (.8*test$MB_C_prev3)+(0.8*test$MB_C_prev4)+(0.6*test$MB_C_prev5)+(0.6*test$MB_C_prev6))
test$ATM_CW_Amt_prev<- (test$ATM_CW_Amt_prev1 +( .8 *test$ATM_CW_Amt_prev2)+ (.8*test$ATM_CW_Amt_prev3)+(0.8*test$ATM_CW_Amt_prev4)+(0.6*test$ATM_CW_Amt_prev5)+(0.6*test$ATM_CW_Amt_prev6))
test$COUNT_IB_C_prev<- (test$COUNT_IB_C_prev1 +( .8 *test$COUNT_IB_C_prev2)+ (.8*test$COUNT_IB_C_prev3)+(0.8*test$COUNT_IB_C_prev4)+(0.6*test$COUNT_IB_C_prev5)+(0.6*test$COUNT_IB_C_prev6))
test$ATM_CW_Cnt_prev<- (test$ATM_CW_Cnt_prev1 +( .8 *test$ATM_CW_Cnt_prev2)+ (.8*test$ATM_CW_Cnt_prev3)+(0.8*test$ATM_CW_Cnt_prev4)+(0.6*test$ATM_CW_Cnt_prev5)+(0.6*test$ATM_CW_Cnt_prev6))
test$COUNT_POS_C_prev<- (test$COUNT_POS_C_prev1 +( .8 *test$COUNT_POS_C_prev2)+ (.8*test$COUNT_POS_C_prev3)+(0.8*test$COUNT_POS_C_prev4)+(0.6*test$COUNT_POS_C_prev5)+(0.6*test$COUNT_POS_C_prev6))
test$ATM_D_prev<- (test$ATM_D_prev1 +( .8 *test$ATM_D_prev2)+ (.8*test$ATM_D_prev3)+(0.8*test$ATM_D_prev4)+(0.6*test$ATM_D_prev5)+(0.6*test$ATM_D_prev6))
test$custinit_DR_amt_prev<- (test$custinit_DR_amt_prev1 +( .8 *test$custinit_DR_amt_prev2)+ (.8*test$custinit_DR_amt_prev3)+(0.8*test$custinit_DR_amt_prev4)+(0.6*test$custinit_DR_amt_prev5)+(0.6*test$custinit_DR_amt_prev6))
test$BAL_prev<- (test$BAL_prev1 +( .8 *test$BAL_prev2)+ (.8*test$BAL_prev3)+(0.8*test$BAL_prev4)+(0.6*test$BAL_prev5)+(0.6*test$BAL_prev6))
test$IB_C_prev<- (test$IB_C_prev1 +( .8 *test$IB_C_prev2)+ (.8*test$IB_C_prev3)+(0.8*test$IB_C_prev4)+(0.6*test$IB_C_prev5)+(0.6*test$IB_C_prev6))
test$BRANCH_C_prev<- (test$BRANCH_C_prev1 +( .8 *test$BRANCH_C_prev2)+ (.8*test$BRANCH_C_prev3)+(0.8*test$BRANCH_C_prev4)+(0.6*test$BRANCH_C_prev5)+(0.6*test$BRANCH_C_prev6))
test$POS_C_prev<- (test$POS_C_prev1 +( .8 *test$POS_C_prev2)+ (.8*test$POS_C_prev3)+(0.8*test$POS_C_prev4)+(0.6*test$POS_C_prev5)+(0.6*test$POS_C_prev6))
test$BRANCH_D_prev<- (test$BRANCH_D_prev1 +( .8 *test$BRANCH_D_prev2)+ (.8*test$BRANCH_D_prev3)+(0.8*test$BRANCH_D_prev4)+(0.6*test$BRANCH_D_prev5)+(0.6*test$BRANCH_D_prev6))
test$count_D_prev<- (test$count_D_prev1 +( .8 *test$count_D_prev2)+ (.8*test$count_D_prev3)+(0.8*test$count_D_prev4)+(0.6*test$count_D_prev5)+(0.6*test$count_D_prev6))
test$BRN_CASH_Dep_Amt_prev<- (test$BRN_CASH_Dep_Amt_prev1 +( .8 *test$BRN_CASH_Dep_Amt_prev2)+ (.8*test$BRN_CASH_Dep_Amt_prev3)+(0.8*test$BRN_CASH_Dep_Amt_prev4)+(0.6*test$BRN_CASH_Dep_Amt_prev5)+(0.6*test$BRN_CASH_Dep_Amt_prev6))
test$COUNT_IB_D_prev<- (test$COUNT_IB_D_prev1 +( .8 *test$COUNT_IB_D_prev2)+ (.8*test$COUNT_IB_D_prev3)+(0.8*test$COUNT_IB_D_prev4)+(0.6*test$COUNT_IB_D_prev5)+(0.6*test$COUNT_IB_D_prev6))
test$BRN_CASH_Dep_Cnt_prev<- (test$BRN_CASH_Dep_Cnt_prev1 +( .8 *test$BRN_CASH_Dep_Cnt_prev2)+ (.8*test$BRN_CASH_Dep_Cnt_prev3)+(0.8*test$BRN_CASH_Dep_Cnt_prev4)+(0.6*test$BRN_CASH_Dep_Cnt_prev5)+(0.6*test$BRN_CASH_Dep_Cnt_prev6))
test$COUNT_MB_D_prev<- (test$COUNT_MB_D_prev1 +( .8 *test$COUNT_MB_D_prev2)+ (.8*test$COUNT_MB_D_prev3)+(0.8*test$COUNT_MB_D_prev4)+(0.6*test$COUNT_MB_D_prev5)+(0.6*test$COUNT_MB_D_prev6))
test$BRN_CW_Amt_prev<- (test$BRN_CW_Amt_prev1 +( .8 *test$BRN_CW_Amt_prev2)+ (.8*test$BRN_CW_Amt_prev3)+(0.8*test$BRN_CW_Amt_prev4)+(0.6*test$BRN_CW_Amt_prev5)+(0.6*test$BRN_CW_Amt_prev6))
test$COUNT_POS_D_prev<- (test$COUNT_POS_D_prev1 +( .8 *test$COUNT_POS_D_prev2)+ (.8*test$COUNT_POS_D_prev3)+(0.8*test$COUNT_POS_D_prev4)+(0.6*test$COUNT_POS_D_prev5)+(0.6*test$COUNT_POS_D_prev6))
test$BRN_CW_Cnt_prev<- (test$BRN_CW_Cnt_prev1 +( .8 *test$BRN_CW_Cnt_prev2)+ (.8*test$BRN_CW_Cnt_prev3)+(0.8*test$BRN_CW_Cnt_prev4)+(0.6*test$BRN_CW_Cnt_prev5)+(0.6*test$BRN_CW_Cnt_prev6))
test$custinit_CR_cnt_prev<- (test$custinit_CR_cnt_prev1 +( .8 *test$custinit_CR_cnt_prev2)+ (.8*test$custinit_CR_cnt_prev3)+(0.8*test$custinit_CR_cnt_prev4)+(0.6*test$custinit_CR_cnt_prev5)+(0.6*test$custinit_CR_cnt_prev6))
test$C_prev<- (test$C_prev1 +( .8 *test$C_prev2)+ (.8*test$C_prev3)+(0.8*test$C_prev4)+(0.6*test$C_prev5)+(0.6*test$C_prev6))
test$custinit_DR_cnt_prev<- (test$custinit_DR_cnt_prev1 +( .8 *test$custinit_DR_cnt_prev2)+ (.8*test$custinit_DR_cnt_prev3)+(0.8*test$custinit_DR_cnt_prev4)+(0.6*test$custinit_DR_cnt_prev5)+(0.6*test$custinit_DR_cnt_prev6))
test$CNR_prev<- (test$CNR_prev1 +( .8 *test$CNR_prev2)+ (.8*test$CNR_prev3)+(0.8*test$CNR_prev4)+(0.6*test$CNR_prev5)+(0.6*test$CNR_prev6))
test$EOP_prev<- (test$EOP_prev1 +( .8 *test$EOP_prev2)+ (.8*test$EOP_prev3)+(0.8*test$EOP_prev4)+(0.6*test$EOP_prev5)+(0.6*test$EOP_prev6))
test$COUNT_ATM_C_prev<- (test$COUNT_ATM_C_prev1 +( .8 *test$COUNT_ATM_C_prev2)+ (.8*test$COUNT_ATM_C_prev3)+(0.8*test$COUNT_ATM_C_prev4)+(0.6*test$COUNT_ATM_C_prev5)+(0.6*test$COUNT_ATM_C_prev6))
test$IB_D_prev<- (test$IB_D_prev1 +( .8 *test$IB_D_prev2)+ (.8*test$IB_D_prev3)+(0.8*test$IB_D_prev4)+(0.6*test$IB_D_prev5)+(0.6*test$IB_D_prev6))
test$COUNT_ATM_D_prev<- (test$COUNT_ATM_D_prev1 +( .8 *test$COUNT_ATM_D_prev2)+ (.8*test$COUNT_ATM_D_prev3)+(0.8*test$COUNT_ATM_D_prev4)+(0.6*test$COUNT_ATM_D_prev5)+(0.6*test$COUNT_ATM_D_prev6))
test$MB_D_prev<- (test$MB_D_prev1 +( .8 *test$MB_D_prev2)+ (.8*test$MB_D_prev3)+(0.8*test$MB_D_prev4)+(0.6*test$MB_D_prev5)+(0.6*test$MB_D_prev6))
test$COUNT_BRANCH_C_prev<- (test$COUNT_BRANCH_C_prev1 +( .8 *test$COUNT_BRANCH_C_prev2)+ (.8*test$COUNT_BRANCH_C_prev3)+(0.8*test$COUNT_BRANCH_C_prev4)+(0.6*test$COUNT_BRANCH_C_prev5)+(0.6*test$COUNT_BRANCH_C_prev6))
test$POS_D_prev<- (test$POS_D_prev1 +( .8 *test$POS_D_prev2)+ (.8*test$POS_D_prev3)+(0.8*test$POS_D_prev4)+(0.6*test$POS_D_prev5)+(0.6*test$POS_D_prev6))
test$COUNT_BRANCH_D_prev<- (test$COUNT_BRANCH_D_prev1 +( .8 *test$COUNT_BRANCH_D_prev2)+ (.8*test$COUNT_BRANCH_D_prev3)+(0.8*test$COUNT_BRANCH_D_prev4)+(0.6*test$COUNT_BRANCH_D_prev5)+(0.6*test$COUNT_BRANCH_D_prev6))
test$custinit_CR_amt_prev<- (test$custinit_CR_amt_prev1 +( .8 *test$custinit_CR_amt_prev2)+ (.8*test$custinit_CR_amt_prev3)+(0.8*test$custinit_CR_amt_prev4)+(0.6*test$custinit_CR_amt_prev5)+(0.6*test$custinit_CR_amt_prev6))
test$NO_OF_FD_BOOK_PrevQ<- (test$NO_OF_FD_BOOK_PrevQ1 +( .9 *test$NO_OF_FD_BOOK_PrevQ2))
test$I_CR_AQB_PrevQ<- (test$I_CR_AQB_PrevQ1 +( .9 *test$I_CR_AQB_PrevQ2))
test$RD_AMOUNT_BOOK_PrevQ<- (test$RD_AMOUNT_BOOK_PrevQ1 +( .9 *test$RD_AMOUNT_BOOK_PrevQ2))
test$count_No_of_MF_PrevQ<- (test$count_No_of_MF_PrevQ1 +( .9 *test$count_No_of_MF_PrevQ2))
test$I_NRV_PrevQ<- (test$I_NRV_PrevQ1 +( .9 *test$I_NRV_PrevQ2))
test$Dmat_Investing_PrevQ<- (test$Dmat_Investing_PrevQ1 +( .9 *test$Dmat_Investing_PrevQ2))
test$NO_OF_RD_BOOK_PrevQ<- (test$NO_OF_RD_BOOK_PrevQ1 +( .9 *test$NO_OF_RD_BOOK_PrevQ2))
test$FD_AMOUNT_BOOK_PrevQ<- (test$FD_AMOUNT_BOOK_PrevQ1 +( .9 *test$FD_AMOUNT_BOOK_PrevQ2))
test$Total_Invest_in_MF_PrevQ<- (test$Total_Invest_in_MF_PrevQ1 +( .9 *test$Total_Invest_in_MF_PrevQ2))
test$I_CNR_PrevQ<- (test$I_CNR_PrevQ1 +( .9 *test$I_CNR_PrevQ2))
test$I_AQB_PrevQ<- (test$I_AQB_PrevQ1 +( .9 *test$I_AQB_PrevQ2))



test <- subset(test, select=-c(ENGAGEMENT_TAG_prev1,zip,Percent_Change_in_Credits,Recency_of_CR_TXN,Recency_of_DR_TXN,Recency_of_BRANCH_TXN,city,custinit_DR_amt_prev4,custinit_DR_amt_prev3,custinit_DR_amt_prev6,custinit_DR_amt_prev5,Recency_of_Activity,Recency_of_IB_TXN,Recency_of_ATM_TXN,Percent_Change_in_FT_outside,custinit_CR_amt_prev2,BRN_CASH_Dep_Amt_prev6,custinit_CR_amt_prev3,custinit_CR_amt_prev1,custinit_CR_amt_prev4,custinit_CR_amt_prev5,Recency_of_POS_TXN,custinit_CR_amt_prev6,Recency_of_MB_TXN,custinit_DR_cnt_prev6,ATM_CW_Cnt_prev1,BRN_CASH_Dep_Amt_prev1,custinit_DR_cnt_prev3,OCCUP_ALL_NEW,custinit_DR_cnt_prev5,custinit_DR_cnt_prev4,ATM_CW_Amt_prev1,BRN_CASH_Dep_Amt_prev3,custinit_DR_cnt_prev1,NO_OF_FD_BOOK_PrevQ2,Percent_Change_in_Big_Expenses,BRN_CASH_Dep_Amt_prev2,custinit_DR_cnt_prev2,BRN_CASH_Dep_Amt_prev5,ATM_CW_Amt_prev3,BRN_CASH_Dep_Amt_prev4,ATM_amt_prev1,ATM_CW_Amt_prev2,ATM_amt_prev6,NO_OF_FD_BOOK_PrevQ1,ATM_amt_prev5,ATM_CW_Amt_prev6,Billpay_Reg_ason_Prev1,ATM_CW_Amt_prev4,dependents,ATM_amt_prev2,FD_PREM_CLOSED_PREVQ1,ATM_CW_Amt_prev5,CC_TAG_LIVE,ATM_CW_Cnt_prev6,GL_DATE,ATM_amt_prev4,PL_DATE,custinit_CR_cnt_prev2,custinit_CR_cnt_prev5,custinit_CR_cnt_prev4,AL_DATE,count_No_of_MF_PrevQ1,FD_CLOSED_PREVQ1,BRN_CASH_Dep_Cnt_prev1,Percent_Change_in_FT_Bank,AL_CNC_DATE,custinit_CR_cnt_prev6,BRN_CASH_Dep_Cnt_prev5,BRN_CASH_Dep_Cnt_prev3,ATM_CW_Cnt_prev5,PL_TAG_LIVE,BRN_CASH_Dep_Cnt_prev2,custinit_CR_cnt_prev1,Charges_cnt_PrevQ1,ATM_CW_Cnt_prev4,ATM_CW_Cnt_prev2,SEC_ACC_TAG_LIVE,Percent_Change_in_Self_Txn,NO_OF_RD_BOOK_PrevQ2,ATM_amt_prev3,DEMAT_TAG_LIVE,ATM_CW_Cnt_prev3,count_No_of_MF_PrevQ2,GL_TAG_LIVE,FD_TAG_LIVE,AL_CNC_TAG_LIVE,NO_OF_RD_BOOK_PrevQ1,BRN_CASH_Dep_Cnt_prev6,custinit_CR_cnt_prev3,NO_OF_CHEQUE_BOUNCE_V1,Billpay_Active_PrevQ1,BL_TAG_LIVE,MF_TAG_LIVE,BRN_CASH_Dep_Cnt_prev4,CV_Closed_PrevQ1,Query_Resolved_PrevQ1,OTHER_LOANS_TAG_LIVE,INS_TAG_LIVE,Req_Resolved_PrevQ1,TWL_DATE,OTHER_LOANS_DATE,RD_CLOSED_PREVQ1,CV_DATE,BL_DATE,AL_Closed_PrevQ1,Req_Logged_PrevQ1,RD_TAG_LIVE,EMAIL_UNSUBSCRIBE,SEC_ACC_CLOSED_PREV1YR,AL_TAG_LIVE,HL_TAG_LIVE,BRN_CW_Amt_prev1,BRN_CW_Cnt_prev1,BRN_CW_Amt_prev2,BRN_CW_Cnt_prev2,BRN_CW_Amt_prev3,BRN_CW_Cnt_prev3,BRN_CW_Amt_prev4,BRN_CW_Cnt_prev4,BRN_CW_Amt_prev5,BRN_CW_Cnt_prev5,BRN_CW_Amt_prev6,BRN_CW_Cnt_prev6,FRX_PrevQ1,AGRI_PREM_CLOSED_PREVQ1,AL_CNC_PREM_CLOSED_PREVQ1,AL_PREM_CLOSED_PREVQ1,BL_PREM_CLOSED_PREVQ1,CC_PREM_CLOSED_PREVQ1,CE_PREM_CLOSED_PREVQ1,CV_PREM_CLOSED_PREVQ1,EDU_PREM_CLOSED_PREVQ1,OTHER_LOANS_PREM_CLOSED_PREVQ1,PL_PREM_CLOSED_PREVQ1,RD_PREM_CLOSED_PREVQ1,TL_PREM_CLOSED_PREVQ1,TWL_PREM_CLOSED_PREVQ1,AGRI_Closed_PrevQ1,AL_CNC_Closed_PrevQ1,BL_Closed_PrevQ1,CC_CLOSED_PREVQ1,CE_Closed_PrevQ1,EDU_Closed_PrevQ1,GL_Closed_PrevQ1,OTHER_LOANS_Closed_PrevQ1,PL_Closed_PrevQ1,TL_Closed_PrevQ1,TWL_Closed_PrevQ1,DEMAT_CLOSED_PREV1YR,AGRI_TAG_LIVE,CE_TAG_LIVE,CV_TAG_LIVE,EDU_TAG_LIVE,LAS_TAG_LIVE,TL_TAG_LIVE,TWL_TAG_LIVE,lap_tag_live,AGRI_DATE,CE_DATE,EDU_DATE,LAP_DATE,LAS_DATE,TL_DATE,NO_OF_COMPLAINTS,Query_Logged_PrevQ1,Complaint_Logged_PrevQ1,Complaint_Resolved_PrevQ1))

train <- subset(train, select=-c(ENGAGEMENT_TAG_prev1,zip,Percent_Change_in_Credits,Recency_of_CR_TXN,Recency_of_DR_TXN,Recency_of_BRANCH_TXN,city,custinit_DR_amt_prev4,custinit_DR_amt_prev3,custinit_DR_amt_prev6,custinit_DR_amt_prev5,Recency_of_Activity,Recency_of_IB_TXN,Recency_of_ATM_TXN,Percent_Change_in_FT_outside,custinit_CR_amt_prev2,BRN_CASH_Dep_Amt_prev6,custinit_CR_amt_prev3,custinit_CR_amt_prev1,custinit_CR_amt_prev4,custinit_CR_amt_prev5,Recency_of_POS_TXN,custinit_CR_amt_prev6,Recency_of_MB_TXN,custinit_DR_cnt_prev6,ATM_CW_Cnt_prev1,BRN_CASH_Dep_Amt_prev1,custinit_DR_cnt_prev3,OCCUP_ALL_NEW,custinit_DR_cnt_prev5,custinit_DR_cnt_prev4,ATM_CW_Amt_prev1,BRN_CASH_Dep_Amt_prev3,custinit_DR_cnt_prev1,NO_OF_FD_BOOK_PrevQ2,Percent_Change_in_Big_Expenses,BRN_CASH_Dep_Amt_prev2,custinit_DR_cnt_prev2,BRN_CASH_Dep_Amt_prev5,ATM_CW_Amt_prev3,BRN_CASH_Dep_Amt_prev4,ATM_amt_prev1,ATM_CW_Amt_prev2,ATM_amt_prev6,NO_OF_FD_BOOK_PrevQ1,ATM_amt_prev5,ATM_CW_Amt_prev6,Billpay_Reg_ason_Prev1,ATM_CW_Amt_prev4,dependents,ATM_amt_prev2,FD_PREM_CLOSED_PREVQ1,ATM_CW_Amt_prev5,CC_TAG_LIVE,ATM_CW_Cnt_prev6,GL_DATE,ATM_amt_prev4,PL_DATE,custinit_CR_cnt_prev2,custinit_CR_cnt_prev5,custinit_CR_cnt_prev4,AL_DATE,count_No_of_MF_PrevQ1,FD_CLOSED_PREVQ1,BRN_CASH_Dep_Cnt_prev1,Percent_Change_in_FT_Bank,AL_CNC_DATE,custinit_CR_cnt_prev6,BRN_CASH_Dep_Cnt_prev5,BRN_CASH_Dep_Cnt_prev3,ATM_CW_Cnt_prev5,PL_TAG_LIVE,BRN_CASH_Dep_Cnt_prev2,custinit_CR_cnt_prev1,Charges_cnt_PrevQ1,ATM_CW_Cnt_prev4,ATM_CW_Cnt_prev2,SEC_ACC_TAG_LIVE,Percent_Change_in_Self_Txn,NO_OF_RD_BOOK_PrevQ2,ATM_amt_prev3,DEMAT_TAG_LIVE,ATM_CW_Cnt_prev3,count_No_of_MF_PrevQ2,GL_TAG_LIVE,FD_TAG_LIVE,AL_CNC_TAG_LIVE,NO_OF_RD_BOOK_PrevQ1,BRN_CASH_Dep_Cnt_prev6,custinit_CR_cnt_prev3,NO_OF_CHEQUE_BOUNCE_V1,Billpay_Active_PrevQ1,BL_TAG_LIVE,MF_TAG_LIVE,BRN_CASH_Dep_Cnt_prev4,CV_Closed_PrevQ1,Query_Resolved_PrevQ1,OTHER_LOANS_TAG_LIVE,INS_TAG_LIVE,Req_Resolved_PrevQ1,TWL_DATE,OTHER_LOANS_DATE,RD_CLOSED_PREVQ1,CV_DATE,BL_DATE,AL_Closed_PrevQ1,Req_Logged_PrevQ1,RD_TAG_LIVE,EMAIL_UNSUBSCRIBE,SEC_ACC_CLOSED_PREV1YR,AL_TAG_LIVE,HL_TAG_LIVE,BRN_CW_Amt_prev1,BRN_CW_Cnt_prev1,BRN_CW_Amt_prev2,BRN_CW_Cnt_prev2,BRN_CW_Amt_prev3,BRN_CW_Cnt_prev3,BRN_CW_Amt_prev4,BRN_CW_Cnt_prev4,BRN_CW_Amt_prev5,BRN_CW_Cnt_prev5,BRN_CW_Amt_prev6,BRN_CW_Cnt_prev6,FRX_PrevQ1,AGRI_PREM_CLOSED_PREVQ1,AL_CNC_PREM_CLOSED_PREVQ1,AL_PREM_CLOSED_PREVQ1,BL_PREM_CLOSED_PREVQ1,CC_PREM_CLOSED_PREVQ1,CE_PREM_CLOSED_PREVQ1,CV_PREM_CLOSED_PREVQ1,EDU_PREM_CLOSED_PREVQ1,OTHER_LOANS_PREM_CLOSED_PREVQ1,PL_PREM_CLOSED_PREVQ1,RD_PREM_CLOSED_PREVQ1,TL_PREM_CLOSED_PREVQ1,TWL_PREM_CLOSED_PREVQ1,AGRI_Closed_PrevQ1,AL_CNC_Closed_PrevQ1,BL_Closed_PrevQ1,CC_CLOSED_PREVQ1,CE_Closed_PrevQ1,EDU_Closed_PrevQ1,GL_Closed_PrevQ1,OTHER_LOANS_Closed_PrevQ1,PL_Closed_PrevQ1,TL_Closed_PrevQ1,TWL_Closed_PrevQ1,DEMAT_CLOSED_PREV1YR,AGRI_TAG_LIVE,CE_TAG_LIVE,CV_TAG_LIVE,EDU_TAG_LIVE,LAS_TAG_LIVE,TL_TAG_LIVE,TWL_TAG_LIVE,lap_tag_live,AGRI_DATE,CE_DATE,EDU_DATE,LAP_DATE,LAS_DATE,TL_DATE,NO_OF_COMPLAINTS,Query_Logged_PrevQ1,Complaint_Logged_PrevQ1,Complaint_Resolved_PrevQ1))



feature.names <- names(train)[c(2:208,210:259)]
cat("Feature Names\n")
feature.names

cat("assuming text variables are categorical & replacing them with numeric ids\n")
for (f in feature.names) {
  if (class(train[[f]])=="character") {
    levels <- unique(c(train[[f]], test[[f]]))
    train[[f]] <- as.integer(factor(train[[f]], levels=levels))
    test[[f]]  <- as.integer(factor(test[[f]],  levels=levels))
  }
}

#head(test)

train[is.na(train)] = 0
test[is.na(test)] = 0

train = data.frame(train) 
test = data.frame(test)

X_features <- colnames(train[c(2:208,210:259)])
X_features

X_target <- train$Responders

summary(train$Responders)

xgtrain <- xgb.DMatrix(data = data.matrix(train[, X_features]), label = X_target)
xgtest <- xgb.DMatrix(data = data.matrix(test[, X_features]))

test1 =test1[c(1)]
rm(test)
rm(train)

params <- list(
  "objective"           = "binary:logistic",
  "eval_metric"         = "rmse",
  "eta"                 = 0.08,
  "max_depth"           = 8,
  "subsample"           = 0.8,
  "colsample_bytree"    = 0.8
)


watchlist<-list(train=xgtrain)
#model_xgb_cv <- xgb.cv(params=params, xgtrain, nrounds = 100, nfold = 10, prediction = TRUE)

model_xgb <- xgb.train(params = params, xgtrain, nrounds = 260 ,early_stopping_rounds = 10, prediction = TRUE,watchlist = watchlist )

#head(test)

#summary(test$Responders)
test1$Responders_logis <- predict(model_xgb,xgtest )
#submission = test[c(1,164)]
write.csv(test1, file = "submitmsh10_logistic.csv", row.names = F)


#Reg - Linear

param <- list("objective"   = "reg:linear",    # multiclass classification 
              "eval_metric" = "rmse",
              "nthread"     = 4,   # number of threads to be used 
              "max_depth"   = 12,    # maximum depth of tree 
              "eta"         = 0.1,    # step size shrinkage 
              "subsample"   = 0.75,    # part of data instances to grow tree 
              "colsample_bytree" = 0.75,  # subsample ratio of columns when constructing each tree 
              "silent"      = 1)

xgb <- xgboost(data = xgtrain, param = param, nrounds = 300, verbose = TRUE, prediction = TRUE,  maximize = TRUE)
test1$Responders_lin <- predict(xgb,xgtest )
test1$r <- (test1$Responders_lin * 0.05)+(test1$Responders_logis*.95)
summary(test1)
vc <- test1[c(1,4)]
colnames(vc) <- c("UCIC_ID", "Responders")
write.csv(vc, file = "submitmsh14_ens95_5.csv", row.names = F)

