class Note
    include DataMapper::Resource
   
    property :id, Serial
   
    property :content, Text, :required => true, :lazy => false
    property :complete, Boolean, :required => true, :default => false
   
    property :created_at, DateTime
    property :updated_at, DateTime
   
    belongs_to :user
end