class Tag < ApplicationRecord
  enum plan: { free: 1, standard: 2, premium: 3 }
end
