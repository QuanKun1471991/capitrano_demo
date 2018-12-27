# role-based syntax
# ==================
# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.
set :appgodip, ENV['APPGODIP']
set :appip, ENV['APPIP']
set :frontendip, ENV['FRONTENDIP']
role :app_god, %W{#{ fetch(:appgodip)}}
role :app, %W{#{ fetch(:appip)}}
role :web, %W{#{ fetch(:frontendip)}}
role :db, %W{#{ fetch(:frontendip)}}

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
server ENV['APPGODIP'], user: 'guardian', roles: %w{appgodip}
server ENV['APPIP'], user: 'guardian', roles: %w{appip}
server ENV['FRONTENDIP'], user: 'guardian', roles: %w{web db}

# Configuration
# =============
set :rails_env,       'production'
set :branch,          'master'
set :stage,           'production'
set :deploy_to,       '/opt/guardian/'
set :puma_bind,       "unix:/tmp/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{fetch(:deploy_to)}/shared/tmp/pids/puma.state"
set :puma_pid,        "#{fetch(:deploy_to)}/shared/tmp/pids/puma.pid"
set :puma_access_log, "#{fetch(:deploy_to)}/shared/log/puma.access.log"
set :puma_error_log,  "#{fetch(:deploy_to)}/shared/log/puma.error.log"
set :linked_files,    %w{config/database.yml config/secrets.yml config/newrelic.yml}