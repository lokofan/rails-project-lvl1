# Пример использования
```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user do |f|
# Проверяет есть ли значение внутри name
f.input :name
# Проверяет есть ли значение внутри job
f.input :job, as: :text
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea cols="20" rows="40" name="job">hexlet</textarea>
# </form>
```

![hexlet-check](https://github.com/lokofan/rails-project-lvl1/actions/workflows/hexlet-check.yml/badge.svg)
![CI](https://github.com/lokofan/rails-project-lvl1/actions/workflows/ci.yml/badge.svg)