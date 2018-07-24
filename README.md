Checkout project 
 
```bash 
https://github.com/pyavchik/remoteWDCapybara.git
```

Install TrueAutomation Client
https://trueautomation.io/docs/#/install-client

Run command to initialize your project

```bash
trueautomation init
```
TO LAUNCH chromedriver

```bash
environment/chromedriver -port=3333
```
TO LAUNCH geckodriver

```bash
environment/geckodriver
```
TO LAUNCH edgedriver

```bash
environment/MicrosoftWebDriver.exe
```

TO RUN TEST with chromedriver

```bash
webdriver=chrome rspec spec/test_scenario/trueautomation_spec.rb 
```
TO RUN TEST with geckodriver
```bash
webdriver=firefox rspec spec/test_scenario/trueautomation_spec.rb 
```

TO RUN TEST with safaridriver

```bash
webdriver=safari rspec spec/test_scenario/trueautomation_spec.rb 
```
TO RUN TEST with MicrosoftWebDriver (Windows 10 needed)

```bash
set webdriver=edge
rspec spec\test_scenario\trueautomation_spec.rb 
```
TO RUN TEST with appium IOS (appium should be installed and started)

```bash
webdriver=ios rspec spec/test_scenario/trueautomation_spec.rb 
```
TO RUN TEST with appium Android (appium should be installed and started)

```bash
webdriver=android rspec spec/test_scenario/trueautomation_spec.rb 
```

