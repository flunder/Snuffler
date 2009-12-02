# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_grabber_session',
  :secret      => '70c677b9c7e93ca500d941b89fb777596549fad21604667d6aecc8d38ecc8aa294ed7caf34a10f62103c4496ab9274814acbd0d7c25d3151c7c89dfc880a2845'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
