# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_obelus_session',
  :secret      => 'ee3879566b4ca7fb19db817bf154068c913783379a9bf6d5e77217875d63a6ae70dbea85cd2faf1a18a08ae107ffb80022ff9539ef5916692873b1832bff8fae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
