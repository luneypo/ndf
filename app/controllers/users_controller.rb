class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:show]

  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @deplacements=Deplacement.where(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "User modifiée !"
      redirect_to users_path
    else
      flash[:alert] = "Une erreur est survenue!"
      render 'edit'
    end
  end

  def destroy
    @users=User.all
    @user=User.find(params[:id])
    unless current_user.id==@user.id
      @user.destroy!
      flash[:notice]= 'User supprimé.'
      redirect_to users_path
    else
      flash[:alert]= 'Vous ne pouvez pas vous supprimer.'
      redirect_to users_path
    end
  end

  def import
    User.import(params[:file])

    redirect_to users_path, notice: 'Products imported.'
  end

end

private

def user_params
  params.require(:user).permit(:nom, :email, :first_name, :login)
end
