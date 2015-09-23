defmodule StackSupervisored.Stack do
  
  use GenServer

  ### Public API
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, {:pop})
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})  
  end
  
  ### GenServer API

  def init() do
    current_state = StackSupervisored.StackState.get_state()
    {:ok, current_state}
  end
  
  def handle_call({:pop}, _from, [h|t]) do
    {:reply, h, t}
  end
  
  def handle_cast({:push, item}, current_state) do
    {:noreply, current_state ++ [item]}
  end

  def terminate(_reason, current_state) do
    StackSupervisored.StackState.save_state(current_state)
  end
  

end