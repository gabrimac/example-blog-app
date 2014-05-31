class AddColumnPublicationDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publication_date, :Date
  end
end
