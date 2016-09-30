class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json

  #hay que ver como reusar la lógica de search
  def index
      @page = params.has_key?(:page) ? params[:page] : nil
      @contacts = Contact.order(name: :asc).paginate(page: params[:page], per_page: 30)
      @contact = @contacts.first
      respond_to do |format|
        format.js {render 'search'}
        format.html {}
      end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    # render :show, change: :contactbody, layout: false
    respond_to do |format|
      format.js {}
      format.json { head :no_content }
      format.html {}
    end
  end

  def search
      @page = params.has_key?(:page) ? params[:page] : nil
      ap @page
      if params[:query].empty?
        @contacts = Contact.order(name: :asc).paginate(page: params[:page], per_page: 30)
        @contact = @contacts.first
      else
        @contacts = Contact.search(params)
        @contact = @contacts.first if !@contacts.empty?
      end
      respond_to do |format|
        format.js {}
        format.json { head :no_content }
        format.html { head :no_content }
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
