# Team 9 - Online Retail II

This repository contains the UNIX exploration and SED/AWK cleaning pipelines for CS 131 Project Assignment 2 using the UCI Online Retail II dataset.

## Dataset

The full dataset is not committed to Git. It must be stored outside the repository or in an ignored directory.

The scripts expect one combined TSV file created from both Online Retail II workbook sheets with:

- 1,067,372 lines including the header
- 1,067,371 transaction records
- 8 tab-separated columns

The header order must be:

```text
Invoice<TAB>StockCode<TAB>Description<TAB>Quantity<TAB>InvoiceDate<TAB>Price<TAB>Customer ID<TAB>Country
```

Dataset source: [UCI Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii)

See the [Data Card](reports/DATA_CARD.md) and [Start Here guide](reports/START_HERE.md) for dataset and execution instructions.

## Part 1

Run:

```bash
bash run_pa1.sh /path/to/online_retail_II_combined.tsv
```

Part 1 generates:

- A header-preserving 1,000-record sample
- Country and stock-code frequency tables
- A Top-20 stock-code list
- A five-column skinny table
- Cancellation and non-cancellation previews
- Redirection and `tee` demonstrations
- A captured `script` session

Important outputs include:

```text
data/samples/online_retail_sample.tsv
out/freq_country.txt
out/freq_stockcode.txt
out/top20_stockcodes.txt
out/skinny_table.tsv
logs/project2_part1_session.txt
```

## Part 2

Run:

```bash
bash run_pa2.sh /path/to/online_retail_II_combined.tsv
```

Part 2 uses:

- `sed` for line-ending and trailing-whitespace normalization
- `awk` for header preservation and quality filtering
- Strict shell mode and input validation
- Relative output paths and logs

The cleaned output preserves the header and contains exactly eight fields per row.

## Repository and Git Hygiene

- The full dataset is excluded from Git.
- Generated `out/` and `logs/` directories are excluded from Git.
- The required 1,000-record sample is committed under `data/samples/`.
- Changes are developed on feature branches.
- Pull requests require peer review before merging.

## Project Documentation

- [Data Card](reports/DATA_CARD.md)
- [Project Assignment 2 Report](reports/PROJECT_ASSIGNMENT_2_REPORT.md)
- [PM Board Updates](reports/PM_BOARD_UPDATES.md)
- [Start Here Guide](reports/START_HERE.md)
- [Submission Checklist](reports/SUBMISSION_CHECKLIST.md)

## Team

- Kushan Mehta
- Kanishka Yadav
- Sanjini Shukla
- Lipi Himanshukumar Makwana
