from distutils.core import setup, Extension

sleepless = Extension('sleepless',
                      sources = ['sleepless.c', 'sleeplesspy.c'],
                      extra_link_args = ['-framework', 'CoreFoundation',
                                         '-framework', 'ApplicationServices',
                                         '-framework', 'Cocoa']
                     )

setup(name = 'sleepless',
      version = '1.0',
      description = 'Keep OSX awake by setting power assertions',
      ext_modules = [sleepless]
     )
