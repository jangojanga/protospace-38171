class PrototypesController < ApplicationController
  # before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, ]

  def index
    @prototype = Prototype.includes(:user).order("created_at DESC")
    # @prototypea = Prototype.find(params[:id])
  end

  def new
    @prototype = Prototype.new

  end

  def show 
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
   else
    render :new
   end
  end

  def update

    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to root_path
   else
    render :new
   end
  end



  private
  def prototype_params
  params.require(:prototype).permit(:imag, :title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
