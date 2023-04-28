class RoseStatus < ApplicationRecord
      enum status: { peak: 0, budding: 1, blooming: 2, dormant: 3 }
      belongs_to :rose
end
