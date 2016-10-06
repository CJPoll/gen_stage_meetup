defmodule GenStageMeetup.Producer.Test do
  use ExUnit.Case

  alias GenStageMeetup.Producer

  setup do
    state = %{
      valid_demand: 10,
      invalid_demand: 1.0,
      valid_count: 100,
      invalid_count: 1.0
     }

    {:ok, state}
  end

  describe "init/1" do
    @tag :skip
    test "accepts a starting number" do
      Producer.init(0)
    end

    @tag :skip
    test "returns that it's a producer" do
      {:producer, _} = Producer.init(0)
    end

    @tag :skip
    test "returns the starting number" do
      {_, 1234} = Producer.init(1234)
    end

    @tag :skip
    test "only accepts integers for an argument" do
      assert_raise FunctionClauseError, fn ->
        Producer.init(1.0)
      end
    end
  end

  describe "handle_demand/2" do
    @tag :skip
    test "accepts an amount of demand", %{valid_demand: demand, valid_count: count} do
      Producer.handle_demand(demand, count)
    end

    @tag :skip
    test "accepts the current count", %{valid_demand: demand, valid_count: count} do
      Producer.handle_demand(demand, count)
    end

    @tag :skip
    test "only accepts an integer for demand", %{invalid_demand: demand, valid_count: count} do
      assert_raise FunctionClauseError, fn ->
        Producer.handle_demand(demand, count)
      end
    end

    @tag :skip
    test "only accepts an integer for current_count", %{valid_demand: demand, invalid_count: count} do
      assert_raise FunctionClauseError, fn ->
        Producer.handle_demand(demand, count)
      end
    end

    # handle_demand/2 is expected to one of the following:
    # {:noreply, [event], new_state} |
    # {:noreply, [event], new_state, :hibernate} |
    # {:stop, reason, new_state}
    # when new_state: term, reason: term, event: term

    @tag :skip
    test "returns that it's not replying", %{valid_demand: demand, valid_count: count} do
      {:noreply, _, _} = Producer.handle_demand(demand, count)
    end

    @tag :skip
    test "returns a list of events", %{valid_demand: demand, valid_count: count} do
      {_, events, _} = Producer.handle_demand(demand, count)
      assert is_list(events)
    end

    @tag :skip
    test "the length of the list of events equals demand requested", %{valid_demand: demand, valid_count: count} do
      {_, events, _} = Producer.handle_demand(demand, count)
      assert length(events) == demand
    end

    @tag :skip
    test "increments the counter", %{valid_demand: demand, valid_count: count} do
      new_count = count + demand
      {_, _, ^new_count} = Producer.handle_demand(demand, count)
    end
  end
end
