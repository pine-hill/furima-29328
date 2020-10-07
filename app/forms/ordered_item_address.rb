class OrderedItemAddress
  include ActiveModel::Model
  attr_accessor :user_id ,:item_id ,:post_code ,:prefecture_id ,
    :city ,:block ,:building_name ,:phone_number,:token

  with_options presence: true do
    validates :prefecture_id, :city, :block, :token
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/}
  end

  def save
    ordered_item = OrderedItem.create(user_id:user_id,item_id:item_id)
    Address.create(post_code: post_code ,prefecture_id: prefecture_id ,city: city ,
      block: block ,building_name: building_name ,
      phone_number: phone_number,ordered_item_id: ordered_item.id)
  end
end