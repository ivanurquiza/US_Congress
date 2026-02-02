# Do Congressional Trades Contain Private Information?

This project tests whether stock trades by U.S. Congress members contain information beyond what's already reflected in market prices. If markets are efficient, public information should be fully incorporated into prices—meaning congressional trading data shouldn't help predict future returns. But if legislators exploit privileged access to material non-public information (committee briefings, advance knowledge of legislation, regulatory decisions), their trades might signal something the market doesn't yet know.

We approach this as a prediction problem, not a causal inference problem. The question isn't "what's the effect of congressional trades on returns" but rather "does adding congressional trading data improve out-of-sample return forecasts?"

## The Test

We compare two models predicting 30-day cumulative abnormal returns (Fama-French 3-factor adjusted):

**Base Model**: Uses only publicly available market information—momentum, volatility, liquidity, size, book-to-market, beta, etc.

**Augmented Model**: Adds features derived from congressional trading activity—net buying pressure, coordination across politicians, trades by members of information-sensitive committees, disclosure delays, and similar signals.

Both models are estimated using expanding-window temporal cross-validation to prevent look-ahead bias. If the augmented model predicts significantly better out-of-sample, this suggests congressional trades carry information not yet in prices—consistent with the Grossman-Stiglitz (1980) view that informed traders must earn compensation for acquiring private information.

## Data

We built the dataset from scratch by scraping and merging multiple sources:

- **Trades**: ~106,000 transactions from 2011–2026 via QuiverQuantitative (sourced from STOCK Act filings)
- **Politician characteristics**: Wikipedia and Ballotpedia (party, chamber, committees, seniority, net worth)
- **Market data**: Yahoo Finance (prices, volume, returns)

The panel is constructed at the (stock, month) level, aggregating congressional activity and market conditions for each ticker-month where at least one legislator traded.

## What We Find

The augmented model outperforms the base model across multiple algorithms (Ridge, Random Forest, Gradient Boosting). The improvement is small in absolute terms—this is return prediction, after all—but statistically significant and robust to placebo tests using randomly shuffled congressional features.

Features with the highest predictive contribution include the ratio of trades by information-committee members, coordination measures (multiple politicians trading the same stock), and disclosure timing patterns.

## Limitations

Predicting returns is hard. Out-of-sample R² values are low for both models (as expected in efficient markets). The improvement from congressional features, while statistically significant, doesn't translate into a practical trading strategy after transaction costs.

More importantly: detecting predictive signal is not the same as proving insider trading. Politicians might simply be better-informed investors, or the signal could reflect legal information advantages (e.g., understanding policy implications better than the average retail investor). We make no claims about legality—only about information content.

## References

- Grossman, S. & Stiglitz, J. (1980). On the Impossibility of Informationally Efficient Markets. *American Economic Review*.
- Mullainathan, S. & Spiess, J. (2017). Machine Learning: An Applied Econometric Approach. *Journal of Economic Perspectives*.
- Mazzarisi, P. et al. (2022). Detection of Anomalous Trading Behaviour Using Unsupervised Learning and Statistically Validated Networks.
- Bauer, T. (2022). Congressional Stock Trading During the COVID-19 Pandemic.
