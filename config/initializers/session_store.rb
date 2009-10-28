# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mashup_session',
  :secret      => '7b9ad8735f2e5f8072a891497048a249a4978277aaeda87cca72aaceac725913c6f974c11ce201cf38917f31d4a490ac6ee738fe868056a6799b6cb34b4f7813'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
