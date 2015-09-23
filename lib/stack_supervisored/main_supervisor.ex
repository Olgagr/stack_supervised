defmodule StackSupervisored.MainSupervisor do
  
  use Supervisor

  def start_link(list) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, [list])
  end

  def init(list) do
    children = [
      worker(StackSupervisored.StackState, [list]),
      supervisor(StackSupervisored.SupSupervisor, [])
    ]
    supervise(children, strategy: :one_for_one)
  end

end