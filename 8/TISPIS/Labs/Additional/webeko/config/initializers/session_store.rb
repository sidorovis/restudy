# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_webeko_session',
  :secret      => 'af31ba083490cad14be5895ef5121c89128cf09b937f397719a21f4d819e6dea40324147f405fbebbdf12ebe385d2c3b6563bb448aa57a47d0a76a6ceb7a8221'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
