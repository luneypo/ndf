class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:show]
  before_action :load_all_users

  def show
    respond_to do |format|
      format.html {render 'index'}
      format.json
    end
  end
  def new
    @user=User.new
  end

  def create
    @user.create!(user_params)
    if @user.save
      flash[:notice] = "User modifiée !"
      render 'create'
    else
      flash[:alert] = "Une erreur est survenue!"
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "User modifiée !"
    else
      flash[:alert] = "Une erreur est survenue!"
    end
  end

  def destroy
    @user=User.find(params[:id])
    unless current_user.id==@user.id
      @user.destroy!
      flash[:notice]= 'User supprimé.'
      render 'destroy'
    else
      flash[:alert]= 'Vous ne pouvez pas vous supprimer.'
      redirect_to users_path
    end
  end

  def import
    User.import(params[:file])

    redirect_to users_path, notice: 'Products imported.'
  end

  def json
    @user=User.find_by login:params[:login]
    render json: @user.as_json(except: [:id, :created_at, :age, :updated_at, :temp])
  end
end

private

def load_all_users
  @users=User.all
end

def user_params
  params.require(:user).permit(:name, :email, :first_name, :login)
end
