# Start Here - Beginner Instructions

## What you have

This folder contains the files for both parts of Project Assignment 2. You still need to run them on the team’s real TSV dataset and paste the real findings into `REPORT_DRAFT.md`.

## Step 1: Put the files in the repository

Copy these files into the team repository:

```text
README.md
DATA_CARD.md
REPORT_DRAFT.md
PM_BOARD_UPDATES.md
SUBMISSION_CHECKLIST.md
run_pa1.sh
run_pa2.sh
.gitignore
```

## Step 2: Find the dataset

The scripts require a text file, preferably TSV. Do not give them the original Excel workbook directly. The file should begin with:

```text
Invoice<TAB>StockCode<TAB>Description<TAB>Quantity<TAB>InvoiceDate<TAB>Price<TAB>Customer ID<TAB>Country
```

## Step 3: Run Part 1

From the repository directory, run:

```bash
bash run_pa1.sh /path/to/online_retail_ii.tsv
```

Then inspect:

```bash
cat out/freq_country.txt
cat out/freq_stockcode.txt
cat out/top20_stockcodes.txt
cat out/row_count.txt
```

Copy the important numbers and the top rows into `REPORT_DRAFT.md`.

## Step 4: Run Part 2

```bash
bash run_pa2.sh /path/to/online_retail_ii.tsv
```

Check that these files exist:

```bash
ls -l out/pa2_cleaned.tsv out/pa2_sed_normalized.tsv logs/pa2_run.log
head out/pa2_cleaned.tsv
```

The first line of `pa2_cleaned.tsv` must still be the header.

## Step 5: Check syntax

```bash
bash -n run_pa1.sh run_pa2.sh
chmod +x run_pa1.sh run_pa2.sh
```

## Step 6: Git workflow

Create a branch, commit the files, push the branch, and open a pull request. Have one teammate review it. Do not commit the full dataset or Part 2 output folders.

## Step 7: Finish the report

Replace every bracketed placeholder in `REPORT_DRAFT.md` with actual values from the generated output files. Put the report into Google Docs, enable comments, and add the repository, board, script, and PR links.

## Step 8: Update the board and submit

Use `PM_BOARD_UPDATES.md` to replace the Part 2 `Name` placeholders, update statuses and dates, and add the Definition-of-Done notes. Then submit the Google Doc, repository link, and board link on Canvas.
