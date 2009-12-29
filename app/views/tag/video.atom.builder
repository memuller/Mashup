atom_feed do |feed|
  feed.title("video | Mashup Cancanova")
  feed.updated(@entries.first[4])

  @entries.each do |post|
    feed.entry(post, :url => post[5], :published => post[4], :updated => post[4]) do |entry|
      entry.title(post[2])
      entry.content( image_tag(post[6])+" "+post[3]+"<p>Mashup.cancaonova.com</p>", :type => 'html')

      entry.author do |author|
        author.name("Mashup Canção Nova")
      end
    end
  end
end