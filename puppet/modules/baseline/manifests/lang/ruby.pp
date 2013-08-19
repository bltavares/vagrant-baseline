define baseline::lang::ruby ($ruby_version = $name) {

  include baseline::lang::ruby-dependencies
  Class[baseline::lang::ruby-dependencies] -> rbenv::build { $ruby_version:  global => true }

}
