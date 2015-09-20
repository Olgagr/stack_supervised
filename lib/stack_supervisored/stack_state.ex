defmodule StackSupervisored.StackState do
  
  use GenServer

  ### Public API

  def start_link(list) do
     IO.puts "init state"
    {:ok, _pid} = GenServer.start_link(__MODULE__, list)    
  end

  def save_state(pid, list) do
    GenServer.cast(pid, {:save_state, list})
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end
  
  ### GenServer API

  def handle_call(:get_state, _from, current_state) do
    {:reply, current_state, current_state}
  end
  
  def handle_cast({:save_state, list}, _current_state) do
    {:noreply, list}
  end

end