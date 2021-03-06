defmodule Discussapp.AuthController do
  use Discussapp.Web, :controller
  @moduledoc """
  This will be responsible for all user authentication
  """
  #the plug keyword is an elixir macro
  plug Ueberauth
  alias Discussapp.User

  @doc """
  Handling any information that comes from github
  """
  def callback(conn, %{"provider" => user_provider }) do
    %{assigns: %{ ueberauth_auth:
        %{credentials: user_credentials,
          info: user_info
        }}} = conn

    %{ token: user_token } = user_credentials
    %{ email: user_email, name: _user_name, nickname: user_nickname } = user_info
    # another way to do this
    # user_param = %{ token: auth.credentials.token, email: auth.info.email, provider: user_provider}

    user_params = %{ token: user_token,
                     email: user_email,
                     username: user_nickname,
                     provider: user_provider }

    # basically if user tries to signin and it is not inside db
    # user will be created. If user is already inside of the db
    # it will redirect to its account
    signin(conn, User.changeset(%User{}, user_params))

    #%Plug.Conn{adapter: {Plug.Adapters.Cowboy.Conn, :...}, assigns: %{ueberauth_auth: %Ueberauth.Auth{
    #  credentials: %Ueberauth.Auth.Credentials{expires: false, expires_at: nil, other: %{}, refresh_token: nil, scopes: ["public_repo", "user:email"], secret: nil, token: "58907eeb88274f672031fae12a5661116dc1bcf3", token_type: "Bearer"},
    #  extra: %Ueberauth.Auth.Extra{raw_info: %{token: %OAuth2.AccessToken{access_token: "58907eeb88274f672031fae12a5661116dc1bcf3", expires_at: nil, other_params: %{"scope" => "public_repo,user:email"}, refresh_token: nil, token_type: "Bearer"}, user: %{"avatar_url" => "https://avatars3.githubusercontent.com/u/30689991?v=4", "bio" => "Web and robot developer. Experience with C++/Java/JS/Python/PHP. Linux as natural environment. Japanese student rookie. Mechatronics engineering student.", "blog" => "https://eduardorasgado.github.io/", "company" => "@mediworld-healthcare", "created_at" => "2017-08-03T09:58:06Z", "email" => nil, "emails" => [%{"email" => "eduardo.rasgado@hotmail.com", "primary" => true, "verified" => true, "visibility" => "private"}, %{"email" =>
    #"30689991+eduardorasgado@users.noreply.github.com", "primary" => false, "verified" => true, "visibility" => nil}, %{"email" => "eduardo.rasgado@outlook.com", "primary" => false, "verified" => true, "visibility" => nil}], "events_url" => "https://api.github.com/users/eduardorasgado/events{/privacy}", "followers" => 18, "followers_url" => "https://api.github.com/users/eduardorasgado/followers", "following" => 27, "following_url" => "https://api.github.com/users/eduardorasgado/following{/other_user}", "gists_url" => "https://api.github.com/users/eduardorasgado/gists{/gist_id}", "gravatar_id" => "", "hireable" => true, "html_url" => "https://github.com/eduardorasgado", "id" => 30689991, "location" => "Juchit├ín de Zaragoza, Oaxaca, M├⌐xico", "login" => "eduardorasgado", "name" => "Eduardo Rasgado Ruiz", "node_id" => "MDQ6VXNlcjMwNjg5OTkx", "organizations_url" => "https://api.github.com/users/eduardorasgado/orgs", "public_gists" => 3, "public_repos" => 102, "received_events_url" => "https://api.github.com/users/eduardorasgado/received_events", "repos_url" => "https://api.github.com/users/eduardorasgado/repos", "site_admin" => false, "starred_url" => "https://api.github.com/users/eduardorasgado/starred{/owner}{/repo}", "subscriptions_url" => "https://api.github.com/users/eduardorasgado/subscriptions", "type" => "User", "updated_at" => "2020-01-31T07:58:02Z", "url" => "https://api.github.com/users/eduardorasgado"
    #}}},
    #info: %Ueberauth.Auth.Info{description: "Web and robot developer. Experience with C++/Java/JS/Python/PHP. Linux as natural environment. Japanese student rookie. Mechatronics engineering student.", email: "eduardo.rasgado@hotmail.com", first_name: nil, image: "https://avatars3.githubusercontent.com/u/30689991?v=4", last_name: nil, location: "Juchit├ín de Zaragoza, Oaxaca, M├⌐xico", name: "Eduardo Rasgado Ruiz", nickname: "eduardorasgado", phone: nil, urls: %{api_url: "https://api.github.com/users/eduardorasgado", avatar_url: "https://avatars3.githubusercontent.com/u/30689991?v=4", blog: "https://eduardorasgado.github.io/", events_url: "https://api.github.com/users/eduardorasgado/events{/privacy}", followers_url: "https://api.github.com/users/eduardorasgado/followers", following_url: "https://api.github.com/users/eduardorasgado/following{/other_user}", gists_url: "https://api.github.com/users/eduardorasgado/gists{/gist_id}", html_url: "https://github.com/eduardorasgado", organizations_url: "https://api.github.com/users/eduardorasgado/orgs", received_events_url: "https://api.github.com/users/eduardorasgado/received_events", repos_url: "https://api.github.com/users/eduardorasgado/repos", starred_url: "https://api.github.com/users/eduardorasgado/starred{/owner}{/repo}", subscriptions_url: "https://api.github.com/users/eduardorasgado/subscriptions"}}, provider: :github, strategy: Ueberauth.Strategy.Github, uid: 30689991}}, before_send: [#Function<0.101473635/1 in Plug.CSRFProtection.call/2>, #Function<4.119791330/1 in Phoenix.Controller.fetch_flash/2>, #Function<0.103699643/1 in Plug.Session.before_send/2>, #Function<1.98026429/1 in Plug.Logger.call/2>, #Function<0.31760740/1 in Phoenix.LiveReloader.before_send_inject_reloader/2>], body_params: %{}, cookies: %{"_discussapp_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYMTArSUxhRFhNOXg5a1U0Rzgva1lVUT09.JTpzQyl1Ut6HV3T9-j_Yqi-gSVZ2abiMgafp1Ckky2A"}, halted: false, host: "localhost", method: "GET", owner: #PID<0.740.0>, params: %{"code" => "95906ce8a4caad0bb0f2", "provider" => "github"}, path_info: ["auth", "github", "callback"], path_params: %{}, peer: {{127, 0, 0, 1}, 55147}, port: 4000, private: %{Discussapp.Router => {[], %{}}, :github_token => nil, :github_user => nil, :phoenix_action => :callback, :phoenix_controller => Discussapp.AuthController, :phoenix_endpoint => Discussapp.Endpoint, :phoenix_flash => %{}, :phoenix_format => "html", :phoenix_layout => {Discussapp.LayoutView,
    #:app}, :phoenix_pipelines => [:browser], :phoenix_route => #Function<7.18014083/1 in Discussapp.Router.match_route/4>, :phoenix_router => Discussapp.Router, :phoenix_view => Discussapp.AuthView, :plug_session => %{"_csrf_token" => "10+ILaDXM9x9kU4G8/kYUQ=="}, :plug_session_fetch => :done, :ueberauth_request_options => %{callback_methods: ["GET"], callback_params: nil, callback_path: "/auth/github/callback", callback_url: nil, options: [default_scope: "public_repo, user:email"], request_path: "/auth/github", strategy: Ueberauth.Strategy.Github, strategy_name: :github}}, query_params: %{"code" => "95906ce8a4caad0bb0f2"}, query_string: "code=95906ce8a4caad0bb0f2", remote_ip: {127, 0,
    #0, 1}
  end

  @doc """
  Defines all the system action when user logs out of the application
  """
  def signout(conn, _params) do
    # unset user id from session in conn assigns
    conn
    # slighly better convention than using put_session(:user_id, nil) in a security way
    # configure_session will remove any session or data
    # in case we have any other propery beside user id it will drop out of the window
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  # this function is to be able to signin our user
  # this function is used by auth controller callback function
  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      # success signin
      { :ok, user } ->
        conn
        |> put_flash(:info, "Welcome back #{user.username}!")
        # sending elements inside cockies for user browser
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      # something wrong, user fails to signin
      { :error, _reason } ->
        conn
        |> put_flash(:error, "Error singing in")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  # This function insert a user if not already exists into our app,
  # and Qif this user exists it will update the user token
  # private functions cannot be used in another modules
  defp insert_or_update_user(changeset) do
    # returns a single element looking for options
    case (Repo.get_by User, email: changeset.changes.email) do
      # if user was not found into db we will add it and then it will return a
      # { :ok, user } or { error, changeset }
      nil -> Repo.insert changeset
      # if user was found then we can signin him
      # TODO: Analize what is going on with user token when revoking from github and tries
      # to sign in
      user -> { :ok, user }
    end
  end
end
