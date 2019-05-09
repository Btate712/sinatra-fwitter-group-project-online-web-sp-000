class UsersController < ApplicationController

  get '/users/:user_slug' do
    @user = User.find { |user| user.slug == params[:user_slug] }

    erb :'users/show'
  end


end
