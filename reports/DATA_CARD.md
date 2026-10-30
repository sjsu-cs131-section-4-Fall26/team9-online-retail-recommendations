# Online Retail II Data Card

## Source

UCI Machine Learning Repository: [Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii)

## File used by the scripts

The scripts expect a tab-separated text file. The original dataset may be downloaded as an Excel workbook, so the team must convert it to TSV before running the scripts. The input file must have this column order:

```text
Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer ID, Country
```

## Approximate size

The full dataset contains approximately 1,067,371 transaction records and eight main columns. The exact row count should be recorded by running `wc -l` on the team’s text version.

## Data-quality concerns

- Customer IDs can be missing.
- Product descriptions can be missing.
- Invoices beginning with `C` represent cancellations.
- Quantities can be negative because of returns or cancellations.
- Duplicate transaction rows may exist.
- The data is heavily concentrated in the United Kingdom.
- Product descriptions may contain spaces and punctuation.

## Reproducibility assumptions

- The file is tab-separated.
- The first line is a header.
- Product descriptions do not contain literal tab characters.
- The scripts receive the input path as their only argument.
