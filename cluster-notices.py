#!/usr/bin/env python3

import re
import urllib.request, urllib.error
import subprocess

def indent_string(indenter, string):
    string = indenter + string
    string = string.replace('\n',"\n"+indenter)
    return string

url = 'https://unity.rc.umass.edu/api/notices/'
response = urllib.request.urlopen(url)
content = response.read().decode('UTF-8')

content = content.replace('/n','')
content = content.replace('</a>','')
content = content.replace('<p>','')
content = content.replace('</p>','')
content = content.replace('&nbsp;',' ')
content = content.replace('<strong>','')
content = content.replace('</strong>','')
content = re.sub('<a[^>]*>', '', content)

# `fmt` doesn't do a good job with the whole notice so I need to
# isolate the date and title and `fmt` only the body

# at this point there is an empty line between each notice
notices = re.split('\n[\s]*\n', content)

# optional - only show the latest notice
notices = [notices[0]]

for notice in notices:
    # if notice is just whitespace
    if re.match("^[\s]*$", notice):
        continue
    lines = notice.splitlines()
    title = lines[0]
    date = lines[1]
    body_unformatted = '\n'.join(lines[2:])
    format_body_process = subprocess.run(f"echo '{body_unformatted}' | fmt",
        capture_output=True, shell=True)
    body = str(format_body_process.stdout, 'UTF-8') # stdout is a bytes object
    #print(f"{title}\t\t\t{date}")
    print(date)
    print(title)
    print(indent_string("  ", body))
