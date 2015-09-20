defmodule StackSupervisored.SupSupervisor do
  
  use Supervisor

  def start_link(state_pid) do
    IO.puts "start supsupervisor"
    {:ok, _pid} = Supervisor.start_link(__MODULE__, state_pid)
  end
  
  def init(state_pid) do
    children = [worker(StackSupervisored.Stack, [state_pid])]
    supervise(children, strategy: :one_for_one)
  end

end
