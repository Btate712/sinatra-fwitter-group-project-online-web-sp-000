class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user

      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(:content => params[:content])
      current_user.tweets << tweet
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect 'tweets/new'
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(tweet)
      tweet.destroy
    end
    redirect '/tweets'
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      tweet = Tweet.find(params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end
end
