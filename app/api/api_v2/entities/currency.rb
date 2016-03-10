module APIv2
  module Entities
    class Currency < Base
      expose :id
      expose :key
      expose :code
      expose :symbol
      expose :coin
    end
  end
end
