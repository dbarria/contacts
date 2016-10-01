class ContactsController < ApplicationController
  before_action :set_contact, only: [:show]

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

  def home

  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    # render :show, change: :contactbody, layout: false
    respond_to do |format|
      format.js {}
    end
  end

  def search
      @page = params.has_key?(:page) ? params[:page] : nil
      # @backPage = params.has_key?(:backPage)
      # @reload = params.has_key?(:reload)
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
