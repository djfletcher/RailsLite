require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookies = find_and_deserialize_cookies(req)
  end

  def find_and_deserialize_cookies(req)
    cookies = req.cookies['_rails_lite_app']
    cookies.nil? ? {} : JSON.parse(cookies)
  end

  def [](key)
    @cookies[key]
  end

  def []=(key, val)
    @cookies[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app', path: '/', value: @cookies.to_json)
  end
end
