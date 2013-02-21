puppet-avahi
============

A puppet module to manage and install avahi in RedHat and Debian based servers.

It can manage the iptables firewall to open avahi ports using the puppetlabs-firewall module.

To install avahi packages and start the service:

	  class { 'avahi':
	    firewall => true
	  }

License
-------

	  Copyright 2012 MaestroDev
	
	  Licensed under the Apache License, Version 2.0 (the "License");
	  you may not use this file except in compliance with the License.
	  You may obtain a copy of the License at
	
	      http://www.apache.org/licenses/LICENSE-2.0
	
	  Unless required by applicable law or agreed to in writing, software
	  distributed under the License is distributed on an "AS IS" BASIS,
	  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	  See the License for the specific language governing permissions and
	  limitations under the License.
