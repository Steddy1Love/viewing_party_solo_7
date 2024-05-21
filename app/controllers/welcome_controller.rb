class WelcomeController < ApplicationController
  def index
    @users = User.all
    #plaintext cookie
    # cookies[:greeting] = "Hello!"
    
    #signed cookie
    # cookies.signed[:greeting] = "Hello you dawg you!"
    
    #encrypted cookie
    # cookies.encrypted[:greeting] = { value: "hi", expires: 1.day }

    #delete a cookie
     cookies.delete :greeting
  end
end
