class DeplacementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy,:index_admin]

  def index_admin
    @deplacements=Deplacement.all
  end

  def export
    if params[:commit] == 'Export PDF'
      @title='Export en pdf'
      @deplacements=Deplacement.where(id:params[:deplacement_ids])

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Export de deplacements",
                 page_size: 'A4',
                 template: "deplacements/export_pdf.html.haml",
                 layout: "pdf.html",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
          pdf= WickedPdf.new.pdf_from_string(
              render_to_string('deplacements/export_pdf.html.haml', layout: 'layouts/pdf.html.haml')
          )

          save_path = Rails.root.join('public/export_pdf',"exportpdf-#{params[:deplacement_ids].first}.pdf")
          @deplacements.each do |deplacement|
            deplacement.export="pdf/#{params[:deplacement_ids].first}"
            deplacement.filetype='pdf'
            deplacement.save
          end
          File.open(save_path, 'wb') do |file|
            file << pdf
          end
        end
      end

    elsif params[:commit] == 'Export CSV'
      @title='Export en pdf'
      @deplacements=Deplacement.where(id:params[:deplacement_ids])
      respond_to do |format|
        format.html
        format.csv { send_data @deplacements.to_csv, filename: "Export-compta-du-#{Date.today}-#{params[:deplacement_ids].first}.csv" }
      end
      save_path = Rails.root.join('public/export_csv',"Export-compta-#{params[:deplacement_ids].first}.csv")
      @deplacements.each do |deplacement|
        deplacement.export="#{params[:deplacement_ids].first}"
        deplacement.filetype='csv'
        deplacement.save
      end
      attributes = %w(date fullname credit_salarie debit_carburant debit_peage debit_parking debit_divers debit_kil TVA)
      CSV.open(save_path, 'wb') do |csv|
        csv << attributes

        @deplacements.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end

    end
  end

  def new
    @deplacement=Deplacement.new
  end

  def create
    @deplacement=Deplacement.new
    @deplacement.valider=false
    @deplacement.peage=request.parameters[:peage]
    @deplacement.parking=request.parameters[:parking]
    tauxkm=Vehicule.find(request.parameters[:deplacement].slice(:vehicule_id)[:vehicule_id]).tauxkm
    if tauxkm
      @deplacement.tauxkm=tauxkm
      @deplacement.gasoil=0
      @deplacement.nombrekm=request.parameters[:nombrekm]
    else
      @deplacement.gasoil=request.parameters[:gasoil]
      @deplacement.nombrekm=0
      @deplacement.tauxkm=0
    end
    @deplacement.user_id=current_user.id
    @deplacement.update!(deplacement_params)
    unless request.parameters[:diver].nil?
      diver=@deplacement.build_diver(request.parameters[:diver].slice(:info, :montant))
      diver.save
    end
    if @deplacement.save
      flash[:notice] = "Déplacement crée !"
    else
      flash[:alert] = "Une erreur est survenue!"
    end
    @deplacements=Deplacement.where(user_id:current_user.id)
    render 'show_my_deplacements'
  end

  def edit
    @deplacement=Deplacement.find(params[:id])
  end

  def update
    @deplacement=Deplacement.new
    @deplacement.valider=false
    @deplacement.peage=request.parameters[:peage]
    @deplacement.parking=request.parameters[:parking]
    tauxkm=Vehicule.find(request.parameters[:deplacement].slice(:vehicule_id)[:vehicule_id]).tauxkm
    if tauxkm
      @deplacement.tauxkm=tauxkm
      @deplacement.gasoil=0
      @deplacement.nombrekm=request.parameters[:nombrekm]
    else
      @deplacement.gasoil=request.parameters[:gasoil]
      @deplacement.nombrekm=0
      @deplacement.tauxkm=0
    end
    @deplacement.update!(deplacement_params)
    unless request.parameters[:diver].nil?
      diver=@deplacement.build_diver(request.parameters[:diver].slice(:info, :montant))
      diver.save
    end
    if @deplacement.save
      flash[:notice] = "Déplacement crée !"
    else
      flash[:alert] = "Une erreur est survenue!"
    end
    @deplacements=Deplacement.where(user_id:current_user.id)
    render 'show_my_deplacements'
  end

  def show_my_deplacements
    @deplacements=Deplacement.where(user_id:current_user.id)
  end

  def destroy
    @deplacements=User.all
    @deplacement=Deplacement.find(params[:id])
    @deplacement.destroy!
    flash[:notice]= 'Deplacement supprimé.'
    render 'destroy'
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
    respond_to do |f|
      f.html
      f.js
    end
  end

  def getvehicule
    unless params[:deplacement][:vehicule_id].empty?
      @tuture=Vehicule.find(params[:deplacement][:vehicule_id])
    end
    respond_to do |f|
      f.html
      f.js
    end
  end

  private

  def deplacement_params
    params.require(:deplacement).permit(:title, :tauxkm, :vehicule_id, :date, :diver_attributes=>[:id,:info,:montant])
  end

end
