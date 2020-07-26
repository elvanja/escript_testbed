# Escript Testbed

## What does it do?

In short, it complements the related [Elixir forum question](https://elixirforum.com/t/load-all-modules-implementing-a-behaviour-in-escript/33348?u=elvanja).

The aim is to create an escript that is able to:
- list all sync scenarios available in the app
- execute a given scenario
- when adding new scenarios, it should be able to detect them without adding code to `EscriptTestbed.CLI`

## Usage

```
➜ mix escript_testbed list
Available scenarios:
- data_set_a
- data_set_b
```

```
➜ ./escript_testbed list
Available scenarios:
- data_set_a
- data_set_b
```
