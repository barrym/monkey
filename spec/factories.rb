Factory.define :user do |u|
  u.email "barry.mitchelson@gmail.com"
  u.password "password"
  u.name "barrym"
end

Factory.define :folder do |f|
  f.name "My folder"
  f.user { User.first || Factory.create(:user) }
end

Factory.define :thing do |t|
  t.user { User.first || Factory.create(:user) }
  t.folder { Folder.first || Factory.create(:folder) }
end
