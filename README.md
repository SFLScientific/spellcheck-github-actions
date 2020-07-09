# spellcheck-github-actions

## Forked from https://github.com/UnicornGlobal/spellcheck-github-actions 

## Changes: the spellcheck.yaml and wordlist.txt can be anywhere in the repo (including the .github folder for cleaner repos)

A Github Action that spell checks JavaScript, Vue, Markdown, HTML, and Text files.

This action uses [PySpelling](https://facelessuser.github.io/pyspelling/) to
check source files in the project.  

## Configuration

If your repo contains `spellcheck.yaml` it will be used instead of the default config.

See https://facelessuser.github.io/pyspelling/configuration/ for options.

Note it must be `.yaml` not `.yml`

## Upstream

Based on `rojopolis/spellcheck-github-actions`

That repo is python centric and was not working for us so we made this fork

## Wordlists

You can place a wordlist.txt file in the root of your project.

This will override the default list.

## Example Config

This is the default config

```yaml
# spellcheck.yaml
matrix:
- name: JavaScript
  sources:
  - '**/*.js'
  expect_match: false
  aspell:
    lang: en
  dictionary:
    wordlists:
    - wordlist.txt
    output: wordlist.dic
    encoding: utf-8
  pipeline:
  - pyspelling.filters.javascript:
      jsdocs: true
      line_comments: true
      block_comments: true
      group_comments: false
      decode_escapes: true
      strings: false
- name: Vue
  sources:
  - '**/*.vue'
  expect_match: false
  aspell:
    lang: en
  dictionary:
    wordlists:
    - wordlist.txt
    output: wordlist.dic
    encoding: utf-8
  pipeline:
  - pyspelling.filters.javascript:
      jsdocs: true
      line_comments: true
      block_comments: true
      group_comments: false
      decode_escapes: true
      strings: false
  - pyspelling.filters.html:
      comments: true
      attributes:
      - title
      - alt
      ignores:
      - ':matches(code, pre)'
      - 'code'
      - 'pre'
  - pyspelling.filters.stylesheets:
      group_comments: true
- name: HTML
  sources:
  - '**/*.html'
  expect_match: false
  apsell:
    mode: en
  dictionary:
    wordlists:
    - wordlist.txt
    output: wordlist.dic
    encoding: utf-8
  pipeline:
  - pyspelling.filters.html:
      comments: true
      attributes:
      - title
      - alt
      ignores:
      - ':matches(code, pre)'
      - 'code'
      - 'pre'
- name: Markdown
  expect_match: false
  apsell:
    mode: en
  dictionary:
    wordlists:
    - wordlist.txt
    output: wordlist.dic
    encoding: utf-8
  pipeline:
  - pyspelling.filters.markdown:
      markdown_extensions:
      - markdown.extensions.extra:
  - pyspelling.filters.html:
      comments: true
      attributes:
      - title
      - alt
      ignores:
      - ':matches(code, pre)'
      - 'code'
      - 'pre'
  sources:
  - '**/*.md'
- name: Text
  sources:
  - '**/*.txt|!wordlist.txt'
  ignores:
  expect_match: false
  dictionary:
    wordlists:
    - wordlist.txt
    output: wordlist.dic
    encoding: utf-8
  pipeline:
  - pyspelling.filters.text:
      convert_encoding: utf-8
```

## Example GitHub Action

```yaml
# .github/workflows/check_spelling.yml
name: Check Spelling
on:
  pull_request:
    paths:
    - '**.js'
    - '**.vue'
    - '**.txt'
    - '**.html'
    - '**.md'
jobs:
  spelling:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        ref: ${{ github.head_ref }}
    - name: Check Spelling
      uses: UnicornGlobal/spellcheck-github-actions@master
```
