class Topic < ActiveRecord::Base
  validates:content,presence:true,length:{maximum: 350}
end
