# Project Assignment 2 Sprint Report

## Executive Summary

- We analyzed the UCI Online Retail II dataset containing 1,067,371 transaction records and eight columns.
- Part 1 used UNIX streams, pipes, `cut`, `sort`, `uniq`, `wc`, `grep`, `tee`, output redirection, and `script`.
- The dataset is strongly concentrated in the United Kingdom, which contains 981,330 transaction rows.
- Stock code 85123A is the most frequent product code, appearing in 5,829 transaction rows.
- Part 2 used `sed` and `awk` to create a reproducible cleaned dataset containing 1,041,671 usable transaction records.

## Links

- GitHub repository: https://github.com/sjsu-cs131-section-4-Fall26/team9-online-retail-recommendations
- PM board: `[PASTE THE ACTUAL PM BOARD LINK HERE]`
- Part 1 entry script: `./run_pa1.sh`
- Part 2 entry script: `./run_pa2.sh`
- Pull requests: `[PASTE THE PULL REQUEST LINKS HERE]`

## Dataset and Data Card

The project uses the UCI Online Retail II dataset:

https://archive.ics.uci.edu/dataset/502/online+retail+ii

The original workbook contained two sheets:

- Year 2009-2010: 525,461 rows
- Year 2010-2011: 541,910 rows

After combining the sheets, the TSV contained 1,067,371 transaction records plus one header row. The TSV was approximately 89 MB and contained these eight columns:

```text
Invoice
StockCode
Description
Quantity
InvoiceDate
Price
Customer ID
Country
```

The full dataset and generated outputs are excluded from Git. The scripts receive the TSV path as their only input.

Important quality issues include missing Customer IDs, canceled invoices, negative or zero quantities, duplicate rows, and missing or inconsistent product descriptions.

## Part 1 Methods

Part 1 was run with:

```bash
bash run_pa1.sh ../data/raw/online_retail_II.tsv
```

The script verified the input, counted rows, previewed the header, and created a random 1,000-record sample while preserving the header. The sample contains 1,001 lines total.

The frequency tables used pipelines such as:

```bash
tail -n +2 "$INPUT" | cut -f8 | sort | uniq -c | sort -nr
```

The script also demonstrated pipes, `>`, `>>`, `2>`, `tee`, `grep -i`, `grep -v`, and `script` session capture.

## Part 1 Findings

### Country frequency table

| Country | Transaction rows |
|---|---:|
| United Kingdom | 981,330 |
| EIRE | 17,866 |
| Germany | 17,624 |
| France | 14,330 |
| Netherlands | 5,140 |
| Spain | 3,811 |
| Switzerland | 3,189 |
| Belgium | 3,123 |
| Portugal | 2,620 |
| Australia | 1,913 |

The United Kingdom accounts for the overwhelming majority of transaction rows, so overall patterns primarily describe UK purchasing behavior.

### Top stock-code frequency table

| Rank | Stock code | Transaction rows |
|---:|---|---:|
| 1 | 85123A | 5,829 |
| 2 | 22423 | 4,424 |
| 3 | 85099B | 4,216 |
| 4 | 21212 | 3,318 |
| 5 | 20725 | 3,259 |
| 6 | 84879 | 2,960 |
| 7 | 47566 | 2,768 |
| 8 | 21232 | 2,747 |
| 9 | 22197 | 2,549 |
| 10 | 22383 | 2,540 |

Stock code 85123A is the most frequent product code. A small group of products appears very frequently and may be useful for future recommendation analysis.

### Data-quality findings

- Missing Customer IDs: 243,007 rows.
- Cancellation rows identified by invoices beginning with `C`: 19,494.
- Zero or negative quantities: 22,950 rows.
- Duplicate complete rows: 32,907.

## Part 2 Methods

Part 2 was run with:

```bash
bash run_pa2.sh ../data/raw/online_retail_II.tsv
```

The SED stage removed carriage-return characters and trailing whitespace while preserving meaningful spaces inside product descriptions.

The AWK stage preserved the header and retained rows with at least eight fields, a nonempty invoice, a nonempty stock code, a positive integer quantity, and a positive price.

The results were:

| Stage | Lines |
|---|---:|
| Original input including header | 1,067,372 |
| After SED normalization | 1,067,372 |
| After AWK filtering | 1,041,672 |

The cleaned output contains 1,041,671 transaction records plus the header. Therefore, 25,700 records were removed by the quality filter. Every cleaned row contains exactly eight fields, and no cleaned row has a nonpositive quantity or price.

The script uses `set -euo pipefail`, validates the input, creates `out/` and `logs/`, uses relative paths, and writes a run log.

## Limitations

The Part 2 filter is designed for completed purchases. It removes rows with nonpositive quantities or prices, so returns and cancellations are not represented in the cleaned purchase data.

Many Customer IDs are missing. Because the current Part 2 filter does not require a Customer ID, some cleaned rows still have missing customer information. A future customer-level recommendation model should apply an additional Customer ID filter.

The dataset is highly concentrated in the United Kingdom, so country comparisons should be interpreted carefully. Duplicate rows may also affect counts unless removed in a later processing stage.

## Next PM Question

Which products generate the highest total revenue after removing cancellations, returns, duplicate rows, and transactions with missing Customer IDs?

## Stand-up Summary

1. Kushan verified the dataset, converted the Excel workbook to TSV, and completed the Data Card.
2. Part 1 generated a 1,000-record sample, two frequency tables, a Top-20 list, and a session log.
3. The team identified missing Customer IDs, cancellations, nonpositive quantities, and duplicate rows.
4. Part 2 used SED for normalization and AWK for quality filtering.
5. The remaining work is to commit the scripts, complete the PM board, obtain pull-request review, and submit the report, repository link, and board link.
