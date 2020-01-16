class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name
    self.artist.name if self.artist
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
    self.save
  end


  def genre=(id)
    self.genre_id = id.to_i
  end
  
  def note_contents
    self.notes.collect(&:content)
    #self.notes.collect do |note|
    #note.content
    #end 
  end

  def note_contents=(note_contents)
    note_contents.each do |content|
      unless content.empty?
        self.notes << Note.create(content: content)
        self.save
      end
    end
  end

end
