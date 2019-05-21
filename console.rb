require('pry')
require_relative('models/property.rb')

property1 = Property.new(
  {
  'address' => '26 Trehendry',
  'value' => 1000000,
  'number_of_bedrooms' => 1,
  'year_built' => 2019
}
)

property2 = Property.new(
  {
  'address' => '87 Wilton Street',
  'value' => 22,
  'number_of_bedrooms' => 10,
  'year_built' => 1887
  }
)
Property.delete_all()
property1.save()
property2.save()
property1.value = 15000000
property1.update()
# property2.delete()
binding.pry
nil
# Property.find(1)
# Property.find_by_address('87 Wilton Street')
