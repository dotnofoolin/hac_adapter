# HacAdapter

HAC Adapter scrapes grades from the interface your school provides (Home Access Center / eSchool) and returns them in a programmatically usable format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hac_adapter', git: 'https://github.com/dotnofoolin/hac_adapter.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hac_adapter

## Usage

Create a hash containing the URL given to you (e.g 'https://hac40.esp.k12.ar.us/HomeAccess40'), the school name (from the dropdown on the login page), your username, and password. Note that the URL is picky. The example shown is the best format. Login to your HAC account to determine the URL.

```ruby
params = {url: "URL", school: "STRING NAME OF SCHOOL", username: "USERNAME", password: "PASSWORD"}
```

To get an array containing all students and all their reports, use `all_reports`.

```ruby
results = HacAdapter.all_reports(params)
```

`all_reports` returns this data structure:

```ruby
[
  {
    student_name: '', 
    student_id: '',
    classes: [
      {
        class_name: '',
        last_update: '',
        average: '',
        assignments: [
          {
            due_date: '',
            date_assigned: '',
            assignment_name: '',
            category: '',
            score: '',
            total_points: ''
          }
        ]
      }
    ]
  }
]
```

For "Right Now™" results, try out `all_ascii_reports` for some fancy ASCII tables.

```ruby
puts HacAdapter.all_ascii_reports(params)
```

`all_ascii_reports` returns a string that you can `puts`:

```
+-------------------------+---------+-------------+
|                   Student Name                  |
+-------------------------+---------+-------------+
| Class                   | Average | Last Update |
+-------------------------+---------+-------------+
| English                 | 70.00   | 9/7/2017    |
| Math                    | 88.71   | 9/15/2017   |
| Reading                 | 96.52   | 9/21/2017   |
+-------------------------+---------+-------------+
```


## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dotnofoolin/hac_adapter.

Any PR's should have 100% test coverage.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
