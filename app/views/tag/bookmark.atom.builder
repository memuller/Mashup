atom_feed do |feed|
  feed.title("bookmark | Mashup Cancanova")
  feed.updated(@entries.first[4])

  @entries.each do |post|
    feed.entry(post, :url => post[5], :published => post[4], :updated => post[4]) do |entry|
      entry.title(post[2])
      entry.content(post[3], :type => 'html')

      entry.author do |author|
        author.name("Mashup Canção Nova")
      end
    end
  end
end
