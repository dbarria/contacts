class Contact < ApplicationRecord
  before_save do
    self.phone_number = self.phone.tr("()-. ", "")
    self.zip_number = self.zip.tr("()-. ", "")
  end
  self.per_page = 30

  #Método para realizar una búsqueda FullText en los campos name, line1, line2, city, state, zip_number, phone_number. MySQL no soporta busqueda de palabras parciales hacia atrás, solo hacia adelante =(
  def self.search(params)
    tokens = Array.new
    query = params[:query]
    ap query

    #Se extraen los numeros con ()-.\s
    #Para posteriormente buscar en los campos númericos
    #Fulltext search de mysql es mañoso con los caracteres especiales
    regexNumber = /([\(\)\.\-\s]*\d+[\(\)\.\-\s]*)+/
    matchNumber = query.match(regexNumber)
    if matchNumber
      number = matchNumber[0]
      query.slice!(number)
      number = number.tr("()-. ", "")
      ap number
      tokens << number
    end
    query = query.split(" ")
    tokens = query + tokens
    tokens.delete_if {|x| x.size <= 2}
    if tokens.size > 0
      terms = tokens.join("* +*").insert(0, "+*") + "*"
      sql = "SELECT * FROM contacts WHERE MATCH(name, line1, line2, city, state, zip_number, phone_number) AGAINST (? IN BOOLEAN MODE) ORDER BY name ASC"
      contacts = self.paginate_by_sql([sql,terms],page: params[:page])
    else
      contacts = Contact.order(name: :asc).paginate(page: params[:page])
    end
  end
end
