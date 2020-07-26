deps: mix.lock mix.exs
	mix deps.get

setup: deps

console: deps
	iex -S mix

test:
	mix test

docs:
	mix docs

escript:
	echo "Compiling with warnings..."
	mix do compile --warnings-as-errors || exit 1
	echo "Build escript..."
	MIX_ENV=prod mix escript.build

ci:
	echo "Running formatter..."
	mix format --check-formatted || exit 1
	echo "Compiling with warnings..."
	mix do compile --warnings-as-errors || exit 1
	echo "Running credo..."
	mix credo --strict || exit 1
