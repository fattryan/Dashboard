class Quarter < ActiveRecord::Base
  
    belongs_to:client

    # Automatically total the aualified and taxable savings fields and insert them into the :total column    
    before_save :total_savings
    
    def total_savings
      self.total_savings = self.qualified_savings + self.taxable_savings
    end
    
    # Automatically calculate the savings rate based on total savings and income fields
    before_save :personal_savings_rate
    
    def personal_savings_rate
      self.personal_savings_rate = (self.total_savings.to_f*4 / self.income)*100
    end

end
