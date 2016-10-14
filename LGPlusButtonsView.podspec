Pod::Spec.new do |s|

    s.name = 'DNVFloatingMenuButtonsView'
    s.version = '1.2.0'
    s.platform = :ios, '6.0'
    s.license = 'MIT'
    s.homepage = 'https://github.com/DnV1eX/DNVFloatingMenuButtonsView'
    s.author = { 'Alexey Demin' => 'dnv1ex@ya.ru' }
    s.source = { :git => 'https://github.com/DnV1eX/DNVFloatingMenuButtonsView.git', :tag => s.version }
    s.summary = 'iOS implementation of Floating Action Button (Google Plus Button, fab), that shows more options'

    s.requires_arc = true

    s.source_files = 'LGPlusButtonsView/*.{h,m}'

end
