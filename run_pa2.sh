#!/usr/bin/env bash
# Usage: bash run_pa2.sh path/to/online_retail_ii.tsv
# Assumption: input is tab-separated with the Online Retail II columns:
# Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer ID, Country

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: bash run_pa2.sh <INPUT_TSV>" >&2
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

mkdir -p out logs
LOG="logs/pa2_run.log"
SED_FILE="out/pa2_sed_normalized.tsv"
CLEAN_FILE="out/pa2_cleaned.tsv"
SAMPLE_FILE="out/pa2_before_after_sample.txt"

{
  echo "Part 2 started: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Input: $INPUT"
  echo "Creating relative output directories: out logs"

  # SED stage: remove CRLF artifacts and trailing whitespace without
  # destroying spaces inside product descriptions.
  sed -E 's/\r$//; s/[[:space:]]+$//' "$INPUT" > "$SED_FILE"

  {
    echo "===== BEFORE SAMPLE ====="
    head -n 5 "$INPUT"
    echo "===== AFTER SED SAMPLE ====="
    head -n 5 "$SED_FILE"
  } > "$SAMPLE_FILE"

  # AWK stage: preserve the header and retain usable purchase rows.
  # Rules: nonempty invoice/stock code, positive integer quantity, positive price.
  awk -F '\t' -v OFS='\t' '
    NR == 1 { print; next }
    NF >= 8 &&
    $1 != "" &&
    $2 != "" &&
    $4 ~ /^[0-9]+$/ && $4 > 0 &&
    $6 ~ /^[0-9]+([.][0-9]+)?$/ && $6 > 0 {
      print
    }
  ' "$SED_FILE" > "$CLEAN_FILE"

  echo "Input rows including header: $(wc -l < "$INPUT")"
  echo "Rows after SED: $(wc -l < "$SED_FILE")"
  echo "Rows after AWK filtering: $(wc -l < "$CLEAN_FILE")"
  echo "Part 2 completed: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
} 2> "$LOG" | tee -a "$LOG"
