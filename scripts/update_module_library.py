#!/usr/bin/env python3

import requests
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-t", "--template", type=str, default="")
parser.add_argument("-o", "--output", type=str, default="module-library.md")
args = parser.parse_args()
templatePath = args.template
outputPath = args.output

####################################################################################
# Get all repos in org "equinor" with topic "terraform-baseline"
####################################################################################

githubOrg = "equinor"
githubTopic = "terraform-baseline"

url = "https://api.github.com/search/repositories?q=org:{org} topic:{topic}".format(
    org=githubOrg, topic=githubTopic
)
response = requests.get(url)
responseJson = response.json()
repos = responseJson.get("items")

####################################################################################
# Create Markdown table containing all Terraform Baseline modules
####################################################################################

rows = []
columnSeparator = " | "
rowSeparator = "\n"

dict = {
    "Module": "{moduleName}",
    "Repository": "[{repoName}]({repoUrl})",
    "Latest release": "{latestRelease}",
}

columns = dict.keys()
rows.append(columnSeparator.join(columns))
rows.append(columnSeparator.join(["---"] * (len(columns))))

row = columnSeparator.join(dict.values())

for repo in repos:
    repoName = repo.get("name", "N/A")
    moduleName = repoName.replace("terraform-azurerm-", "")
    repoUrl = repo.get("html_url", "N/A")
    latestRelease = repo.get("latest_release", "N/A")

    rows.append(
        row.format(
            moduleName=moduleName,
            repoName=repoName,
            repoUrl=repoUrl,
            latestRelease=latestRelease,
        )
    )

table = rowSeparator.join(rows)

####################################################################################
# Create Markdown file containing table
####################################################################################

if len(templatePath) != 0:
    with open(templatePath, "r") as templateFile:
        markdownTemplate = templateFile.read()
        templateFile.close()
else:
    # Fall back on simple template with header and table
    markdownTemplate = "# Module library\n\n{markdownTable}\n"

with open(outputPath, "w") as outputFile:
    outputFile.write(markdownTemplate.format(markdownTable=table))
    outputFile.close()
