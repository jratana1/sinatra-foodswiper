module Slugifiable
  module InstanceMethods
    def slug
      name = self.name
      slug = name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|object| object.slug == slug}
    end

    def format_slug_beginning
      slug_beginning = @slug.split("-")[0]
      slug_beginning.prepend("%")
      slug_beginning << "%"
      @short_slug = slug_beginning
    end
  end
end