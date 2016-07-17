ServeIt
=======

iex -S mix
ServeIt.Repo.start_link
{:ok, _} = Plug.Adapters.Cowboy.http ServeIt, []
