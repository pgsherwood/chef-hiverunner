# hiverunner-cookbook

Installs the [Hive Runner](https://github.com/bellycard/hiverunner) python script and its dependencies and creates cron jobs to run the script hourly, daily, and weekly.

## Supported Platforms

Ubuntu 12.04

## Requirements

### APT Packages
- python
- python-pip
- python-virtualenv
- libmysqlclient-dev
- python-dev

### PIP Packages
- hiverunner 

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hiverunner']['install_dir']</tt></td>
    <td>String</td>
    <td>The installation directory for hiverunner and the associated python virtualenv</td>
    <td><tt>/usr/local/hiverunner</tt></td>
  </tr>
</table>

## Usage

### hiverunner::default

Include `hiverunner` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[hiverunner::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Greg Sherwood (pgscode@gmail.com)
