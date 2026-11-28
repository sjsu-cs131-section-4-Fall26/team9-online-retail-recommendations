# PA3 - PySpark, Parquet, and DuckDB (Team 9)

Dataset: UCI Online Retail II (both workbook sheets combined into one TSV, 1,067,371 rows).
One row = one invoice line (one product on one invoice). The data has no natural key.

Team: Kanishka Yadav, Sanjini Shukla, Lipi Himanshukumar Makwana, Kushan Mehta.

## Folder contents

```
pa3/
  README.md
  submission_summary.txt
  requirements.txt
  notebooks/pa3_pyspark.ipynb      main notebook (Sections 0-15)
  data/sample/online_retail_sample.tsv   committed 1,000-row sample
  docs/technical_report.pdf        report with chart, findings, limitation, handoff table
  out/analysis_1.csv               Analysis 1 (stock-code frequency, full data)
  out/analysis_2.csv               Analysis 2 (top 3 stock codes per country, full data)
  out/quality_checks.csv           data-quality checks
  out/sample_comparison.csv        20% development sample vs. population
  out/benchmark.csv                PySpark vs. DuckDB timing for Analysis 1
```

## How to run the notebook from the committed sample

Requirements: Python 3.12, Java 17 or 21 (needed by Spark), and the packages in `requirements.txt`.
The notebook was developed with Spark 4.3.0, DuckDB 2.0.1, and Python 3.12.

1. Install the packages:

   ```
   pip install -r pa3/requirements.txt
   ```

2. Start Jupyter and open `pa3/notebooks/pa3_pyspark.ipynb` with the **PA3 (PySpark)** kernel.
   The notebook must be run from `pa3/notebooks/`, because its paths are relative to that folder.
3. Run all cells from the top.

The notebook looks for its input in this order (Section 0a):

1. The file named in the `PA3_DATA_PATH` environment variable (use this for the full TSV).
2. The full combined TSV in a default location outside the repository.
3. The committed sample, `pa3/data/sample/online_retail_sample.tsv` (1,000 rows).

If the full TSV is not found, the notebook uses the committed sample automatically.
To use the full file instead, set the variable before starting Jupyter:

```
export PA3_DATA_PATH="$HOME/online_retail_II_combined.tsv"
```

### Sample run vs. full-data run

- A **sample run** writes its files to `pa3/out/sample_run/` and `pa3/data/parquet/sample_run/`
  (both gitignored), so it never overwrites the committed results in `pa3/out/`.
- A sample run produces different counts from the full data. The checks that compare against
  PA2's full-data results (the Top 20 and the Bermuda hand check) are skipped on the sample.
- The CSV files committed in `pa3/out/` and the numbers in the report come from a **full-data
  run** (1,067,371 rows, Spark in `local[*]` mode on one machine with 10 cores).
- Section 8 uses `prepared.sample(withReplacement=False, fraction=0.20, seed=131)`. Spark samples
  each partition separately, so the exact sample size depends on the number of cores.
- The Parquet folder, the development sample, and the Spark log are generated locally and are
  not committed.

## Rules used in the analyses

- No rows are removed. Quality problems are flagged, not deleted (Section 5).
- `stock_code` is not trimmed or re-cased, matching PA2.
- Analysis 1 counts every row, including cancellations and rows without a customer ID, as PA2 did.
- Ties are broken by `stock_code` ascending, in both analyses.
- Analysis 2 uses a window function (`row_number()` partitioned by country) to keep ranks 1-3.
- PySpark and DuckDB are compared on all 5,305 result rows with a tolerance of 0 (counts are integers).
- The benchmark is one run per tool on one machine. It does not show multi-machine scalability.

## Outputs (handoff)

| Output | One row means | Columns | Rows | Notebook section |
|---|---|---|---|---|
| Prepared Parquet (not committed) | One invoice line | invoice, stock_code, description, quantity, invoice_date, price, customer_id, country, revenue, is_cancellation, flag_missing_customer, flag_bad_qty_price | 1,067,371 | 6 |
| `out/analysis_1.csv` | One stock code | stock_code, count | 5,305 | 9 |
| `out/analysis_2.csv` | One country and one of its top 3 stock codes | country, stock_code, count, rank | 129 | 10 |
| `out/quality_checks.csv` | One quality check | check_id, check_name, rule, rows_affected, pct_of_rows, action, overlap_note | 10 | 5a |
| `out/sample_comparison.csv` | One group (country or flag value) | fraction, seed, group_column, group_value, population_rows, sample_rows, population_pct, sample_pct, pct_point_diff, in_sample | 47 | 8 |
| `out/benchmark.csv` | One tool run | implementation, environment, input_rows, input_bytes, format, elapsed_seconds, output_rows, result_verified | 2 | 12 |

To regenerate any output, run the notebook and see the section listed above.

## AI-use disclosure

- **Kanishka Yadav:** Used Claude to understand the PA3 requirements and how the PySpark, Parquet,
  and DuckDB steps fit together, and to check that the notebook's code, explanations, and outputs
  are consistent. Reviewed all of it, ran the notebook on the full dataset, and confirmed the
  results against PA2.
- **Sanjini Shukla:** Used Codex to understand what Sections 9-12 required and how grouped
  aggregations, window functions, and DuckDB queries work in this project. Reviewed and ran the
  code and checked the outputs.
- **Lipi Himanshukumar Makwana:** Used ChatGPT to structure and edit initial drafts of Section 1
  (project goal, analysis questions, and schema description) and to check that they matched the
  assignment rubric.
- **Kushan Mehta:** Used Claude only for minor code formatting in Section 13 and phrasing polish in
  Section 14 and the technical report. Manually verified all numerical results against
  analysis_1.csv, analysis_2.csv, and quality_checks.csv.

Every team member should be able to explain the submitted work.
