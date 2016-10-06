defmodule GenStageMeetup.ProducerConsumer.Test do
  use ExUnit.Case
  alias GenStageMeetup.ProducerConsumer

  setup do
    state = %{
      valid_multiplier: 2,
      invalid_multiplier: 2.0,
      valid_events: [1,2,3],
      invalid_events: 1
    }
    {:ok, state}
  end

  describe "init/1" do
    @tag :skip
    test "accepts a multiplier", %{valid_multiplier: mult} do
      ProducerConsumer.init(mult)
    end

    @tag :skip
    test "accepts only an integer multiplier", %{invalid_multiplier: mult} do
      assert_raise FunctionClauseError, fn ->
        ProducerConsumer.init(mult)
      end
    end

    @tag :skip
    test "returns that it's a producer/consumer", %{valid_multiplier: mult} do
      {:producer_consumer, _} = ProducerConsumer.init(mult)
    end

    @tag :skip
    test "returns the multiplier for future calculation", %{valid_multiplier: mult} do
      {_, ^mult} = ProducerConsumer.init(mult)
    end
  end

  describe "handle_events/3" do
    @tag :skip
    test "accepts a list of numbers, a `from`, and a multiplier",
    %{valid_events: events, valid_multiplier: mult} do
      ProducerConsumer.handle_events(events, self(), mult)
    end

    @tag :skip
    test "accepts only a list of events", %{invalid_events: events, valid_multiplier: mult} do
      assert_raise FunctionClauseError, fn ->
        ProducerConsumer.handle_events(events, self(), mult)
      end
    end

    @tag :skip
    test "accepts only an integer for a multiplier", %{valid_events: events, invalid_multiplier: mult} do
      assert_raise FunctionClauseError, fn ->
        ProducerConsumer.handle_events(events, self(), mult)
      end
    end

    @tag :skip
    test "returns that the stage is not replying", %{valid_events: events, valid_multiplier: mult} do
      {:noreply, _, _} = ProducerConsumer.handle_events(events, self(), mult)
    end

    @tag :skip
    test "returns the multiplied events", %{valid_events: events, valid_multiplier: mult} do
      {_, [2,4,6], _} = ProducerConsumer.handle_events(events, self(), mult)
    end

    @tag :skip
    test "returns the multiplier for future calculation", %{valid_multiplier: mult, valid_events: events} do
      {_, _, ^mult} = ProducerConsumer.handle_events(events, self(), mult)
    end
  end
end
