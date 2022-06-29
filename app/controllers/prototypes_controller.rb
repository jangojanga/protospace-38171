class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index,:show]

  before_action :set_prototype, only: [:edit, :show,]
 

  before_action :aa, only: [:edit, :update, :destroy]
  
  

  def index
    @prototype = Prototype.includes(:user).order("created_at DESC")
    # @prototypea = Prototype.find(params[:id])
  end

  def new
    @prototype = Prototype.new

  end

  def show 
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
   
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
      redirect_to prototype_path(@prototype.id)
   else
    render :new
   end
  end



  private
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
  params.require(:prototype).permit(:imag, :title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def aa
    @prototype = Prototype.find(params[:id])
    if current_user.id != @prototype.user.id
        redirect_to root_path
    end
  end
end
