[![Build Status](https://travis-ci.org/gurix/clinical_process_diagnostics.svg?branch=master)](https://travis-ci.org/gurix/clinical_process_diagnostics)
[![Code Climate](https://codeclimate.com/github/gurix/clinical_process_diagnostics.png)](https://codeclimate.com/github/gurix/clinical_process_diagnostics)

# Clinical Process Diagnostics
Clinical process diagnostics helps to track the progress over time during a psychotherapie treatment. Clients rate each session afterwards by filling out a survey on a computer or tablet. Each therapist gets a notification when a client rated a session. The notification includes the link to an profile including changes of rating over time.

At the moment, we only support german language. Depending on the age, session report scale or children session report scale will be displayed.

![swiss made software](https://raw.githubusercontent.com/gurix/helena/master/app/assets/images/helena/swissmadesoftware.png "swiss made software")

## Requirements
* Rails (5 or higher)
* Mongoid (6.0.0 or higher)
* MongoDB (2.6 or higher)

# Installation

```
git clone https://github.com/gurix/clinical_process_diagnostics.git
cd clinical_process_diagnostics
bundle install
rake db:seed # optional
rails s
open http://127.0.0.1:3000
```

That's all :-D

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

[Markus Graf markus.graf@zhaw.ch](mailto: markus.graf@zhaw.ch)

## License

Clinical process diagnostics helps to track the progress over time during a psychotherapie treatment.
Copyright (C) 2016 IAP Institute of Applied Psychology, Markus Graf <markus.graf@zhaw.ch>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
