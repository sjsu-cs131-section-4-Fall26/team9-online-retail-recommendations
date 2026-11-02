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
| Sprint Report | Sanjini Shukla | In Progress | Google Doc includes actual findings, methods, tables, limitations, next question, stand-up summary, and required links. | Report is being finalized using full-dataset results. |
| Review and Submission | Kanishka Yadav | In Progress | PRs reviewed; repository, PM board, Google Doc, scripts, and Canvas submission links verified. | Final PR review and submission remain. |

## Verified Results

- Full input: 1,067,372 lines including the header.
- Transaction records: 1,067,371.
- Part 1 sample: 1,001 lines.
- Skinny table: 1,067,372 lines.
- Part 2 cleaned output: 1,041,672 lines including the header.
- Every cleaned row contains exactly 8 fields.
- No cleaned row has a nonpositive quantity or price.
