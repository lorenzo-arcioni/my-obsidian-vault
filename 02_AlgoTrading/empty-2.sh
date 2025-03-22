#!/bin/bash
# Script per generare l’albero completo di "Algorithmic Trading"
# con le directory interne numerate e le foglie create come file .md.

# Funzione per creare un file .md con un header (basato sul nome del file)
create_file() {
    local file="$1"
    echo "# $(basename "$file" .md)" > "$file"
}

# Funzione per creare una directory se non esiste già
create_dir() {
    mkdir -p "$1"
}

###############################################################################
# Radice
###############################################################################
ROOT="Algorithmic Trading"
create_dir "$ROOT"

###############################################################################
# Part 0: Introduzione e Fondamenti
###############################################################################
PART0="$ROOT/00_Part 0 - Introduzione e Fondamenti"
create_dir "$PART0"

# Foglie (file .md)
create_file "$PART0/Introduzione all'Algorithmic Trading.md"
create_file "$PART0/Fondamenti dei Mercati Finanziari.md"

# Nodo interno: Dati e Tecnologie
DT="$PART0/02_Dati e Tecnologie"
create_dir "$DT"
create_file "$DT/Collegamento con “Matematica Finanziaria”.md"

# Nodo interno: Psicologia del Trading
PSYCH="$PART0/03_Psicologia del Trading"
create_dir "$PSYCH"
create_file "$PSYCH/Gestione delle Emozioni.md"
create_file "$PSYCH/Discipline di Trading e Pianificazione.md"
create_file "$PSYCH/Errori Comuni e Come Evitarli.md"

###############################################################################
# Part 1: Data Analysis e Feature Engineering
###############################################################################
PART1="$ROOT/01_Part 1 - Data Analysis e Feature Engineering"
create_dir "$PART1"

# 2. Data Analysis & Financial Data Structures
DS="$PART1/02_Data Analysis & Financial Data Structures"
create_dir "$DS"
create_file "$DS/Motivazione.md"

# Essential Types of Financial Data (nodo interno)
ETFD="$DS/01_Essential Types of Financial Data"
create_dir "$ETFD"
create_file "$ETFD/Fundamental Data.md"
create_file "$ETFD/Market Data.md"
create_file "$ETFD/Analytics.md"
create_file "$ETFD/Alternative Data.md"

# Bars (nodo interno)
BARS="$DS/02_Bars"
create_dir "$BARS"
create_file "$BARS/Standard Bars.md"
create_file "$BARS/Information-Driven Bars.md"

# Dealing with Multi-Product Series (nodo interno)
MPS="$DS/03_Dealing with Multi-Product Series"
create_dir "$MPS"
create_file "$MPS/The ETF Trick.md"
create_file "$MPS/PCA Weights.md"
create_file "$MPS/Single Future Roll.md"

# Sampling Features (nodo interno)
SAMPLING="$DS/04_Sampling Features"
create_dir "$SAMPLING"
create_file "$SAMPLING/Sampling for Reduction.md"
create_file "$SAMPLING/Event-Based Sampling.md"

# 3. Labeling
LABELING="$PART1/03_Labeling"
create_dir "$LABELING"
create_file "$LABELING/Motivazione.md"
create_file "$LABELING/Fixed-Time Horizon Method.md"
create_file "$LABELING/Computing Dynamic Thresholds.md"
create_file "$LABELING/The Triple-Barrier Method.md"
create_file "$LABELING/Learning Side and Size.md"
create_file "$LABELING/Meta-Labeling.md"
create_file "$LABELING/How to Use Meta-Labeling.md"
create_file "$LABELING/The Quantamental Way.md"
create_file "$LABELING/Dropping Unnecessary Labels.md"

# 4. Sample Weights
SW="$PART1/04_Sample Weights"
create_dir "$SW"
create_file "$SW/Motivazione.md"
create_file "$SW/Overlapping Outcomes.md"
create_file "$SW/Number of Concurrent Labels.md"
create_file "$SW/Average Uniqueness of a Label.md"

# Bagging Classifiers and Uniqueness (nodo interno)
BAGGING="$SW/05_Bagging Classifiers and Uniqueness"
create_dir "$BAGGING"
create_file "$BAGGING/Sequential Bootstrap.md"
create_file "$BAGGING/Implementation of Sequential Bootstrap.md"

create_file "$SW/A Numerical Example & Monte Carlo Experiments.md"
create_file "$SW/Return Attribution.md"
create_file "$SW/Time Decay.md"
create_file "$SW/Class Weights.md"

# 5. Fractionally Differentiated Features
FDF="$PART1/05_Fractionally Differentiated Features"
create_dir "$FDF"
create_file "$FDF/Motivazione e il Dilemma Stationarity vs. Memory.md"

# Literature Review e Il Metodo (nodo interno)
LIT="$FDF/01_Literature Review e Il Metodo"
create_dir "$LIT"
create_file "$LIT/Long Memory.md"
create_file "$LIT/Iterative Estimation.md"
create_file "$LIT/Convergence.md"

# Implementation (nodo interno)
IMP="$FDF/02_Implementation"
create_dir "$IMP"
create_file "$IMP/Expanding Window.md"
create_file "$IMP/Fixed-Width Window Fracdiff.md"

create_file "$FDF/Stationarity with Maximum Memory Preservation.md"

###############################################################################
# Part 2: Modelling e Machine Learning
###############################################################################
PART2="$ROOT/02_Part 2 - Modelling e Machine Learning"
create_dir "$PART2"

# 6. Ensemble Methods in Finance
ENS="$PART2/06_Ensemble Methods in Finance"
create_dir "$ENS"
create_file "$ENS/Motivazione.md"
create_file "$ENS/The Three Sources of Errors.md"

# Bootstrap Aggregation (Bagging) (nodo interno)
BAG="$ENS/01_Bootstrap Aggregation (Bagging)"
create_dir "$BAG"
create_file "$BAG/Variance Reduction.md"
create_file "$BAG/Improved Accuracy.md"
create_file "$BAG/Observation Redundancy.md"

create_file "$ENS/Random Forest.md"
create_file "$ENS/Boosting.md"
create_file "$ENS/Bagging vs. Boosting in Finance & Scalability.md"

# 7. Cross-Validation in Finance
CV="$PART2/07_Cross-Validation in Finance"
create_dir "$CV"
create_file "$CV/Motivazione e Obiettivo della Cross-Validation.md"
create_file "$CV/Perché il K-Fold CV Fallisce in Finance.md"

# Purged K-Fold CV (nodo interno)
PKF="$CV/01_Purged K-Fold CV"
create_dir "$PKF"
create_file "$PKF/Purging the Training Set.md"
create_file "$PKF/Embargo.md"
create_file "$PKF/The Purged K-Fold Class.md"

create_file "$CV/Bugs in Sklearn’s Cross-Validation.md"

# 8. Feature Importance
FI="$PART2/08_Feature Importance"
create_dir "$FI"
create_file "$FI/Motivazione e Importanza della Feature Importance.md"

# With Substitution Effects (nodo interno)
WSE="$FI/01_With Substitution Effects"
create_dir "$WSE"
create_file "$WSE/Mean Decrease Impurity.md"
create_file "$WSE/Mean Decrease Accuracy.md"

# Without Substitution Effects (nodo interno)
WOS="$FI/02_Without Substitution Effects"
create_dir "$WOS"
create_file "$WOS/Single Feature Importance.md"
create_file "$WOS/Orthogonal Features.md"

create_file "$FI/03_Parallelized vs. Stacked Feature Importance.md"
create_file "$FI/04_Experiments with Synthetic Data.md"

# 9. Hyper-Parameter Tuning with Cross-Validation
HT="$PART2/09_Hyper-Parameter Tuning with Cross-Validation"
create_dir "$HT"
create_file "$HT/Motivazione.md"
create_file "$HT/Grid Search Cross-Validation.md"

# Randomized Search Cross-Validation (nodo interno)
RSC="$HT/01_Randomized Search Cross-Validation"
create_dir "$RSC"
create_file "$RSC/Log-Uniform Distribution.md"

create_file "$HT/Scoring e Hyper-parameter Tuning.md"

# 10. Modelli di Pricing e Valutazione
PRICING="$PART2/10_Modelli di Pricing e Valutazione"
create_dir "$PRICING"
create_file "$PRICING/Motivazione.md"

# Modelli di Pricing delle Opzioni (nodo interno)
OPTS="$PRICING/01_Modelli di Pricing delle Opzioni"
create_dir "$OPTS"
create_file "$OPTS/Black-Scholes.md"
create_file "$OPTS/Modello di Cox-Ross-Rubinstein (CRR).md"
create_file "$OPTS/Modelli a Volatilità Stocastica.md"

# Pricing di Strumenti Derivati Complessi (nodo interno)
DERIV="$PRICING/02_Pricing di Strumenti Derivati Complessi"
create_dir "$DERIV"
create_file "$DERIV/Opzioni Esotiche.md"
create_file "$DERIV/Swap e Futures.md"
create_file "$DERIV/Strumenti Strutturati.md"

# Modelli di Volatilità (nodo interno)
VOL="$PRICING/03_Modelli di Volatilità"
create_dir "$VOL"
create_file "$VOL/GARCH.md"
create_file "$VOL/EWMA.md"

# 11. Strategie di Trading
STRAT="$PART2/11_Strategie di Trading"
create_dir "$STRAT"
create_file "$STRAT/Motivazione.md"
create_file "$STRAT/Mean Reversion.md"
create_file "$STRAT/Momentum.md"
create_file "$STRAT/Arbitraggio Statistico e Pairs Trading.md"
create_file "$STRAT/Strategie Basate su Machine Learning.md"

###############################################################################
# Part 3: Backtesting e Performance
###############################################################################
PART3="$ROOT/03_Part 3 - Backtesting e Performance"
create_dir "$PART3"

# 10. Bet Sizing
BS="$PART3/10_Bet Sizing"
create_dir "$BS"
create_file "$BS/Motivazione.md"
create_file "$BS/Strategy-Independent Bet Sizing Approaches.md"
create_file "$BS/Bet Sizing from Predicted Probabilities.md"
create_file "$BS/Averaging Active Bets.md"
create_file "$BS/Size Discretization.md"
create_file "$BS/Dynamic Bet Sizes and Limit Prices.md"

# 11. The Dangers of Backtesting
TD="$PART3/11_The Dangers of Backtesting"
create_dir "$TD"
create_file "$TD/Motivazione.md"
create_file "$TD/Mission Impossible: The Flawless Backtest.md"
create_file "$TD/Anche un Backtest “flawless” può essere Sbagliato.md"
create_file "$TD/Backtesting Is Not a Research Tool.md"
create_file "$TD/Raccomandazioni Generali e Strategy Selection.md"

# 12. Backtesting through Cross-Validation
BTCV="$PART3/12_Backtesting through Cross-Validation"
create_dir "$BTCV"
create_file "$BTCV/Motivazione.md"
create_file "$BTCV/The Walk-Forward Method & Pitfalls.md"
create_file "$BTCV/The Cross-Validation Method.md"

# Combinatorial Purged Cross-Validation (nodo interno)
CPKV="$BTCV/01_Combinatorial Purged Cross-Validation"
create_dir "$CPKV"
create_file "$CPKV/Combinatorial Splits.md"
create_file "$CPKV/Backtesting Algorithm.md"

create_file "$BTCV/Addressing Backtest Overfitting.md"

# 13. Backtesting on Synthetic Data
BTS="$PART3/13_Backtesting on Synthetic Data"
create_dir "$BTS"
create_file "$BTS/Motivazione.md"
create_file "$BTS/Trading Rules & Framework.md"
create_file "$BTS/Numerical Determination of Optimal Trading Rules.md"
create_file "$BTS/Implementation Aspects.md"
create_file "$BTS/Experimental Results & Conclusions.md"

# 14. Backtest Statistics
BSTAT="$PART3/14_Backtest Statistics"
create_dir "$BSTAT"
create_file "$BSTAT/Motivazione.md"
create_file "$BSTAT/Tipologie di Statistiche: Performance, Runs, Efficiency, Classification, Attribution.md"
create_file "$BSTAT/Dettagli su: Time-Weighted Return, Drawdown, Sharpe Ratio, etc..md"
create_file "$BSTAT/Considerazioni Implementative.md"

# 15. Understanding Strategy Risk
USR="$PART3/15_Understanding Strategy Risk"
create_dir "$USR"
create_file "$USR/Motivazione.md"
create_file "$USR/Symmetric vs. Asymmetric Payouts.md"

# The Probability of Strategy Failure (nodo interno)
TPSF="$USR/01_The Probability of Strategy Failure"
create_dir "$TPSF"
create_file "$TPSF/Algoritmo e Implementation.md"

create_file "$USR/Considerazioni Generali sul Rischio.md"

# 16. Risk Management
RISK="$PART3/16_Risk Management"
create_dir "$RISK"
create_file "$RISK/Motivazione.md"
create_file "$RISK/Value at Risk (VaR).md"
create_file "$RISK/Stress Testing e Scenario Analysis.md"
create_file "$RISK/Gestione del Drawdown e Stop-Loss Dinamici.md"
create_file "$RISK/Ottimizzazione del Rischio-Rendimento.md"

###############################################################################
# Part 4: Asset Allocation e Useful Financial Features
###############################################################################
PART4="$ROOT/04_Part 4 - Asset Allocation e Useful Financial Features"
create_dir "$PART4"

# 16. Machine Learning Asset Allocation
MLAA="$PART4/16_Machine Learning Asset Allocation"
create_dir "$MLAA"
create_file "$MLAA/Motivazione e Problemi dell’Asset Allocation Convessa.md"
create_file "$MLAA/Markowitz’s Curse.md"

# Da Geometric a Hierarchical Relationships (nodo interno)
DGH="$MLAA/01_Da Geometric a Hierarchical Relationships"
create_dir "$DGH"
create_file "$DGH/Tree Clustering.md"
create_file "$DGH/Quasi-Diagonalization.md"
create_file "$DGH/Recursive Bisection.md"

create_file "$MLAA/Esempi Numerici.md"
create_file "$MLAA/Out-of-Sample Monte Carlo Simulations.md"
create_file "$MLAA/Conclusioni e Ricerca Ulteriore.md"

# 17. Useful Financial Features
UFF="$PART4/17_Useful Financial Features"
create_dir "$UFF"

## Structural Breaks (nodo interno)
SB="$UFF/00_Structural Breaks"
create_dir "$SB"
create_file "$SB/Motivazione.md"
create_file "$SB/Tipologie di Structural Break Tests.md"

# CUSUM Tests (nodo interno)
CUSUM="$SB/01_CUSUM Tests"
create_dir "$CUSUM"
create_file "$CUSUM/Brown-Durbin-Evans CUSUM Test.md"
create_file "$CUSUM/Chu-Stinchcombe-White CUSUM Test.md"

# Explosiveness Tests (nodo interno)
EXP="$SB/02_Explosiveness Tests"
create_dir "$EXP"
create_file "$EXP/Chow-Type Dickey-Fuller Test.md"
create_file "$EXP/Supremum Augmented Dickey-Fuller.md"
create_file "$EXP/Sub-/Super-Martingale Tests.md"

## Entropy Features (nodo interno)
EF="$UFF/01_Entropy Features"
create_dir "$EF"
create_file "$EF/Motivazione.md"
create_file "$EF/Shannon’s Entropy.md"
create_file "$EF/Estimators: Plug-in & Lempel-Ziv.md"

# Encoding Schemes (nodo interno)
ENC="$EF/01_Encoding Schemes"
create_dir "$ENC"
create_file "$ENC/Binary.md"
create_file "$ENC/Quantile.md"
create_file "$ENC/Sigma.md"

create_file "$EF/Entropy of a Gaussian Process & Generalized Mean.md"
create_file "$EF/Applicazioni Finanziarie (Market Efficiency, Portfolio Concentration, Market Microstructure).md"

## Microstructural Features (nodo interno)
MS="$UFF/02_Microstructural Features"
create_dir "$MS"
create_file "$MS/Motivazione.md"

# First Generation: Price Sequences (nodo interno)
FGPS="$MS/01_First Generation - Price Sequences"
create_dir "$FGPS"
create_file "$FGPS/Tick Rule.md"
create_file "$FGPS/Roll Model.md"
create_file "$FGPS/High-Low Volatility Estimator.md"

# Second Generation: Strategic Trade Models (nodo interno)
SGSTM="$MS/02_Second Generation - Strategic Trade Models"
create_dir "$SGSTM"
create_file "$SGSTM/Kyle’s Lambda.md"
create_file "$SGSTM/Amihud’s Lambda.md"
create_file "$SGSTM/Hasbrouck’s Lambda.md"

# Third Generation: Sequential Trade Models (nodo interno)
TGSTM="$MS/03_Third Generation - Sequential Trade Models"
create_dir "$TGSTM"
create_file "$TGSTM/Probability of Information-based Trading.md"
create_file "$TGSTM/Volume-Synchronized Probability of Informed Trading.md"

# Altre Features dai Dati Microstrutturali (nodo interno)
AFDMS="$MS/04_Altre Features dai Dati Microstrutturali"
create_dir "$AFDMS"
create_file "$AFDMS/Distribution of Order Sizes.md"
create_file "$AFDMS/Cancellation Rates (Limit Orders, Market Orders).md"
create_file "$AFDMS/Time-Weighted Average Price Execution Algorithms.md"
create_file "$AFDMS/Options Markets.md"
create_file "$AFDMS/Serial Correlation of Signed Order Flow.md"

# 18. Execution e Market Impact
EXEC="$PART4/18_Execution e Market Impact"
create_dir "$EXEC"
create_file "$EXEC/Motivazione.md"

# Algoritmi di Execution (nodo interno)
ALG="$EXEC/01_Algoritmi di Execution"
create_dir "$ALG"
create_file "$ALG/VWAP.md"
create_file "$ALG/TWAP.md"
create_file "$ALG/Iceberg Orders.md"

create_file "$EXEC/Modelli di Market Impact.md"
create_file "$EXEC/Slippage e Costi di Transazione.md"

###############################################################################
# Appendice: Sviluppo, Implementazione e Risorse
###############################################################################
