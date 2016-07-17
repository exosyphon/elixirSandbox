require EEx

defmodule ServeIt do
  #EEx.function_from_file :defp, :template_show_user, "templates/show_user.eex", [:user]
  
  def init(default_opts) do
    IO.puts "starting up ServeIt..."
    default_opts
  end

 def call(conn, _opts) do
   route(conn.method, conn.path_info, conn)
 end

 def route("GET", ["hello"], conn) do
   # this route is for /hello
   conn |> Plug.Conn.send_resp(200, "Hello, world!")
 end

 def route("GET", ["users", user_id], conn) do
   # this route is for /users/<user_id>
   # page_contents = EEx.eval_file("templates/show_user.eex", [user_id: user_id])
   case ServeIt.Repo.get(User, user_id) do
     nil -> 
       conn |> Plug.Conn.send_resp(404, "User with that ID not found")
     user -> 
     #page_contents = template_show_user(user: user)
       page_contents = EEx.eval_file("templates/show_user.eex", [user: user])
       conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
    end
 end

 def route(_method, _path, conn) do
   # this route is called if no other routes match
   conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
 end
end
