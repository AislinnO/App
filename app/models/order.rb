class Order < ActiveRecord::Base
attr_accessor:order_name
has_many:items
end
