# Start Here - Project Assignment 2

This repository contains the completed Part 1 and Part 2 shell pipelines for the UCI Online Retail II dataset.

The full dataset is not committed to Git. It is stored outside the repository on the IBM server. The repository contains the scripts, documentation, and required 1,000-record sample.

## Repository Contents

Important files include:

```text
README.md
reports/DATA_CARD.md
reports/PROJECT_ASSIGNMENT_2_REPORT.md
reports/PM_BOARD_UPDATES.md
reports/SUBMISSION_CHECKLIST.md
run_pa1.sh
run_pa2.sh
data/samples/online_retail_sample.tsv
.gitignore
```

## Input Dataset

The scripts require one combined tab-separated file created from both Online Retail II workbook sheets.

The verified full dataset contains:

- 1,067,372 lines including the header
- 1,067,371 transaction records
- 8 tab-separated columns

The header order is:

```text
Invoice<TAB>StockCode<TAB>Description<TAB>Quantity<TAB>InvoiceDate<TAB>Price<TAB>Customer ID<TAB>Country
```

Example IBM input path:

```text
../online_retail_II_combined.tsv
```

Do not pass the Excel workbook directly to the shell scripts. Do not use the generated sample as the input file.

## Part 1

Run Part 1 from the repository directory:

```bash
bash run_pa1.sh ../online_retail_II_combined.tsv
```

Part 1 creates:

```text
data/samples/online_retail_sample.tsv
out/freq_country.txt
out/freq_stockcode.txt
out/top20_stockcodes.txt
out/skinny_table.tsv
out/cancellation_examples.tsv
out/non_cancellation_preview.tsv
out/row_count.txt
logs/project2_part1_session.txt
```

Inspect the outputs:

```bash
cat out/freq_country.txt
cat out/freq_stockcode.txt
cat out/top20_stockcodes.txt
head out/skinny_table.tsv
cat out/row_count.txt
wc -l data/samples/online_retail_sample.tsv
```

The sample should contain 1,001 lines: one header plus 1,000 records.

## Part 2

Run Part 2 using the same full TSV:

```bash
bash run_pa2.sh ../online_retail_II_combined.tsv
```

Part 2 creates:

```text
out/pa2_sed_normalized.tsv
out/pa2_cleaned.tsv
out/pa2_before_after_sample.txt
logs/pa2_run.log
```

Check the outputs:

```bash
ls -lh out/pa2_sed_normalized.tsv
ls -lh out/pa2_cleaned.tsv
ls -lh out/pa2_before_after_sample.txt
ls -lh logs/pa2_run.log
head -n 1 out/pa2_cleaned.tsv
```

The first line of `out/pa2_cleaned.tsv` must remain the header.

Validate the cleaned file:

```bash
awk -F '\t' 'NR > 1 && NF != 8 {bad++} END {print "Bad field-count rows:", bad+0}' out/pa2_cleaned.tsv
```

```bash
awk -F '\t' 'NR > 1 && ($4 <= 0 || $6 <= 0) {bad++} END {print "Invalid quantity/price rows:", bad+0}' out/pa2_cleaned.tsv
```

Both commands should report zero.

## Syntax and Permissions

Run each command separately:

```bash
bash -n run_pa1.sh
```

```bash
bash -n run_pa2.sh
```

```bash
chmod +x run_pa1.sh run_pa2.sh
```

## Git and Review Workflow

- Work on feature branches.
- Do not commit the full dataset.
- Do not commit `out/` or `logs/`.
- Commit the required sample under `data/samples/`.
- Open pull requests for changes.
- Obtain peer review before merging.
- Squash-merge only after review and checks pass.

## Documentation and PM Board

Update:

```text
reports/PROJECT_ASSIGNMENT_2_REPORT.md
reports/PM_BOARD_UPDATES.md
reports/SUBMISSION_CHECKLIST.md
```

The Google Sheets PM board is the official live board. Update it with owners, statuses, dates, Definitions of Done, and repository, PR, and Google Doc links.

The Google Doc sprint report must include:

- Executive summary
- Methods
- Two frequency tables
- Top-N findings
- Skinny-table reference
- Data-quality limitations
- Next PM question
- Repository, PM board, script, and PR links
- Five-line stand-up summary

Enable comments on the Google Doc before submission.

## Canvas Submission

Submit:

- Google Doc sprint report link
- GitHub repository link
- Google Sheets PM board link
