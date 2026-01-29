# Detecting Abnormal Trading by U.S. Politicians  
## From Aggregate Abnormal Returns to Trade-Level Anomaly Detection

---

## 1. Background: What Ziobrowski et al. (2011) Do

Ziobrowski et al. (2011) analyze whether Members of the U.S. House of Representatives earn **abnormal returns** on their stock investments. Using Financial Disclosure Reports (FDRs), they apply a **calendar-time portfolio event study**: portfolios that mimic congressional purchases are evaluated against CAPM and Fama–French factor models.

Their main result is that portfolios tracking congressional purchases generate **positive and statistically significant alphas** (≈6% annually), especially when value-weighted. This is interpreted as evidence of a **systematic informational advantage**.

**Key takeaway:**  
*Congressional trades outperform the market on average.*

---

## 2. Limitations of the Ziobrowski Approach

Despite being foundational, the approach has important limitations:

1. **Aggregate, not trade-level**  
   It identifies abnormal returns in portfolios, not which individual trades are abnormal.

2. **No explicit abnormality concept**  
   Abnormality is inferred ex post from returns (alpha), not from trading behavior or timing.

3. **Information vs. luck**  
   Positive alpha may reflect chance, residual risk exposures, or style tilts.

4. **No mechanism analysis**  
   The method does not study how information might be obtained (committees, legislative timing, sector exposure).

5. **Rigid econometric structure**  
   Linear factor models cannot capture nonlinearities, interactions, or heterogeneity across politicians and contexts.

Thus, the paper documents *that* abnormal returns exist, but not *which trades drive them* or *why*.

---

## 3. Objective of This Project

This project shifts the focus from **average abnormal returns** to **trade-level abnormality**.

**Core objective:**  
> Detect anomalous (potentially information-driven) political trades and study the patterns and mechanisms behind them.

**Data:** ~109,000 political trades since 2013, augmented with rich market and contextual variables.

---

## 4. Conceptual Framework

The methodology is explicitly two-stage:

1. **Detection** — identify trades that are abnormal relative to market conditions and typical behavior.  
2. **Explanation** — analyze systematic patterns among abnormal trades to infer mechanisms.

Detection is statistical/predictive; explanation is economic and institutional.

---

## 5. Stage 1 — Detecting Abnormal Trades

Abnormality is defined as a **residual concept**: deviation from what is expected given market conditions and normal trading behavior.

### 5.1 Data Inputs

For each trade:
- Politician ID, date, ticker, buy/sell, trade size (or range)
- Market variables:
  - returns, volatility, volume, liquidity proxies
  - factor exposures (CAPM, FF3/FF4)
  - momentum and reversal measures
- Contextual variables (optional but valuable):
  - proximity to earnings, M&A, major announcements
  - sector classification (NAICS/GICS)

---

### 5.2 Model Options for Abnormality Detection

#### Option A — Informational Context Models (Supervised)

**Idea:** Learn what *informational market days* look like and test whether politicians trade on such days.

- Train a classifier (e.g., **Gradient Boosted Trees / Random Forests**) to predict “information days” using market variables.
- Positive labels are **informational benchmarks**, not illegal trades:
  - earnings surprises
  - M&A announcements
  - activist 13D filings

**Output:**  
A probability score measuring how “informational” the trade date is.

**Relevant references:**  
Duarte et al. (critique of PIN/APIN); Informed Trading Intensity (ITI) literature.

---

#### Option B — Behavioral Anomaly Detection (Unsupervised / Semi-Supervised)

**Idea:** Trades are abnormal if they look unusual relative to normal behavior.

- Features emphasize execution and behavior:
  - unusually large size (relative to liquidity or own history)
  - clustering or bursts
  - sector concentration
- Models:
  - **Isolation Forest**
  - One-Class SVM
  - Autoencoders

**Output:**  
A continuous **trade-level anomaly score**.

---

#### Recommended Strategy

Use **two complementary scores**:
1. **Informational-context score** (Option A)  
2. **Behavioral anomaly score** (Option B)

Trades scoring high on both are strong candidates for being information-driven.

---

## 6. Stage 2 — Economic Validation

Abnormal trades should have **economic consequences**.

Validation tools:
- **CAR / BHAR** around trade dates
- Portfolio sorts by anomaly-score deciles
- Factor-adjusted alphas (CAPM, FF, Carhart)

**Key test:**  
> Higher anomaly scores predict higher post-trade abnormal returns.

This mirrors Ziobrowski’s logic, but **conditional on detected abnormality**.

---

## 7. Stage 3 — Pattern and Mechanism Analysis

### 7.1 Pattern Discovery
- Cluster abnormal trades to identify **types of anomalies**:
  - pre-event directional trades
  - sector-specific bursts
  - synchronized trading across politicians

### 7.2 Mechanism Tests
Relate anomaly scores to political and institutional variables:
- committee–sector alignment
- seniority and leadership roles
- legislative timing
- party affiliation and networks

Methods:
- interpretable ML (tree models with SHAP)
- panel regressions with fixed effects and clustered errors

---

## 8. Contribution Relative to the Literature

- Moves **beyond Ziobrowski**: from portfolio averages to trade-level detection.
- Avoids reliance on **SEC enforcement labels**.
- Integrates **financial economics with ML-based anomaly detection**.
- Provides insight into **when, where, and how** political trading appears information-driven.

---

## 9. Summary

Ziobrowski et al. show that political trades earn abnormal returns *on average*.  
This project asks a deeper question:

> **Which trades are abnormal, and what mechanisms generate them?**

Machine learning is used not as a black box, but as a disciplined tool to:
1. detect abnormality,
2. validate it economically,
3. and explain it institutionally.
