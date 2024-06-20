module AlchemyI18n
  class Engine < ::Rails::Engine
    initializer "alchemy-i18n" do |app|
      locales = Array(app.config.i18n.available_locales).reject { |l| l == :en }
      pattern = locales.empty? ? "*" : "{#{locales.join ","}}"
      files = Dir[root.join("locales", "alchemy.#{pattern}.yml")]
      I18n.load_path.concat(files)
      Alchemy.importmap.pin_all_from File.expand_path("../../vendor/locales/", __dir__),
        under: "alchemy_i18n",
        preload: true
      app.config.assets.precompile << "alchemy_i18n.js"
      locales.each do |locale|
        Alchemy.admin_js_imports << "alchemy_i18n/flatpickr.#{locale}.js"
      end
    end
  end
end
