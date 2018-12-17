defmodule ExCoveralls.StatServer do
  @moduledoc """
  Provide data-store for coverage stats.
  """

  def start do
    Agent.start(fn -> Map.new end, name: __MODULE__)
  end

  def stop do
    Agent.stop(__MODULE__)
  end

  def add(report) do
    Agent.update(__MODULE__, fn state ->
      Map.update(state, report.name, report, fn existing ->
        new_coverage =
          existing.coverage
          |> Enum.zip(report.coverage)
          |> Enum.map(fn
            {nil, v2} -> v2
            {v1, nil} -> v1
            {v1, v2} -> v1 + v2
          end)

        Map.replace!(existing, :coverage, new_coverage)
      end)
    end)
  end

  def get do
    Agent.get(__MODULE__, &Map.values(&1))
  end
end
