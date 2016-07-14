name             'javaserver'
maintainer       'Ron Bogdanoff'
maintainer_email 'ron.bogdanoff@gmail.com'
license          'apachev2'
description      'Installs/Configures a javaserver'
long_description 'Installs/Configures a javaserver'
version          '0.1.0'

supports         'ubuntu'

depends          'apt'
depends          'java', '~> 1.40'
depends          'tomcat', '~> 2.3.1'
depends          'nginx', '~> 2.7.5'


issues_url       'https://github.com/rbogdanoff/javaserver-cookbook/issues'
source_url       'https://github.com/rbogdanoff/javaserver-cookbook'