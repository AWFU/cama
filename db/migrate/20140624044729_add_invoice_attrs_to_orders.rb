class AddInvoiceAttrsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :invoice_type, :string
    add_column :orders, :invoice_companynum, :string
    add_column :orders, :invoice_title, :string
  end
end
