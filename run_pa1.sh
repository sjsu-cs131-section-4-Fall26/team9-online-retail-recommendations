#!/usr/bin/env bash
# Usage: bash run_pa1.sh path/to/online_retail_ii.tsv
# Assumption: the input is a tab-separated text file with this header/order:
# Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer ID, Country

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: bash run_pa1.sh <INPUT_TSV>" >&2
  exit 2
fi

INPUT=$1
if [[ ! -f "$INPUT" ]]; then
  echo "Error: input file does not exist: $INPUT" >&2
  exit 1
fi
if [[ ! -r "$INPUT" ]]; then
  echo "Error: input file is not readable: $INPUT" >&2
  exit 1
fi

mkdir -p data/samples out logs
SESSION_LOG="logs/project2_part1_session.txt"

# Capture one complete execution with the required script command.
if [[ "${PA1_IN_SESSION:-0}" != "1" ]]; then
  export PA1_IN_SESSION=1
  script -q -c "bash \"$0\" \"$INPUT\"" "$SESSION_LOG"
  exit $?
fi

echo "Part 1 started: $(date -u '+%Y-%m-%dT%H:%M:%SZ')" | tee out/pa1_run.log
echo "Input: $INPUT" | tee -a out/pa1_run.log

echo "== File checks ==" | tee -a out/pa1_run.log
ls -lh "$INPUT" | tee -a out/pa1_run.log
wc -l "$INPUT" > out/row_count.txt 2> out/row_count_errors.txt
head -n 3 "$INPUT" | tee out/input_preview.tsv

echo "== Random sample with preserved header ==" | tee -a out/pa1_run.log
head -n 1 "$INPUT" > data/samples/online_retail_sample.tsv
tail -n +2 "$INPUT" | shuf -n 1000 >> data/samples/online_retail_sample.tsv
wc -l data/samples/online_retail_sample.tsv | tee out/sample_count.txt

echo "== Country frequency table ==" | tee -a out/pa1_run.log
tail -n +2 "$INPUT" | cut -f8 | sort | uniq -c | sort -nr | tee out/freq_country.txt

echo "== Stock-code frequency table ==" | tee -a out/pa1_run.log
tail -n +2 "$INPUT" | cut -f2 | sort | uniq -c | sort -nr | tee out/freq_stockcode.txt

echo "== Top 20 products by transaction-row count ==" | tee -a out/pa1_run.log
tail -n +2 "$INPUT" | cut -f2 | sort | uniq -c | sort -nr | head -n 20 | tee out/top20_stockcodes.txt

echo "== Cancellation examples using grep -i ==" | tee -a out/pa1_run.log
grep -i '^C' "$INPUT" | head -n 10 | tee out/cancellation_examples.tsv || true

echo "== Non-cancellation rows using grep -v ==" | tee -a out/pa1_run.log
grep -v '^C' "$INPUT" | head -n 10 | tee out/non_cancellation_preview.tsv || true

echo "== Required append and redirection demonstrations ==" | tee -a out/pa1_run.log
echo "Part 1 completed successfully." >> out/pa1_run.log
cut -f8 "$INPUT" > out/countries.txt 2> out/countries_errors.txt

echo "Part 1 finished: $(date -u '+%Y-%m-%dT%H:%M:%SZ')" | tee -a out/pa1_run.log
