[![ruby version](https://img.shields.io/badge/ruby-v3.2.2-blue.svg)](https://www.ruby-lang.org/en/downloads/)

# Job Match Recommendation Engine Coding Challenge

# Description

The goal of the engine is to suggest jobs to jobseekers based on their skills and the required skills for each job.

# Run project locally

Install ruby v3.2.2

Install requiered gems by running:
```
bundle install
```

Place `jobs.csv` and `jobseekers.csv` files into `seed_data` directory

Run script:
```
ruby recommendation_engine.rb
```

Check out the results in `results.csv` file


# Run Rspec
```
rspec spec
```

# Run Rubocop
```
rubocop
```
