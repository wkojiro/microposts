class AddOriginToMicropost < ActiveRecord::Migration
  def change
    add_reference :microposts, :origin, index: true
  end
end
