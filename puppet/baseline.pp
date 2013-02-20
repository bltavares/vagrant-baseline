stage {
  'bootstrap':
    before => Stage['main']
    ;
}


node default {
  include baseline
}
