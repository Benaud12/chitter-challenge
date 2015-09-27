class Peep

  include DataMapper::Resource

  property :id, Serial
  property :heading, String
  property :message, Text, length: 250

  belongs_to :user

end