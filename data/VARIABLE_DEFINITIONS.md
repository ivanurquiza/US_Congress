# Variable Definitions: Congressional Trading Panel

**Base:** `panel_final_stock_month.parquet`  
**Nivel:** (ticker, month) — Una observación por acción-mes con actividad de congresistas  
**Observaciones:** ~32,000  

---

## Identificadores

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `ticker` | string | Símbolo bursátil (ej: AAPL, MSFT) |
| `month` | period | Mes en formato YYYY-MM |
| `month_dt` | datetime | Fecha del primer día del mes (para ordenar) |

---

## Variables Objetivo (Target)

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `ret_future_1m` | float | (-∞, +∞) | Retorno de la acción en el mes t+1 |
| `ret_future_car30_ff3` | float | (-∞, +∞) | CAR ajustado por Fama-French 3 factores, 30 días post-trade (último trade del mes) |
| `ret_future_car30_raw` | float | (-∞, +∞) | CAR sin ajustar (retorno - retorno mercado), 30 días |
| `ret_future_car30_ff3_wavg` | float | (-∞, +∞) | CAR FF3 promedio ponderado por monto de todos los trades del mes |

**Recomendación:** Usar `ret_future_car30_ff3` — aísla el retorno anormal no explicado por factores públicos.

---

## Features de Congreso (cong_*)

### Conteos Básicos

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_total_trades` | int | [1, ∞) | Total de trades en este ticker-mes |
| `cong_buy_count` | int | [0, ∞) | Número de compras |
| `cong_sell_count` | int | [0, ∞) | Número de ventas |
| `cong_unique_politicians` | int | [1, ∞) | Políticos distintos que operaron |

### Dirección y Sentimiento

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_net` | int | (-∞, +∞) | Compras - Ventas |
| `cong_buy_ratio` | float | [0, 1] | Proporción de compras |
| `cong_csi` | float | [-1, 1] | **Congressional Sentiment Index**: (compras-ventas)/total. +1=todo compras, -1=todo ventas |

### Montos

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_total_amount` | float | [0, ∞) | Suma de montos estimados (USD) |
| `cong_avg_amount` | float | [0, ∞) | Monto promedio por trade |
| `cong_large_trades` | int | [0, ∞) | Trades ≥ $100,000 |
| `cong_large_ratio` | float | [0, 1] | Proporción de trades grandes |

### Timing

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_avg_disclosure_delay` | float | [0, 365] | Días promedio entre trade y disclosure público |
| `cong_max_disclosure_delay` | float | [0, 365] | Máximo delay de disclosure |
| `cong_long_delay_trades` | int | [0, ∞) | Trades con delay > 30 días |
| `cong_long_delay_ratio` | float | [0, 1] | Proporción con delay largo |
| `cong_end_of_month_trades` | int | [0, ∞) | Trades en últimos 5 días del mes |
| `cong_monday_trades` | int | [0, ∞) | Trades en lunes |
| `cong_friday_trades` | int | [0, ∞) | Trades en viernes |

### Comités e Información

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_info_committee_trades` | int | [0, ∞) | Trades de miembros de comités informativos* |
| `cong_info_ratio` | float | [0, 1] | Proporción de trades de comités informativos |
| `cong_chair_trades` | int | [0, ∞) | Trades de chairs o ranking members |
| `cong_chair_ratio` | float | [0, 1] | Proporción de chairs/ranking |

*Comités informativos: Armed Services, Financial Services, Energy and Commerce, Intelligence, Ways and Means, Appropriations, Health/Education/Labor, Banking, Finance, Judiciary, Commerce/Science/Transportation.

### Poder Político

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_senator_trades` | int | [0, ∞) | Trades de senadores (vs representantes) |
| `cong_senator_ratio` | float | [0, 1] | Proporción de senadores |
| `cong_senior_trades` | int | [0, ∞) | Trades de políticos con ≥10 años |
| `cong_senior_ratio` | float | [0, 1] | Proporción de seniors |
| `cong_wealthy_trades` | int | [0, ∞) | Trades de políticos con patrimonio > mediana |
| `cong_avg_power_index` | float | [0, 4] | Promedio de: is_chair + is_senator + is_senior + is_info_committee |
| `cong_max_power_index` | float | [0, 4] | Máximo power index |
| `cong_avg_seniority` | float | [0, ∞) | Años promedio en el cargo |
| `cong_avg_net_worth` | float | [0, ∞) | Patrimonio neto promedio |

### Partido

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_dem_trades` | int | [0, ∞) | Trades de demócratas |
| `cong_rep_trades` | int | [0, ∞) | Trades de republicanos |
| `cong_dem_ratio` | float | [0, 1] | Proporción demócratas |
| `cong_rep_ratio` | float | [0, 1] | Proporción republicanos |
| `cong_bipartisan` | binary | {0, 1} | 1 si ambos partidos operaron |

### Comportamiento

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_frequent_trader_trades` | int | [0, ∞) | Trades de "frequent traders" (top 25% por volumen) |
| `cong_frequent_trader_ratio` | float | [0, 1] | Proporción de frequent traders |
| `cong_first_time_trades` | int | [0, ∞) | Trades donde el político nunca había operado este ticker |
| `cong_first_time_ratio` | float | [0, 1] | Proporción de first-time trades |
| `cong_direction_change_trades` | int | [0, ∞) | Trades donde el político cambió de dirección (compraba→vende o viceversa) |

### Coordinación

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_coordinated_trades` | int | [0, ∞) | Trades donde ≥2 políticos operaron el mismo día |
| `cong_coordinated_ratio` | float | [0, 1] | Proporción coordinada |
| `cong_party_coordinated_trades` | int | [0, ∞) | Trades donde ≥2 del mismo partido operaron el mismo día |
| `cong_party_coordinated_ratio` | float | [0, 1] | Proporción coordinada por partido |
| `cong_committee_coordinated_trades` | int | [0, ∞) | Trades donde ≥2 del mismo comité operaron el mismo día |
| `cong_committee_coordinated_ratio` | float | [0, 1] | Proporción coordinada por comité |
| `cong_max_traders_same_day` | int | [1, ∞) | Máximo de políticos operando el mismo día |
| `cong_multiple_politicians` | binary | {0, 1} | 1 si más de un político operó este mes |

### Contexto de Mercado

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_contrarian_trades` | int | [0, ∞) | Trades contrarian: compra cuando momentum<0, vende cuando momentum>0 |
| `cong_contrarian_ratio` | float | [0, 1] | Proporción contrarian |
| `cong_high_vol_trades` | int | [0, ∞) | Trades cuando volatilidad > mediana |
| `cong_high_vol_ratio` | float | [0, 1] | Proporción en alta volatilidad |
| `cong_illiquid_trades` | int | [0, ∞) | Trades en acciones con Amihud > mediana |
| `cong_illiquid_ratio` | float | [0, 1] | Proporción en ilíquidas |
| `cong_small_cap_trades` | int | [0, ∞) | Trades en acciones con market cap < mediana |
| `cong_small_cap_ratio` | float | [0, 1] | Proporción en small caps |

### Señales Compuestas

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_smart_money_buy_trades` | int | [0, ∞) | Compras de chair de comité informativo |
| `cong_smart_money_sell_trades` | int | [0, ∞) | Ventas de chair de comité informativo |
| `cong_smart_money` | binary | {0, 1} | 1 si: net>0 AND info_committee>0 AND chair>0 |
| `cong_insider_ring_trades` | int | [0, ∞) | Coordinación de comité + comité informativo |
| `cong_has_insider_ring` | binary | {0, 1} | 1 si hubo insider ring |
| `cong_hidden_trades` | int | [0, ∞) | Trades en ilíquidas/small caps por comité informativo |
| `cong_has_hidden` | binary | {0, 1} | 1 si hubo hidden trades |
| `cong_opportunistic_trades` | int | [0, ∞) | Contrarian + large + comité informativo |
| `cong_has_opportunistic` | binary | {0, 1} | 1 si hubo trades oportunistas |

### Consenso

| Variable | Tipo | Rango | Descripción |
|----------|------|-------|-------------|
| `cong_consensus_buy` | binary | {0, 1} | 1 si buy_ratio > 70% |
| `cong_consensus_sell` | binary | {0, 1} | 1 si buy_ratio < 30% |
| `cong_strong_buy` | binary | {0, 1} | 1 si CSI > 0.5 AND ≥2 políticos |
| `cong_strong_sell` | binary | {0, 1} | 1 si CSI < -0.5 AND ≥2 políticos |
| `cong_intensity` | float | [1, ∞) | Trades por político |

---

## Features de Mercado (mkt_*)

### Retornos y Momentum

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `mkt_return_t` | float | Retorno del día del trade |
| `mkt_excess_return` | float | Retorno en exceso del risk-free |
| `mkt_momentum_5d` | float | Retorno acumulado 5 días |
| `mkt_momentum_20d` | float | Retorno acumulado 20 días |
| `mkt_momentum_60d` | float | Retorno acumulado 60 días |
| `mkt_momentum_252d` | float | Retorno acumulado 252 días (1 año) |

### Volatilidad

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `mkt_realized_vol_30d` | float | Volatilidad realizada 30 días (anualizada) |
| `mkt_realized_vol_60d` | float | Volatilidad realizada 60 días |
| `mkt_realized_vol_252d` | float | Volatilidad realizada 252 días |
| `mkt_parkinson_vol_30d` | float | Volatilidad Parkinson (high-low) 30 días |
| `mkt_vol_of_vol_60d` | float | Volatilidad de la volatilidad |

### Liquidez

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `mkt_volume_ratio_30d` | float | Volumen / promedio 30 días |
| `mkt_abnormal_volume_30d` | float | Volumen - promedio 30 días |
| `mkt_amihud_illiq_20d` | float | Iliquidez de Amihud (×10⁶) |
| `mkt_roll_spread_30d` | float | Roll spread estimado |
| `mkt_hl_spread_20d` | float | Spread high-low promedio |
| `mkt_zero_volume_days_30d` | int | Días sin volumen en 30 días |

### Factor Exposures

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `mkt_beta_252d` | float | Beta CAPM (252 días) |
| `mkt_r2_market_252d` | float | R² del modelo de mercado |
| `mkt_alpha_ff3_252d` | float | Alpha Fama-French 3 factores (anualizado) |
| `mkt_beta_mkt_ff3_252d` | float | Beta de mercado (FF3) |
| `mkt_beta_smb_ff3_252d` | float | Beta SMB (size) |
| `mkt_beta_hml_ff3_252d` | float | Beta HML (value) |
| `mkt_r2_ff3_252d` | float | R² del modelo FF3 |

### Fundamentales

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `mkt_market_cap` | float | Capitalización de mercado (millones USD) |
| `mkt_price` | float | Precio de la acción |
| `mkt_book_value` | float | Valor libro por acción |
| `mkt_price_to_book` | float | Ratio precio/libro |
| `mkt_ev_to_ebitda` | float | Enterprise Value / EBITDA |

---

## Notas Metodológicas

### Construcción del Panel

1. **Nivel de observación:** Solo ticker-meses con al menos 1 trade de congresista
2. **Variables de mercado:** Tomadas del ÚLTIMO trade del mes (proxy de fin de mes)
3. **CAR ponderado:** Promedio de CARs ponderado por monto del trade

### Winsorización

Todas las variables numéricas winzorizadas al 1% y 99% para reducir influencia de outliers.

### Missing Values

- Ratios con denominador 0: rellenados con 0
- Variables de mercado: pueden tener NaN si no había datos

### Interpretación para Hipótesis de Información

| Si observamos... | Sugiere... |
|------------------|------------|
| Alto `cong_info_ratio` + `cong_csi` > 0 | Compra informada |
| Alto `cong_chair_ratio` | Trades de los más informados |
| Alto `cong_committee_coordinated_ratio` | Posible "insider ring" |
| `cong_has_insider_ring` = 1 | Patrón sospechoso de coordinación |
| Alto `cong_long_delay_ratio` | Posible ocultamiento de señal |
| Alto `cong_contrarian_ratio` | Trading contra momentum (¿info privada?) |

---

## Resumen de Conteo

| Categoría | # Variables |
|-----------|-------------|
| Identificadores | 3 |
| Targets | 4 |
| Congreso - Conteos | 4 |
| Congreso - Dirección | 3 |
| Congreso - Montos | 4 |
| Congreso - Timing | 7 |
| Congreso - Comités | 4 |
| Congreso - Poder | 9 |
| Congreso - Partido | 5 |
| Congreso - Comportamiento | 5 |
| Congreso - Coordinación | 8 |
| Congreso - Contexto | 8 |
| Congreso - Compuestas | 10 |
| Congreso - Consenso | 5 |
| Mercado - Retornos | 6 |
| Mercado - Volatilidad | 5 |
| Mercado - Liquidez | 6 |
| Mercado - Factores | 7 |
| Mercado - Fundamentales | 5 |
| **TOTAL** | **~108** |
