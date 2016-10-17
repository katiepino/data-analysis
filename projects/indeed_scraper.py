# -*- coding: utf-8 -*-

# load the library
from bs4 import BeautifulSoup as Soup
import pandas as pd
import urllib


# get a full list of jobs from indeed.com


# indeed.com url
base_url = 'http://www.indeed.com/jobs?q=data+analyst&l=Irvine,+CA&jt=fulltime&sort='
sort_by = 'date'          # sort by date
start_from = '&start='    # start page number

pd.set_option('max_colwidth',500)    # to remove column limit
df = pd.DataFrame({})   # create a new data frame

for page in range(1,101): # page from 1 to 100 (last page we can scrape is 100)
    page = (page-1) * 10  
    url = "%s%s%s%d" % (base_url, sort_by, start_from, page) # get full url 
    target = Soup(urllib.request.urlopen(url), "lxml") 

    targetElements = target.find_all('div', attrs={'data-tn-component' : 'organicJob'})

    # get each specific job information (such as company name, job title, urls, etc)
    for elem in targetElements: 
        comp_name = elem.find('span', attrs={'class':'company'}).getText().strip()
        job_title = elem.find('a', attrs={'class':'turnstileLink'}).attrs['title']
        home_url = "http://www.indeed.com"
        job_link = "%s%s" % (home_url,elem.find('a').get('href'))
        job_addr = elem.find('span', attrs={'class':'location'}).getText()
        job_posted = elem.find('span', attrs={'class': 'date'}).getText()
        job_summary = elem.find('span', attrs={'class': 'summary'}).getText()

				# add a job info to our data frame
        df = df.append({'comp_name': comp_name, 'job_title': job_title, 
                        'job_link': job_link, 'job_posted': job_posted,
                        'job_location': job_addr, 'job_summary': job_summary
                       }, ignore_index=True)
df
df_received = df

# print(df_received.iloc[5]) #test data before saving to file; comment out once tested
df_received.to_csv('F:\programs\Anaconda3\data\indeed_companies_irvine_analyst.csv', encoding='utf-8')
