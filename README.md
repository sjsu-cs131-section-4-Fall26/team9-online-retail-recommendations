# Team 9 - Online Retail II

This repository contains the UNIX exploration and SED/AWK cleaning pipelines for CS 131 Project Assignment 2 and the PySpark, Parquet, and DuckDB notebook for Project Assignment 3, using the UCI Online Retail II dataset.

## Repository Structure

```text
.
├── README.md
├── run_pa1.sh                     # PA2 Part 1: UNIX exploration
├── run_pa2.sh                     # PA2 Part 2: SED/AWK cleaning
├── data/
│   ├── README.md
│   └── samples/online_retail_sample.tsv     # 1,000-record sample (PA2)
├── reports/                       # Data card, PA2 report, PM updates, guides, checklist
└── pa3/
    ├── README.md                  # PA3 run instructions, handoff table, AI-use disclosure
    ├── submission_summary.txt     # List of every submitted PA3 file
    ├── requirements.txt           # Python packages for the PA3 notebook
    ├── notebooks/pa3_pyspark.ipynb
    ├── data/sample/online_retail_sample.tsv # 1,000-record sample for PA3 test runs
    ├── docs/technical_report.pdf  # PA3 technical report
    └── out/                       # PA3 result CSVs
```

Generated folders that are not committed: `out/` and `logs/` (PA2 scripts), `pa3/data/parquet/`,
`pa3/data/dev_sample_20pct/`, `pa3/logs/`, and `.venv/`.

## Dataset

The full dataset is not committed to Git. It must be stored outside the repository or in an ignored directory.

The PA2 scripts and the PA3 notebook expect one combined TSV file created from both Online Retail II workbook sheets with:

- 1,067,372 lines including the header
- 1,067,371 transaction records
- 8 tab-separated columns

The header order must be:

```text
Invoice<TAB>StockCode<TAB>Description<TAB>Quantity<TAB>InvoiceDate<TAB>Price<TAB>Customer ID<TAB>Country
```

Dataset source: [UCI Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii)

See the [Data Card](reports/DATA_CARD.md) and [Start Here guide](reports/START_HERE.md) for dataset and execution instructions.

## Project Assignment 2

### Part 1

Run:

```bash
bash run_pa1.sh /path/to/online_retail_II_combined.tsv
```

Run Part 1 on Linux (for example, the IBM server). It uses the GNU versions of `script -c` and `shuf`, which
macOS does not provide. Part 2 runs on both Linux and macOS.

Each run draws a new random 1,000-record sample and overwrites the committed
`data/samples/online_retail_sample.tsv`. To keep the committed sample, restore it after running Part 1:

```bash
git checkout -- data/samples/online_retail_sample.tsv
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

### Part 2

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

## Project Assignment 3 (PySpark, Parquet, DuckDB)

The PA3 notebook is [`pa3/notebooks/pa3_pyspark.ipynb`](pa3/notebooks/pa3_pyspark.ipynb). It reads the combined TSV
with PySpark, writes prepared Parquet, runs two analyses, checks Analysis 1 against DuckDB, and benchmarks both engines.

### Requirements

- Python 3.12
- Java 17 or 21 (Spark 4 does not support newer Java versions)
- The packages in [`pa3/requirements.txt`](pa3/requirements.txt): PySpark, DuckDB, pandas (below 3.0), PyArrow,
  Matplotlib, ipykernel, and Jupyter Notebook

### Setup

From the repository root, create a virtual environment and register it as a Jupyter kernel:

```bash
uv venv -p 3.12 .venv                      # or: python3.12 -m venv .venv
uv pip install -r pa3/requirements.txt     # or: .venv/bin/pip install -r pa3/requirements.txt
.venv/bin/python -m ipykernel install --user --name pa3-pyspark --display-name "PA3 (PySpark)"
```

`.venv/` is gitignored.

### Run

```bash
export JAVA_HOME=<path to a Java 17 or 21 JDK>      # macOS: export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PA3_DATA_PATH=/absolute/path/to/online_retail_II_combined.tsv   # optional, see below
cd pa3/notebooks
jupyter notebook pa3_pyspark.ipynb
```

In Jupyter, choose the **PA3 (PySpark)** kernel, then **Kernel > Restart & Run All**.

The notebook uses the first input it finds:

1. `PA3_DATA_PATH`, if set (use an absolute path).
2. `online_retail_II_combined.tsv` next to the repository folder, or in a `data/` folder next to it.
3. The committed 1,000-row sample, `pa3/data/sample/online_retail_sample.tsv`. A sample run writes to
   `pa3/out/sample_run/` so it never overwrites the full-data outputs.

### Run on the committed sample

Without the full dataset, the notebook falls back to the committed sample automatically. If the full TSV is in one
of the default locations, point `PA3_DATA_PATH` at the sample to force a sample run:

```bash
cd pa3/notebooks
export PA3_DATA_PATH="$PWD/../data/sample/online_retail_sample.tsv"
```

A sample run reads 1,000 rows and runs every check except the ones that only apply to the full data (the PA2
Top 20 comparison and the Bermuda hand check). Its outputs go to `pa3/out/sample_run/`, which is gitignored.

### Run without opening Jupyter

To run the whole notebook from a terminal and save the outputs into it (from `pa3/notebooks/`):

```bash
jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.kernel_name=pa3-pyspark pa3_pyspark.ipynb
```

### Outputs

Full-data results are written to `pa3/out/` and committed:

```text
pa3/out/quality_checks.csv
pa3/out/sample_comparison.csv
pa3/out/analysis_1.csv
pa3/out/analysis_2.csv
pa3/out/benchmark.csv
```

The Parquet files (`pa3/data/parquet/`, `pa3/data/dev_sample_20pct/`) and Spark's Java log
(`pa3/logs/spark_jvm.log`) are generated locally and gitignored. The 20% development sample depends on the number
of CPU cores, so its row count can differ slightly between machines; every other result is the same on any machine.

## Repository and Git Hygiene

- The full dataset is excluded from Git.
- PA3 Parquet files, Spark logs, and the `.venv/` environment are excluded from Git; only the five PA3 result CSVs in `pa3/out/` are committed.
- Generated `out/` and `logs/` directories are excluded from Git.
- The required 1,000-record sample is committed under `data/samples/` (PA2) and `pa3/data/sample/` (PA3).
- `.gitattributes` keeps every text file in LF line endings, so the shell scripts and TSV files work the same on
  macOS, Linux, and Windows checkouts.
- Changes are developed on feature branches.
- Pull requests require peer review before merging.

## Project Documentation

- [Data Card](reports/DATA_CARD.md)
- [Project Assignment 2 Report](reports/PROJECT_ASSIGNMENT_2_REPORT.md)
- [PM Board Updates](reports/PM_BOARD_UPDATES.md)
- [Start Here Guide](reports/START_HERE.md)
- [Submission Checklist](reports/SUBMISSION_CHECKLIST.md)
- [PA3 README](pa3/README.md)
- [PA3 Technical Report](pa3/docs/technical_report.pdf)
- [PA3 Submission Summary](pa3/submission_summary.txt)

## Team

- Kushan Mehta
- Kanishka Yadav
- Sanjini Shukla
- Lipi Himanshukumar Makwana
