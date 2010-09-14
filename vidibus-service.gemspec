# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vidibus-service}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Pankratz"]
  s.date = %q{2010-09-14}
  s.description = %q{Description...}
  s.email = %q{andre@vidibus.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".bundle/config",
     ".document",
     ".gitignore",
     ".rspec",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/models/service.rb",
     "config/locales/en.yml",
     "config/routes.rb",
     "lib/vidibus-service.rb",
     "lib/vidibus/service.rb",
     "lib/vidibus/service/client.rb",
     "lib/vidibus/service/connector_app.rb",
     "lib/vidibus/service/controller_validations.rb",
     "lib/vidibus/service/mongoid.rb",
     "spec/spec_helper.rb",
     "spec/vidibus/service/client_spec.rb",
     "spec/vidibus/service/connector_app_spec.rb",
     "spec/vidibus/service/controller_validations_spec.rb",
     "spec/vidibus/service/mongoid_spec.rb",
     "spec/vidibus/service_spec.rb",
     "vidibus-service.gemspec"
  ]
  s.homepage = %q{http://github.com/vidibus/vidibus-service}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provides tools for Vidibus services}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/vidibus/service/client_spec.rb",
     "spec/vidibus/service/connector_app_spec.rb",
     "spec/vidibus/service/controller_validations_spec.rb",
     "spec/vidibus/service/mongoid_spec.rb",
     "spec/vidibus/service_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0.0.beta.17"])
      s.add_runtime_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-uuid>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-secure>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-validate_uri>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<mongoid>, ["~> 2.0.0.beta.17"])
      s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_dependency(%q<vidibus-uuid>, [">= 0"])
      s.add_dependency(%q<vidibus-secure>, [">= 0"])
      s.add_dependency(%q<vidibus-validate_uri>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 2.0.0.beta.17"])
    s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
    s.add_dependency(%q<vidibus-uuid>, [">= 0"])
    s.add_dependency(%q<vidibus-secure>, [">= 0"])
    s.add_dependency(%q<vidibus-validate_uri>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end

