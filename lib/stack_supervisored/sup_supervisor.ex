defmodule StackSupervisored.SupSupervisor do
  
  use Supervisor

  def start_link() do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, [])
  end
  
  def init(_) do
    children = [worker(StackSupervisored.Stack, [])]
    supervise(children, strategy: :one_for_one)
  end

end
