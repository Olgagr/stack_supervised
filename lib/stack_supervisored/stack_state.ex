defmodule StackSupervisored.StackState do
  
  use GenServer

  ### Public API

  def start_link(list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, list, name: :stack_state)
  end

  def save_state(list) do
    GenServer.cast(self, {:save_state, list})
  end

  def get_state() do
    GenServer.call(self, :get_state)
  end
  
  ### GenServer API

  def handle_call(:get_state, _from, current_state) do
    {:reply, current_state, current_state}
  end
  
  def handle_cast({:save_state, list}, _current_state) do
    {:noreply, list}
  end

end