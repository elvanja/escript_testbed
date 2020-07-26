defmodule EscriptTestbed.Introspection do
  def modules_implementing_behaviour(namespace, behaviour)
      when is_atom(namespace) and is_atom(behaviour) do
    ensure_all_modules_loaded(namespace)

    namespace
    |> modules_belonging_to_namespace()
    |> Enum.filter(&(behaviour in implemented_behaviours(&1)))
  end

  def modules_belonging_to_namespace(namespace) when is_atom(namespace) do
    :code.all_available()
    |> Enum.filter(fn {name, _file, _loaded} ->
      String.starts_with?(to_string(name), "#{namespace}")
    end)
    |> Enum.map(fn {name, _, _} ->
      List.to_atom(name)
    end)
  end

  def ensure_all_modules_loaded(namespace) when is_atom(namespace) do
    namespace
    |> modules_belonging_to_namespace()
    |> :code.ensure_modules_loaded()
  end

  def implemented_behaviours(module) when is_atom(module) do
    :attributes
    |> module.module_info()
    |> Keyword.get_values(:behaviour)
    |> List.flatten()
  end
end
