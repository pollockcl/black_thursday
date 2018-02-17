# This is the Merchant class
class Merchant
  attr_reader :id, :name
  def initialize(id, name, parent)
    @id     = id
    @name   = name
    @parent = parent
  end

  def items
    @parent.parent.items.find_by_id(@id)
  end
end
