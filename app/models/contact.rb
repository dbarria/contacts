class Contact < ApplicationRecord
  before_save do
    self.phone_number = self.phone.tr("()-.+ ", "")
  end
  self.per_page = 30
  def self.search(params)
    # query = "%#{params[:query]}%"
    query = params[:query]
    query = query.tr("()-.+", "")
    query = query.split(" ").join("* +*").insert(0, "+*") + "*"
    sql = "SELECT * FROM contacts WHERE MATCH(name, line1, line2, city, state, zip, phone_number) AGAINST (? IN BOOLEAN MODE) ORDER BY name ASC"
    contacts = query ? self.paginate_by_sql([sql,query],page: params[:page]) : all
  end
end
