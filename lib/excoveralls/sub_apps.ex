defmodule ExCoveralls.SubApps do
  @moduledoc """
  Handles information of sub apps of umbrella projects.
  """

  def find(sub_apps, compile_path) do
    Enum.find(sub_apps, {nil, nil}, fn({_sub_app, path}) ->
      String.starts_with?(compile_path, path)
    end)
  end

  def parse(deps) do
    deps
    |> Enum.map(&({&1.app, %{relpath: &1.opts[:path], abspath: &1.opts[:dest]}}))
    |> Enum.sort(fn ({_app1, config1}, {_app2, config2}) ->
      # sort the longest paths first to avoid matching a path that contains another
      # example "./apps/myapp_server" would contain path "./apps/myapp"
      String.length(config1.relpath) > String.length(config2.relpath)
    end)
  end
end
