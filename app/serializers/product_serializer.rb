class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price,:category_name#:data

  def category_name
  	Category.find(object.category_id).try(:name)
  end
  #def data
  #	data = object.id, object.name, object.price, category_name
  #end
end
