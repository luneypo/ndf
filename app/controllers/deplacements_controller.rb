class DeplacementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy,:index]

  def index
    @deplacements=Deplacement.all
  end

  def export
    if params[:commit] == 'Export PDF'
      @title='Export en pdf'
      @deplacements=Deplacement.where(id:params[:deplacement_ids])

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Export de deplacmeents",
                 page_size: 'A4',
                 template: "deplacements/export_pdf.html.haml",
                 layout: "pdf.html",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end

    elsif params[:commit] == 'Export CSV'
      @title='Export en pdf'
      @deplacements=Deplacement.where(id:params[:deplacement_ids])
      respond_to do |format|
        format.html
        format.csv { send_data @deplacements.to_csv, filename: "Export-compta-du-#{Date.today}.csv" }
      end
    end
  end

  def new
    @deplacement=Deplacement.new
  end

  def create
    @deplacement=Deplacement.create(deplacement_params)
    @deplacement.valider=false
    if Vehicule.find(@deplacement.vehicule_id).tauxkm?
      @deplacement.tauxkm=Vehicule.find(@deplacement.vehicule_id).tauxkm
      @deplacement.gasoil=0
    else
      @deplacement.nombrekm=0
      @deplacement.tauxkm=0
    end
    if @deplacement.save
      flash[:notice] = "Déplacement crée !"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Une erreur est survenue!"
      render 'new'
    end
  end

  def edit
    @deplacement=Deplacement.find(params[:id])
  end

  def update
    @deplacement=Deplacement.find(params[:id])
    @deplacement.update(deplacement_params)
    if Vehicule.find(@deplacement.vehicule_id).tauxkm?
      @deplacement.tauxkm=Vehicule.find(@deplacement.vehicule_id).tauxkm
      @deplacement.gasoil=0
    else
      @deplacement.nombrekm=0
      @deplacement.tauxkm=0
    end
    if @deplacement.save
      flash[:notice] = "Déplacement modifiée !"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Une erreur est survenue!"
      render 'edit'
    end
  end

  def destroy
    @deplacements=User.all
    @deplacement=Deplacement.find(params[:id])
    @deplacement.destroy!
    flash[:notice]= 'Deplacement supprimé.'
    redirect_back(fallback_location: deplacements_path)
  end

  def valider
    @deplacement=Deplacement.find(params[:id])
    @deplacement.valider=true
    @deplacement.save
    flash[:notice]= 'Deplacement Validé.'
    redirect_back(fallback_location: deplacements_path)
  end

  def fraisdivers
    @deplacement=Deplacement.new
    @deplacement.build_diver
    render 'new'
  end

  private

  def deplacement_params
    params.require(:deplacement).permit(:title, :tauxkm , :nombrekm , :gasoil, :peage , :parking, :divers , :infos, :vehicule_id, :date ,:user_id,:diver_attributes=>[:id,:info,:montant])
  end

end
