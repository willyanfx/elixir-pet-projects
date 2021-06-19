defmodule CmdTodos do
  def create_todos do
    # number_of_tasks = IO.gets('Enter the number of todos you want to add: ')
    # {number_of_tasks, _q} = Integer.parse(number_of_tasks)
    # number_of_tasks
    {number_of_tasks, _} =
      IO.gets('Enter the number of todos you want to add: ') |> Integer.parse()

    for _ <- 1..number_of_tasks do
      IO.gets('Enter Task: ') |> String.trim()
    end
  end

  def temp_todos do
    ['apple', 'banana', 'peach']
  end

  def complete_todo(tasks, task) do
    if contains?(tasks, task) do
      List.delete(tasks, task)
    else
      :not_found_error
    end
  end

  def add_new_todo(tasks, task) do
    List.insert_at(tasks, -1, task)
  end

  def contains?(tasks, task) do
    Enum.member?(tasks, task)
  end

  def keyword_search(tasks, word) do
    for task <- tasks, String.contains?(task, word) do
      task
    end
  end

  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    task
  end

  def save(tasks, filename) do
    binary = :erlang.term_to_binary(tasks)
    File.write(filename, binary)
  end
end
