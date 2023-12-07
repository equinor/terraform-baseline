# Module library script

This directory contains a Python script `module-library.py` that will automatically generate a Markdown table containing all ETB modules.

## Prerequisites

- [Install Python](https://www.python.org/downloads/)

## Arguments

- `-t`, `--template`: path of file to use as Markdown template (see [template specification](#template-specification))
- `-o`, `--output`: path of file to store output in

## Usage

Run script:

```console
./module-library.py
```

Run script with specified Markdown template and output file:

```console
./module-library.py -t template.md -o output.md
```

## Template specification

The Markdown template file must contain a placeholder `{table}` where the module library table will be inserted.

For example:

```markdown
# Module library

{table}
```
