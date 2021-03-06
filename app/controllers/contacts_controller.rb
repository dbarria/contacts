class ContactsController < ApplicationController
  before_action :set_contact, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  # GET /contacts
  # GET /contacts.json

  def index
      @page = params.has_key?(:page) ? params[:page] : nil
      @contacts = Contact.order(name: :asc).paginate(page: params[:page])
      @contact = @contacts.first
      respond_to do |format|
        format.js {}
      end
  end

  #Acción que carga el contenedor para la SPA
  def home

  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    # render :show, change: :contactbody, layout: false
    ap @contact
    respond_to do |format|
      format.js {}
    end
  end

  def search
      @page = params.has_key?(:page) ? params[:page] : nil
      #Si no existe query se muestran todos los resultados
      if params[:query].empty?
        @contacts = Contact.order(name: :asc).paginate(page: params[:page])
        @contact = @contacts.first
      else
        @contacts = Contact.search(params)
        @contact = @contacts.first if !@contacts.empty?
      end
      respond_to do |format|
        format.js {}
      end
  end

  protected
  def not_found_error
    respond_to do |format|
      format.js {render 'not_found_error'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :line1, :line2, :city, :state, :zip, :phone)
    end
end
