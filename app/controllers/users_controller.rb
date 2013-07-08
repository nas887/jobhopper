class UsersController < ApplicationController

  before_filter :find_user, :only => [:edit, :show, :feed]
  before_filter :check_user_id, :only => [:edit]
  before_filter :logged_in?, :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Options IO"
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to(@user)
    else
      render 'edit'
      flash[:errors] = @user.errors.full_messages
    end
  end

  def show
    @skills = current_user.tags
    @tags = Tag.limit(10)
  end

  def feed
    #adding a comment so I can cherry pick
    cookies[:page_num] = 1
    # queue = JobList.find_by_user_id(current_user.id)
    @queue = []
    @applied = []
    
    list_id = current_user.list.id
    job_list = JobList.where(list_id: list_id)
    
    job_pending = job_list.where(status: "pending")
    job_pending.each {|item| @queue << Job.find(item.job_id)}
    
    job_applied = job_list.where(status: "applied")
    job_applied.each {|item| @applied << Job.find(item.job_id)}
  end

  def feed_results
    if params[:page]
      page = params[:page].to_i
    else
      page = 1
    end
    location = get_location
    @jobs = get_results(location, page)
    render :json => @jobs
  end

  private 

  def get_results(location, page)
    current_user.feed(location, page)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
