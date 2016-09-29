class Contact < ApplicationRecord
  before_save do
    self.phone_number = self.phone.tr("()-.+ ", "")
  end
  def self.search(params)
    # query = "%#{params[:query]}%"
    query = params[:query]
    query = query.tr("()-.+", "")
    query = query.split(" ").join("* +*").insert(0, "+*") + "*"
    contacts = all
    # contacts = self.where("name LIKE ? OR line1 LIKE ? OR line2 LIKE ? OR City LIKE ? OR State LIKE ? OR zip LIKE ? OR phone_number LIKE ?",query, query, query, query, query, query, query).paginate(page: params[:page], per_page: 30) if query
    contacts = self.paginate_by_sql(["SELECT * FROM contacts WHERE MATCH(name, line1, line2, city, state, zip, phone_number) AGAINST (? IN BOOLEAN MODE) ORDER BY name ASC",query],page: params[:page], per_page: 30) if query
  end
end
