# Create some articles with expected keys to be found

prepositions = [ "how", "do" , "to" "I", "you"]
verbs = [ "signup", "signin", "cancel", "explode", "hire" ]

Article.destroy_all
30.times do
  Article.create(title: prepositions.sample + "  " + verbs.sample, body: "")
end
