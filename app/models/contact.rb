class Contact < ApplicationRecord

  def self.search(params)
    # query = "%#{params[:query]}%"
    query = params[:query]
    query = query.split(" ").join(" +").insert(0, "+")
    contacts = all
    # contacts = self.where("name LIKE ? OR line1 LIKE ? OR line2 LIKE ? OR phone LIKE ?",query, query, query, query) if query
      contacts = self.paginate_by_sql(["SELECT * FROM contacts WHERE MATCH(name, line1, line2, city, state, zip, phone) AGAINST (? IN BOOLEAN MODE) ORDER BY name ASC",query],page: params[:page], per_page: 30) if query
  end
end
