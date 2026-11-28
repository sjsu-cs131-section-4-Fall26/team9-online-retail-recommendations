# PM Board Updates

The Google Sheets board is the official live PM board. This file records the repository-side task assignments and Definitions of Done.

## Sprint 2

| Topic | Owner | Status | Definition of Done | Notes |
|---|---|---|---|---|
| Dataset Preparation | Kushan Mehta | Completed | Data Card completed; full TSV verified with 1,067,372 lines and 8 columns; 1,000-record sample created; full dataset kept outside Git. | Combined dataset was verified on IBM. |
| UNIX EDA | Lipi Himanshukumar Makwana | Completed | Two frequency tables, one Top-20 list, and one skinny table generated with the required UNIX pipelines. | Full-dataset outputs were verified. |
| Reproducibility | Lipi Himanshukumar Makwana | Completed | `run_pa1.sh` creates the sample, tables, skinny table, logs, session capture, and required redirection demonstrations. | Full run completed successfully. |
| Part 2 Planning | Kushan Mehta | Completed | Dataset-specific SED/AWK tickets, filenames, owners, and Definitions of Done entered. | Completed in the initial implementation. |
| Part 2 SED Cleaning | Kushan Mehta | Completed | `sed` removes CRLF and trailing-whitespace issues while preserving the header and meaningful description text. | Before/after sample generated. |
| Part 2 AWK Filtering | Lipi Himanshukumar Makwana | Completed | `awk` preserves the header and filters invalid rows using exact eight-field, nonempty-key, positive-quantity, and positive-price rules. | Validation found zero malformed or invalid cleaned rows. |
| Part 2 Entry Script | Kushan Mehta and Lipi Himanshukumar Makwana | Completed | `bash run_pa2.sh INPUT` runs end-to-end with strict mode, validation, relative paths, directory creation, and logs. | Full run produced 1,041,672 lines including the header. |
| Sprint Report | Sanjini Shukla | Completed | Google Doc includes actual findings, methods, tables, limitations, next question, stand-up summary, and required links. | Report is being finalized using full-dataset results. |
| Review and Submission | Kanishka Yadav | Completed | PRs reviewed; repository, PM board, Google Doc, scripts, and Canvas submission links verified. | Final PR review and submission remain. |

## Verified Results (Sprint 2)

- Full input: 1,067,372 lines including the header.
- Transaction records: 1,067,371.
- Part 1 sample: 1,001 lines.
- Skinny table: 1,067,372 lines.
- Part 2 cleaned output: 1,041,672 lines including the header.
- Every cleaned row contains exactly 8 fields.
- No cleaned row has a nonpositive quantity or price.

## Sprint 3 (Project Assignment 3: PySpark, Parquet, DuckDB)

| Topic | Owner | Status | Definition of Done | Notes |
|---|---|---|---|---|
| Sprint Planning | Kanishka Yadav | Completed | Audit the PA3 requirements, choose the two analysis questions, assign owners, and agree on the file layout, missing-value rules, and benchmark schema. | Deliverable: PA3 sprint plan. |
| Repository Setup | Kanishka Yadav | Completed | Create the `pa3/` folder and notebook skeleton, commit the 1,000-record sample, and update `.gitignore` so Parquet and the full dataset stay out of Git while the required CSVs are committed. | Deliverable: `pa3/` folder and `.gitignore`. |
| Data Preparation | Kanishka Yadav | Completed | Read the TSV with an explicit schema, cast columns, count cast failures and missing keys, add derived columns and quality flags, write and verify Parquet, and create the 20% development sample. | Deliverable: `out/quality_checks.csv`, `out/sample_comparison.csv`. |
| Analyses and DuckDB Comparison | Sanjini Shukla | Completed | Reproduce the PA2 stock-code frequency (Analysis 1), find the top three stock codes per country with a window (Analysis 2), compare Analysis 1 in DuckDB on every row, and record one benchmark run per tool. | Deliverable: `out/analysis_1.csv`, `out/analysis_2.csv`, `out/benchmark.csv`. |
| Project Definition | Lipi Himanshukumar Makwana | Completed | Write the project goal, two questions, row meaning, key, and important columns with data types and units in notebook Section 1. | Deliverable: Notebook Section 1. |
| README and Submission Summary | Lipi Himanshukumar Makwana | Completed | Write the PA3 README with run instructions and the handoff table, and list every submitted file in the submission summary. | Deliverable: `pa3/README.md`, `pa3/submission_summary.txt`. |
| AI-Use Disclosure | Lipi Himanshukumar Makwana | Completed | Collect each team member's AI-use disclosure for the notebook and README. | Deliverable: Notebook Section 15. |
| Chart and Findings | Kushan Mehta | Completed | Create one labeled chart and write at least two findings and one limitation, with every quoted number checked against the output CSVs. | Deliverable: Notebook Sections 13-14. |
| Technical Report | Kushan Mehta | Completed | Prepare the technical report with the goal, preparation steps, quality table, both analyses, findings, chart, limitation, and handoff table. | Deliverable: `pa3/docs/technical_report.pdf`. |
| Review and Submission | Kanishka Yadav | Completed | Run the full notebook from a clean kernel on the full data and the committed sample, review and merge PRs, and verify the Canvas submission materials. | Deliverable: Final notebook run and Canvas submission. |

## Verified Results (Sprint 3)

- Input: 1,067,371 transaction rows; Parquet round trip keeps the same row count and schema.
- Quality checks: 243,007 rows missing a customer ID, 25,700 with a null or nonpositive quantity or price, 6,885 with both (261,822 with at least one).
- 20% development sample: 213,507 rows; largest population/sample difference 0.0464 percentage points.
- Analysis 1: 5,305 stock codes; Top 20 identical to PA2.
- Analysis 2: top 3 stock codes for 43 countries (129 rows).
- PySpark vs. DuckDB: all 5,305 rows match (tolerance 0).
