class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      # seed data
      @cat = Cat.new({ title: 'Explore task manager', user_id: @user.id })
      @cat.save
      Task.create([
                    { title: 'create an account', cat_id: @cat.id, user_id: @user.id, completed: true },
                    { title: 'create a new category', cat_id: @cat.id, user_id: @user.id },
                    { title: '<-- click to change priority!', cat_id: @cat.id, user_id: @user.id, priority: 1 }
                  ])
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
