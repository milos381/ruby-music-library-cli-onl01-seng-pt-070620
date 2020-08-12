module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect{|song| song.name == name}
    end
    def find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name) #why does this work but not the other one
    end
  end
end
