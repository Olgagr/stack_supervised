defmodule StackSupervisored.Stack do
  
  use GenServer

  ### Public API
  def start_link(state_pid) do
    GenServer.start_link(__MODULE__, state_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, {:pop})
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})  
  end
  
  ### GenServer API

  def init(state_pid) do
    current_state = StackSupervisored.StackState.get_state(state_pid)
    {:ok, {current_state, state_pid}}
  end
  
  def handle_call({:pop}, _from, {current_state, state_pid}) do
    {:reply, {current_state, state_pid}}
  end
  
  def handle_cast({:push, item}, {current_state, state_pid}) do
    {:noreply, {current_state ++ [item], state_pid}}
  end

  def terminate(_reason, {current_state, state_pid}) do
    StackSupervisored.StackState.save_state(state_pid, current_state)
  end
  

end