# Variable Definitions: Congressional Trading Panel

## Panel Structure

| Variable | Description |
|----------|-------------|
| `ticker` | Stock ticker symbol |
| `month` | Trading month (YYYY-MM) |

---

## 1. Basic Counts

| Variable | Description | Type |
|----------|-------------|------|
| `cong_total_trades` | Total number of congressional trades in this stock-month | Count |
| `cong_buy_count` | Number of purchase transactions | Count |
| `cong_sell_count` | Number of sale transactions | Count |
| `cong_unique_politicians` | Number of distinct politicians trading this stock in the month | Count |

---

## 2. Trade Amounts

| Variable | Description | Type |
|----------|-------------|------|
| `cong_total_amount` | Sum of estimated trade amounts (USD proxy based on reported ranges) | USD |
| `cong_large_trades` | Number of trades ≥ $100,000 | Count |
| `cong_large_ratio` | Proportion of large trades: `cong_large_trades / cong_total_trades` | Ratio [0,1] |

---

## 3. Direction & Sentiment

| Variable | Description | Type |
|----------|-------------|------|
| `cong_net` | Net trades: `cong_buy_count - cong_sell_count` | Integer |
| `cong_buy_ratio` | Proportion of buys: `cong_buy_count / cong_total_trades` | Ratio [0,1] |
| `cong_csi` | Congressional Sentiment Index: `cong_net / cong_total_trades`. Ranges from -1 (all sells) to +1 (all buys) | Ratio [-1,1] |

---

## 4. Timing

| Variable | Description | Type |
|----------|-------------|------|
| `cong_avg_disclosure_delay` | Average days between trade date and public filing date | Days |
| `cong_long_delay_trades` | Number of trades with disclosure delay > 30 days | Count |
| `cong_long_delay_ratio` | Proportion of long-delay trades | Ratio [0,1] |
| `cong_end_of_month_trades` | Trades in last 5 days of month (potential window dressing) | Count |
| `cong_monday_trades` | Trades on Mondays | Count |
| `cong_friday_trades` | Trades on Fridays | Count |

---

## 5. Committee Information

| Variable | Description | Type |
|----------|-------------|------|
| `cong_info_committee_trades` | Trades by members of informationally-sensitive committees (Armed Services, Finance, Intelligence, etc.) | Count |
| `cong_info_ratio` | Proportion from info committees: `cong_info_committee_trades / cong_total_trades` | Ratio [0,1] |
| `cong_chair_trades` | Trades by committee chairs or ranking members | Count |
| `cong_chair_ratio` | Proportion by chairs/ranking: `cong_chair_trades / cong_total_trades` | Ratio [0,1] |

**Informationally-Sensitive Committees:**
- Armed Services
- Financial Services
- Energy and Commerce
- Intelligence / Select Committee on Intelligence
- Ways and Means
- Appropriations
- Health Education Labor and Pensions
- Banking, Housing and Urban Affairs
- Finance
- Judiciary
- Commerce, Science and Transportation

---

## 6. Political Power

| Variable | Description | Type |
|----------|-------------|------|
| `cong_senior_trades` | Trades by politicians with ≥ 10 years in position | Count |
| `cong_senior_ratio` | Proportion by senior members | Ratio [0,1] |
| `cong_wealthy_trades` | Trades by politicians with above-median net worth | Count |
| `cong_senator_trades` | Trades by senators (vs. representatives) | Count |
| `cong_senator_ratio` | Proportion by senators | Ratio [0,1] |
| `cong_avg_power_index` | Average power index of trading politicians. Power index = is_chair + is_senator + is_senior + is_info_committee (range 0-4) | Index [0,4] |
| `cong_max_power_index` | Maximum power index among traders | Index [0,4] |
| `cong_avg_seniority` | Average years in position | Years |
| `cong_avg_net_worth` | Average net worth of trading politicians | USD |

---

## 7. Party

| Variable | Description | Type |
|----------|-------------|------|
| `cong_dem_trades` | Trades by Democrats | Count |
| `cong_rep_trades` | Trades by Republicans | Count |
| `cong_dem_ratio` | Proportion by Democrats | Ratio [0,1] |
| `cong_rep_ratio` | Proportion by Republicans | Ratio [0,1] |
| `cong_bipartisan` | Binary: both parties traded this stock-month | Binary {0,1} |

---

## 8. Trader Behavior

| Variable | Description | Type |
|----------|-------------|------|
| `cong_frequent_trader_trades` | Trades by "frequent traders" (top 25% by total trades) | Count |
| `cong_frequent_trader_ratio` | Proportion by frequent traders | Ratio [0,1] |
| `cong_first_time_trades` | Trades where politician had never traded this stock before | Count |
| `cong_first_time_ratio` | Proportion of first-time trades (new information?) | Ratio [0,1] |
| `cong_direction_change_trades` | Trades where politician reversed direction (was buying, now selling or vice versa) | Count |

---

## 9. Coordination

| Variable | Description | Type |
|----------|-------------|------|
| `cong_coordinated_trades` | Trades where ≥2 politicians traded same stock on same day | Count |
| `cong_coordinated_ratio` | Proportion of coordinated trades | Ratio [0,1] |
| `cong_party_coordinated_trades` | Trades where ≥2 politicians of same party traded same stock on same day | Count |
| `cong_party_coordinated_ratio` | Proportion of party-coordinated trades | Ratio [0,1] |
| `cong_committee_coordinated_trades` | Trades where ≥2 politicians from same committee traded same stock on same day | Count |
| `cong_committee_coordinated_ratio` | Proportion of committee-coordinated trades (potential "insider ring") | Ratio [0,1] |
| `cong_max_traders_same_day` | Maximum number of politicians trading this stock on a single day | Count |
| `cong_multiple_politicians` | Binary: more than one politician traded this stock-month | Binary {0,1} |

---

## 10. Market Context

These variables capture whether politicians trade during specific market conditions.

| Variable | Description | Type |
|----------|-------------|------|
| `cong_contrarian_trades` | Trades that are contrarian: buying when 20d momentum < 0, or selling when momentum > 0 | Count |
| `cong_contrarian_ratio` | Proportion of contrarian trades | Ratio [0,1] |
| `cong_high_vol_trades` | Trades when stock's 30d realized volatility > median | Count |
| `cong_high_vol_ratio` | Proportion of high-volatility trades | Ratio [0,1] |
| `cong_illiquid_trades` | Trades in stocks with Amihud illiquidity > median | Count |
| `cong_illiquid_ratio` | Proportion of illiquid-stock trades | Ratio [0,1] |
| `cong_small_cap_trades` | Trades in stocks with market cap < median | Count |
| `cong_small_cap_ratio` | Proportion of small-cap trades | Ratio [0,1] |

**Note:** Context variables require market data (momentum, volatility, illiquidity, market cap) to be present in the input data. If unavailable, these will be 0.

---

## 11. Composite Signals

These are derived signals combining multiple characteristics that may indicate informed trading.

| Variable | Description | Type |
|----------|-------------|------|
| `cong_smart_money_buy_trades` | Buys by chair/ranking member of info committee | Count |
| `cong_smart_money_sell_trades` | Sells by chair/ranking member of info committee | Count |
| `cong_smart_money` | Binary: net positive AND info committee AND chair involved | Binary {0,1} |
| `cong_insider_ring_trades` | Committee-coordinated trades in info committee (multiple members of same powerful committee trading together) | Count |
| `cong_has_insider_ring` | Binary: any insider ring activity | Binary {0,1} |
| `cong_hidden_trades` | Trades in illiquid/small-cap stocks by info committee members (harder to detect) | Count |
| `cong_has_hidden` | Binary: any hidden trade activity | Binary {0,1} |
| `cong_opportunistic_trades` | Contrarian + large + info committee (potentially exploiting private info during market stress) | Count |
| `cong_has_opportunistic` | Binary: any opportunistic trade activity | Binary {0,1} |

---

## 12. Consensus Signals

| Variable | Description | Type |
|----------|-------------|------|
| `cong_consensus_buy` | Binary: buy ratio > 70% | Binary {0,1} |
| `cong_consensus_sell` | Binary: buy ratio < 30% | Binary {0,1} |
| `cong_strong_buy` | Binary: CSI > 0.5 AND ≥2 unique politicians | Binary {0,1} |
| `cong_strong_sell` | Binary: CSI < -0.5 AND ≥2 unique politicians | Binary {0,1} |

---

## 13. Intensity

| Variable | Description | Type |
|----------|-------------|------|
| `cong_intensity` | Average trades per politician: `cong_total_trades / cong_unique_politicians` | Ratio |

---

## Notes

### Missing Values
- All ratio variables are computed as count / total_trades
- If total_trades = 0 (which shouldn't happen in this panel), ratios would be undefined
- NaN values in ratios are filled with 0

### Interpretation Guidelines

**For Information Hypothesis:**
- High `cong_info_ratio` + positive `cong_csi` → Informed buying
- High `cong_chair_ratio` → Trades by most informed members
- High `cong_committee_coordinated_ratio` → Potential coordinated informed trading
- `cong_has_insider_ring = 1` → Suspicious coordination pattern

**For Timing Analysis:**
- High `cong_long_delay_ratio` → Delayed disclosure (hiding signal?)
- High `cong_contrarian_ratio` → Trading against momentum (private info?)

**For Power Analysis:**
- High `cong_avg_power_index` → Trades by powerful/connected politicians
- `cong_senator_ratio` → Senate vs House (Senate typically has more oversight)

---

## Variable Count Summary

| Category | Count |
|----------|-------|
| Identifiers | 2 |
| Basic counts | 4 |
| Amounts | 3 |
| Direction/Sentiment | 3 |
| Timing | 6 |
| Committee | 4 |
| Power | 9 |
| Party | 5 |
| Behavior | 5 |
| Coordination | 8 |
| Market Context | 8 |
| Composite Signals | 9 |
| Consensus | 4 |
| Intensity | 1 |
| **Total** | **~70** |
