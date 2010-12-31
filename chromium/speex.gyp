{
  'targets': [
    {
      'target_name': 'libspeex',
      'type': 'settings',
      'direct_dependent_settings': {
        'cflags': [
          '<!@(pkg-config --cflags speex)',	
        ],
      },
      'link_settings': {
        'ldflags': [
          '<!@(pkg-config --libs-only-L --libs-only-other speex)',
        ],
        'libraries': [
          '<!@(pkg-config --libs-only-l speex)',
        ],
      },
    },
  ],
}
