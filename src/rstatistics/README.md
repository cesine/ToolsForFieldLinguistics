# R Statistics in ToolsForFieldLinguistics

This folder contains R scripts and statistics recipes collected for field linguistics, data-heavy lab analysis, and machine learning/programming scratchpads.

## File Guide

### Functional & Testable Components
*   **`spam.r`**: Demonstrates simple spam/ham classifiers using the frequency of the word "your" and the average of capital letters. It evaluates these models against the `spam` dataset from the `kernlab` library and calculates sensitivity, specificity, PPV, NPV, and accuracy.
*   **`test/rstatistics/`**: Unit tests written using `testthat` to verify that the classifiers load and output the correct accuracy.

### Interactive/Reference Playgrounds
*   **`basics.r`**: Scratchpad history containing basic R console commands (variable assignments, vector operations, `NA` checks, etc.) generated during interactive tutorials.
*   **`applying_functions.r`**: Code snippet history detailing the use of `lapply`, `sapply`, `vapply`, and `tapply` functions.
*   **`matricies.r`**: Demonstrates creating, slicing, naming, and handling dimensions of matrices and data frames.
*   **`loading_data.r`**: Commands showing how to read CSV files, filter data using conditions, and compute summaries (e.g., handling missing data). *Note: References external local quiz datasets.*
*   **`aublog.r`**: Code for creating histograms, boxplots, density plots, and performing paired t-tests comparing articulation rates. *Note: Uses tilde-relative file paths (e.g., `~/Documents/...`) from a previous local system.*
*   **`caret.R`**: A large collection of basic syntax structures, showing loops (`for`, `while`, `repeat`), conditionals, and user-defined functions.

---

## Setup & Dependency Management

We use `renv` to maintain an isolated, reproducible R environment. All project packages (`testthat`, `kernlab`, `digest`, `crayon`, and `devtools`) are tracked in the `renv.lock` file.

### Prerequisites
Make sure R is installed on your computer. (For macOS, you can download R from the [CRAN macOS download page](https://cran.r-project.org/bin/macosx/)).

### Setup Environment
To bootstrap and install all packages in the project-local library, run:
```bash
npm run setup:r
```
*Behind the scenes, this installs the `renv` package and runs `renv::restore()` to install all required dependencies.*

### Run Tests
To run the R unit tests, use:
```bash
npm run test:r
```
*This executes `Rscript test/run_tests.R` using the packages installed in the local environment.*
