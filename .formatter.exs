root =
  if File.exists?("mix.exs") do
    "."
  else
    projects =
      "."
      |> File.ls!()
      |> Enum.filter(&File.dir?(&1))
      |> Enum.filter(&File.exists?(Path.join(&1, "mix.exs")))

    "{#{Enum.join(projects, ",")}}"
  end

[
  import_deps: [],
  inputs: [
    "*.{ex,exs}",
    "#{root}/{config,lib,test,priv}/**/*.{ex,exs}"
  ],
  line_length: 89
]
