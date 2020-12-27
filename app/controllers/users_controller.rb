class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      seed
      render json: { user: @user, token: token }
    elsif @user.errors.any?
      @user.errors.each do |_attribute, message|
        render json: { error: message.to_s }
      end
    else
      render json: { error: 'An error occurred. Try again later' }
    end
  end

  def seed
    # seed data
    @cat = Cat.new({ title: 'Explore task manager', user_id: @user.id })
    @cat.save
    Task.create([
                  { title: 'create an account', cat_id: @cat.id, user_id: @user.id, completed: true },
                  { title: 'create a new category', cat_id: @cat.id, user_id: @user.id },
                  { title: '<-- click to change priority!', cat_id: @cat.id, user_id: @user.id, priority: 1 }
                ])
    @tag = Tag.new({ title: 'important', user_id: @user.id })
    @tag.save
    ItemsTag.create([{ tag_id: @tag.id, cat_id: @cat.id, user_id: @user.id }])
    @cat = Cat.new({ title: 'CVWO assignment', user_id: @user.id })
    @cat.save
    Task.create([
                  { title: 'mid assignment submission', cat_id: @cat.id, user_id: @user.id, completed: true },
                  { title: 'final submission', cat_id: @cat.id, user_id: @user.id, priority: 2 }
                ])
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
