defmodule StackSupervisored.MainSupervisor do
  
  use Supervisor

  def start_link(list) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [list])
    start_workers(sup, list)
    result
  end

  def start_workers(sup, list) do
    {:ok, state_pid} = Supervisor.start_child(sup, worker(StackSupervisored.StackState, [list]))
    Supervisor.start_child(sup, supervisor(StackSupervisored.SupSupervisor, [state_pid]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end

end