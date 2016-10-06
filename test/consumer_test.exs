defmodule GenStageMeetup.Consumer.Test do
  use ExUnit.Case
  alias GenStageMeetup.Consumer
  import ExUnit.CaptureIO

  setup do
    state = %{
      valid_init_arg: :whatever,
      events: [2,4,6]
    }

    {:ok, state}
  end

  describe "init/1" do
    @tag :skip
    test "returns that it's a consumer", %{valid_init_arg: arg} do
      {:consumer, _} = Consumer.init(arg)
    end

    @tag :skip
    test "ignores its one arg", %{valid_init_arg: arg} do
      {_, nil} = Consumer.init(arg)
    end
  end

  describe "handle_events/1" do
    @tag :skip
    test "accepts a list of numbers, a `from`, and nil", %{events: events} do
      capture_io(fn -> 
        Consumer.handle_events(events, self(), nil)
      end)
    end

    @tag :skip
    test "returns that it's not replying", %{events: events} do
      capture_io(fn -> 
        {:noreply, _, _} = Consumer.handle_events(events, self(), nil)
      end)
    end

    @tag :skip
    test "returns the events which were passed in to it", %{events: events} do
      capture_io(fn -> 
        {_, ^events, _} = Consumer.handle_events(events, self(), nil)
      end)
    end

    @tag :skip
    test "returns nil state", %{events: events} do
      capture_io(fn -> 
        {_, _, nil} = Consumer.handle_events(events, self(), nil)
      end)
    end

    @tag :skip
    test "prints out each event to the terminal", %{events: events} do
      assert capture_io(fn ->
        Consumer.handle_events(events, self(), nil)
      end) == "2\n4\n6\n"
    end
  end
end
