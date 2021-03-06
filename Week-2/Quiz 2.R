# Question 1
library(httr)
# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
# if you register your own application on Github and got Client ID and Client Secret already,
# it's fine to skip this step to find OAth

oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
# Use any URL you would like for the homepage URL (http://github.com is fine)
# and http://localhost:1410 as the callback url

# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
# it means here it should set 3 parameters
myapp <- oauth_app("github", "your Client ID on your Github application page","Client Secret")

# 3. Get OAuth credentials
# if here pop up error, maybe it needed to import more package into R
# look at the error message
# it should looks like this:
#Use a local file to cache OAuth access credentials between R sessions?
#1: Yes
#2: No

#Selection: 1
#Adding .httr-oauth to .gitignore
#Waiting for authentication in browser...
#Press Esc/Ctrl + C to abort
#Authentication complete.
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
# get the repo weblink: https://api.github.com/users/jtleek/repos using token
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output<-content(req)

list(output[[5]]$name, output[[5]]$created_at)
# get answer:
#[[1]]
#[1] "datasharing"

#[[2]]
#[1] "2013-11-07T13:25:07Z"

# I found with JSON way, it's no need to repeat the steps above, 
#just with lines below to find the answer for this question
# How to get a dateframe and subset with this dataframe
> library(jsonlite)
> jsondata<-fromJSON("https://api.github.com/users/jtleek/repos")
> class(jsondata)
[1] "data.frame"
> jsondata$created_at[jsondata$name=="datasharing"]
[1] "2013-11-07T13:25:07Z"

#Question 2
